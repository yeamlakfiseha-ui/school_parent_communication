// Parent-side views over one child's school records.
//
// Kept free of widgets so the tab screens stay thin and these rules can be
// unit tested: record scoping, attendance summaries, subject trends and gate
// sessions are all derived here instead of inside `build()` methods.

import 'package:parentlink/features/school_data/domain/school_record.dart';
import 'package:parentlink/features/school_data/domain/school_repository.dart';

/// One child's records, newest first, copied out of [SchoolData].
///
/// A parent only ever sees the child they are linked to, so every list here is
/// scoped to a single [studentId] before it reaches a widget.
class ChildRecords {
  const ChildRecords({
    required this.attendance,
    required this.grades,
    required this.behaviorReports,
    required this.checkIns,
  });

  factory ChildRecords.forStudent({
    required SchoolData data,
    required String studentId,
  }) => ChildRecords(
    attendance: _newestFirst(
      data.attendance.where((record) => record.studentId == studentId),
      (record) => record.date,
    ),
    grades: _newestFirst(
      data.grades.where((record) => record.studentId == studentId),
      (record) => record.date,
    ),
    behaviorReports: _newestFirst(
      data.behaviorReports.where((record) => record.studentId == studentId),
      (record) => record.date,
    ),
    checkIns: _newestFirst(
      data.checkInOut.where((record) => record.studentId == studentId),
      (record) => record.time,
    ),
  );

  final List<AttendanceRecord> attendance;
  final List<GradeRecord> grades;
  final List<BehaviorReport> behaviorReports;
  final List<CheckInOutRecord> checkIns;

  int get totalCount =>
      attendance.length +
      grades.length +
      behaviorReports.length +
      checkIns.length;

  bool get isEmpty => totalCount == 0;

  /// Check-in and check-out records paired into gate sessions, newest first.
  List<CheckInSession> get sessions => CheckInSession.listFrom(checkIns);
}

/// Attendance counts and rate for the records currently available.
class AttendanceSummary {
  const AttendanceSummary({
    required this.present,
    required this.absent,
    required this.late,
    required this.recent,
  });

  factory AttendanceSummary.fromRecords(List<AttendanceRecord> records) =>
      AttendanceSummary(
        present: records
            .where((record) => record.status == AttendanceStatus.present)
            .length,
        absent: records
            .where((record) => record.status == AttendanceStatus.absent)
            .length,
        late: records
            .where((record) => record.status == AttendanceStatus.late)
            .length,
        recent: records.take(10).toList(),
      );

  final int present;
  final int absent;
  final int late;

  /// Up to the ten most recent attendance records, newest first.
  final List<AttendanceRecord> recent;

  int get total => present + absent + late;

  /// Share of days marked present, between 0 and 1.
  double get rate => total == 0 ? 0 : present / total;

  int get ratePercent => (rate * 100).round();

  /// Only warns once there are enough records for the rate to mean something.
  bool get hasConcern => total >= 5 && rate < 0.85;
}

/// Latest score, previous score and average for one subject.
class SubjectProgress {
  const SubjectProgress({
    required this.subject,
    required this.latest,
    required this.previous,
    required this.average,
    required this.recordCount,
  });

  final String subject;
  final double latest;
  final double? previous;
  final double average;
  final int recordCount;

  /// Change since the previous score, or `null` for the first record.
  double? get change => previous == null ? null : latest - previous!;

  /// Builds one entry per subject from grades sorted newest first.
  static List<SubjectProgress> listFrom(List<GradeRecord> newestFirst) {
    final bySubject = <String, List<double>>{};
    for (final grade in newestFirst) {
      bySubject.putIfAbsent(grade.subject, () => []).add(grade.score);
    }
    final progress = bySubject.entries.map((entry) {
      final scores = entry.value;
      return SubjectProgress(
        subject: entry.key,
        latest: scores.first,
        previous: scores.length > 1 ? scores[1] : null,
        average: scores.reduce((a, b) => a + b) / scores.length,
        recordCount: scores.length,
      );
    }).toList()..sort((a, b) => a.subject.compareTo(b.subject));
    return progress;
  }
}

/// A single arrival at school, paired with the matching departure.
///
/// Either end may be missing: a child still on the school grounds has no
/// check-out yet, and a stray check-out has no check-in.
class CheckInSession {
  const CheckInSession({required this.day, this.checkIn, this.checkOut});

  /// The calendar day of the session, taken from the arrival or departure.
  final DateTime day;
  final DateTime? checkIn;
  final DateTime? checkOut;

  Duration? get duration => checkIn == null || checkOut == null
      ? null
      : checkOut!.difference(checkIn!);

  /// Arrived but not yet checked out.
  bool get isOpen => checkIn != null && checkOut == null;

  /// Check-out recorded without a matching check-in.
  bool get isOrphanCheckOut => checkIn == null;

  /// Pairs records into sessions, newest session first.
  static List<CheckInSession> listFrom(List<CheckInOutRecord> records) {
    final sorted = [...records]..sort((a, b) => a.time.compareTo(b.time));
    final sessions = <CheckInSession>[];
    DateTime? openCheckIn;
    for (final record in sorted) {
      if (record.checkedIn) {
        if (openCheckIn != null) {
          sessions.add(CheckInSession(day: openCheckIn, checkIn: openCheckIn));
        }
        openCheckIn = record.time;
      } else if (openCheckIn != null) {
        sessions.add(
          CheckInSession(
            day: openCheckIn,
            checkIn: openCheckIn,
            checkOut: record.time,
          ),
        );
        openCheckIn = null;
      } else {
        sessions.add(CheckInSession(day: record.time, checkOut: record.time));
      }
    }
    if (openCheckIn != null) {
      sessions.add(CheckInSession(day: openCheckIn, checkIn: openCheckIn));
    }
    return sessions.reversed.toList();
  }
}

/// Where the child is today, as far as the records show.
enum PresenceState { notMarked, present, late, inSchool, checkedOut, absent }

/// Today's gate and attendance state for one child.
class TodayPresence {
  const TodayPresence({required this.state, this.since});

  final PresenceState state;

  /// Arrival, departure or marking time that produced [state], when known.
  final DateTime? since;

  factory TodayPresence.from({
    required ChildRecords records,
    required DateTime now,
  }) {
    final today = DateTime(now.year, now.month, now.day);
    AttendanceRecord? attendanceToday;
    for (final record in records.attendance) {
      if (_sameDay(record.date, today)) {
        attendanceToday = record;
        break;
      }
    }
    if (attendanceToday?.status == AttendanceStatus.absent) {
      return const TodayPresence(state: PresenceState.absent);
    }
    for (final session in records.sessions) {
      if (!_sameDay(session.day, today)) continue;
      if (session.isOpen) {
        return TodayPresence(
          state: PresenceState.inSchool,
          since: session.checkIn,
        );
      }
      if (session.checkOut != null) {
        return TodayPresence(
          state: PresenceState.checkedOut,
          since: session.checkOut,
        );
      }
    }
    return TodayPresence(
      state: switch (attendanceToday?.status) {
        AttendanceStatus.present => PresenceState.present,
        AttendanceStatus.late => PresenceState.late,
        _ => PresenceState.notMarked,
      },
    );
  }
}

/// Behavior reports split into positive notes and concerns to follow up.
class BehaviorTimeline {
  const BehaviorTimeline(this.reports);

  final List<BehaviorReport> reports;

  static bool isConcern(BehaviorReport report) =>
      report.severity != BehaviorSeverity.low ||
      report.status.toLowerCase().contains('follow');

  List<BehaviorReport> get concerns => reports.where(isConcern).toList();

  int get concernCount => concerns.length;

  int get positiveCount => reports.length - concernCount;
}

List<T> _newestFirst<T>(Iterable<T> records, DateTime Function(T) dateOf) =>
    records.toList()..sort((a, b) => dateOf(b).compareTo(dateOf(a)));

bool _sameDay(DateTime first, DateTime second) =>
    first.year == second.year &&
    first.month == second.month &&
    first.day == second.day;
