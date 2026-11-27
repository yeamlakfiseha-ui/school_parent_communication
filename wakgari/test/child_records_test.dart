import 'package:flutter_test/flutter_test.dart';
import 'package:parentlink/features/school_data/domain/school_record.dart';
import 'package:parentlink/features/school_data/domain/school_repository.dart';

import '../features/parent/domain/child_overview.dart';
import '../features/parent/domain/child_records.dart';

SchoolData _data({
  List<AttendanceRecord> attendance = const [],
  List<GradeRecord> grades = const [],
  List<BehaviorReport> behaviorReports = const [],
  List<CheckInOutRecord> checkIns = const [],
}) => SchoolData(
  attendance: attendance,
  grades: grades,
  behaviorReports: behaviorReports,
  checkInOut: checkIns,
  announcements: const [],
  schedule: const [],
);

AttendanceRecord _attendance(
  String id,
  String studentId,
  DateTime date,
  AttendanceStatus status,
) => AttendanceRecord(
  id: id,
  studentId: studentId,
  date: date,
  status: status,
  recordedBy: 'Ms. Selam',
);

GradeRecord _grade(
  String id,
  String studentId,
  String subject,
  double score,
  DateTime date,
) => GradeRecord(
  id: id,
  studentId: studentId,
  subject: subject,
  score: score,
  term: 'Term 1',
  date: date,
  recordedBy: 'Ms. Selam',
);

BehaviorReport _behavior(
  String id,
  String studentId,
  String status,
  BehaviorSeverity severity,
  DateTime date,
) => BehaviorReport(
  id: id,
  studentId: studentId,
  description: 'Note $id',
  severity: severity,
  status: status,
  date: date,
  reportedBy: 'Ms. Selam',
);

CheckInOutRecord _gate(
  String id,
  String studentId,
  DateTime time, {
  required bool checkedIn,
}) => CheckInOutRecord(
  id: id,
  studentId: studentId,
  checkedIn: checkedIn,
  time: time,
  recordedBy: 'Gate staff',
);

void main() {
  final today = DateTime(2026, 11, 27, 9);

  group('ChildRecords', () {
    test('keeps only the requested child, newest first', () {
      final data = _data(
        attendance: [
          _attendance(
            'a1',
            's-1',
            DateTime(2026, 11, 25),
            AttendanceStatus.present,
          ),
          _attendance(
            'a2',
            's-2',
            DateTime(2026, 11, 26),
            AttendanceStatus.absent,
          ),
          _attendance(
            'a3',
            's-1',
            DateTime(2026, 11, 26),
            AttendanceStatus.late,
          ),
        ],
      );

      final records = ChildRecords.forStudent(data: data, studentId: 's-1');

      expect(records.attendance.map((record) => record.id), ['a3', 'a1']);
      expect(records.isEmpty, isFalse);
    });

    test('records nothing for a student without data', () {
      final records = ChildRecords.forStudent(data: _data(), studentId: 's-9');

      expect(records.isEmpty, isTrue);
      expect(records.sessions, isEmpty);
    });
  });

  group('AttendanceSummary', () {
    test('counts statuses and reports the present rate', () {
      final summary = AttendanceSummary.fromRecords([
        _attendance(
          '1',
          's-1',
          DateTime(2026, 11, 27),
          AttendanceStatus.present,
        ),
        _attendance(
          '2',
          's-1',
          DateTime(2026, 11, 26),
          AttendanceStatus.present,
        ),
        _attendance(
          '3',
          's-1',
          DateTime(2026, 11, 25),
          AttendanceStatus.present,
        ),
        _attendance('4', 's-1', DateTime(2026, 11, 24), AttendanceStatus.late),
        _attendance(
          '5',
          's-1',
          DateTime(2026, 11, 23),
          AttendanceStatus.absent,
        ),
      ]);

      expect(summary.total, 5);
      expect(summary.present, 3);
      expect(summary.late, 1);
      expect(summary.absent, 1);
      expect(summary.ratePercent, 60);
      expect(summary.hasConcern, isTrue);
    });

    test('does not warn on a sample too small to mean anything', () {
      final summary = AttendanceSummary.fromRecords([
        _attendance(
          '1',
          's-1',
          DateTime(2026, 11, 27),
          AttendanceStatus.absent,
        ),
      ]);

      expect(summary.ratePercent, 0);
      expect(summary.hasConcern, isFalse);
    });
  });

  group('SubjectProgress', () {
    test('keeps the latest and previous score per subject', () {
      final progress = SubjectProgress.listFrom([
        _grade('g1', 's-1', 'Mathematics', 90, DateTime(2026, 11, 27)),
        _grade('g2', 's-1', 'English', 70, DateTime(2026, 11, 26)),
        _grade('g3', 's-1', 'Mathematics', 80, DateTime(2026, 11, 20)),
      ]);

      expect(progress.map((subject) => subject.subject), [
        'English',
        'Mathematics',
      ]);
      final math = progress.last;
      expect(math.latest, 90);
      expect(math.previous, 80);
      expect(math.change, 10);
      expect(math.average, 85);
      expect(math.recordCount, 2);
      expect(progress.first.change, isNull);
    });
  });

  group('CheckInSession', () {
    test('pairs arrivals with departures per day', () {
      final sessions = CheckInSession.listFrom([
        _gate('c1', 's-1', DateTime(2026, 11, 27, 7, 42), checkedIn: true),
        _gate('c2', 's-1', DateTime(2026, 11, 27, 15, 20), checkedIn: false),
      ]);

      expect(sessions, hasLength(1));
      expect(sessions.first.checkIn, DateTime(2026, 11, 27, 7, 42));
      expect(sessions.first.checkOut, DateTime(2026, 11, 27, 15, 20));
      expect(sessions.first.duration, const Duration(hours: 7, minutes: 38));
      expect(sessions.first.isOpen, isFalse);
    });

    test('keeps an unclosed arrival open and flags a stray check-out', () {
      final sessions = CheckInSession.listFrom([
        _gate('c1', 's-1', DateTime(2026, 11, 25, 16), checkedIn: false),
        _gate('c2', 's-1', DateTime(2026, 11, 26, 8), checkedIn: true),
        _gate('c3', 's-1', DateTime(2026, 11, 27, 7, 42), checkedIn: true),
        _gate('c4', 's-1', DateTime(2026, 11, 27, 15, 20), checkedIn: false),
      ]);

      expect(sessions, hasLength(3));
      expect(sessions.first.isOpen, isFalse);
      expect(sessions[1].isOpen, isTrue);
      expect(sessions[1].checkOut, isNull);
      expect(sessions.last.isOrphanCheckOut, isTrue);
    });
  });

  group('TodayPresence', () {
    ChildRecords records(List<CheckInOutRecord> checkIns) => ChildRecords(
      attendance: const [],
      grades: const [],
      behaviorReports: const [],
      checkIns: checkIns,
    );

    test('reports an open arrival as in school', () {
      final presence = TodayPresence.from(
        records: records([
          _gate('c1', 's-1', DateTime(2026, 11, 27, 7, 42), checkedIn: true),
        ]),
        now: today,
      );

      expect(presence.state, PresenceState.inSchool);
      expect(presence.since, DateTime(2026, 11, 27, 7, 42));
    });

    test('reports a closed session as checked out', () {
      final presence = TodayPresence.from(
        records: records([
          _gate('c1', 's-1', DateTime(2026, 11, 27, 7, 42), checkedIn: true),
          _gate('c2', 's-1', DateTime(2026, 11, 27, 15, 20), checkedIn: false),
        ]),
        now: today,
      );

      expect(presence.state, PresenceState.checkedOut);
      expect(presence.since, DateTime(2026, 11, 27, 15, 20));
    });

    test('an absence outranks a gate record', () {
      final records = ChildRecords(
        attendance: [
          _attendance(
            'a1',
            's-1',
            DateTime(2026, 11, 27),
            AttendanceStatus.absent,
          ),
        ],
        grades: const [],
        behaviorReports: const [],
        checkIns: [
          _gate('c1', 's-1', DateTime(2026, 11, 27, 7, 42), checkedIn: true),
        ],
      );

      final presence = TodayPresence.from(records: records, now: today);

      expect(presence.state, PresenceState.absent);
    });

    test('falls back to the register when there is no gate record', () {
      final records = ChildRecords(
        attendance: [
          _attendance(
            'a1',
            's-1',
            DateTime(2026, 11, 27),
            AttendanceStatus.late,
          ),
        ],
        grades: const [],
        behaviorReports: const [],
        checkIns: const [],
      );

      expect(
        TodayPresence.from(records: records, now: today).state,
        PresenceState.late,
      );
      expect(
        TodayPresence.from(
          records: records.copyWithoutAttendance(),
          now: today,
        ).state,
        PresenceState.notMarked,
      );
    });
  });

  group('ChildOverview', () {
    test('explains why a child needs attention', () {
      final records = ChildRecords(
        attendance: [
          _attendance(
            'a1',
            's-1',
            DateTime(2026, 11, 27),
            AttendanceStatus.absent,
          ),
          _attendance(
            'a2',
            's-1',
            DateTime(2026, 11, 26),
            AttendanceStatus.present,
          ),
          _attendance(
            'a3',
            's-1',
            DateTime(2026, 11, 25),
            AttendanceStatus.present,
          ),
          _attendance(
            'a4',
            's-1',
            DateTime(2026, 11, 24),
            AttendanceStatus.present,
          ),
          _attendance(
            'a5',
            's-1',
            DateTime(2026, 11, 23),
            AttendanceStatus.present,
          ),
          _attendance(
            'a6',
            's-1',
            DateTime(2026, 11, 22),
            AttendanceStatus.present,
          ),
        ],
        grades: const [],
        behaviorReports: [
          _behavior(
            'b1',
            's-1',
            'New',
            BehaviorSeverity.high,
            DateTime(2026, 11, 26),
          ),
        ],
        checkIns: const [],
      );

      final overview = ChildOverview.build(
        records: records,
        acknowledgedBehaviorIds: const {},
        now: today,
      );

      expect(overview.needsAttention, isTrue);
      expect(overview.attentionReasons, contains('Absent today'));
      expect(overview.attentionReasons, contains('1 unread behavior note'));
      expect(overview.attentionReasons, contains('Attendance is 83%'));
      expect(overview.unreadConcerns, hasLength(1));
    });

    test('drops an acknowledged concern from the alert list', () {
      final records = ChildRecords(
        attendance: const [],
        grades: const [],
        behaviorReports: [
          _behavior(
            'b1',
            's-1',
            'New',
            BehaviorSeverity.high,
            DateTime(2026, 11, 26),
          ),
        ],
        checkIns: const [],
      );

      final overview = ChildOverview.build(
        records: records,
        acknowledgedBehaviorIds: const {'b1'},
        now: today,
      );

      expect(overview.unreadConcerns, isEmpty);
      expect(overview.attentionReasons, isEmpty);
      expect(overview.needsAttention, isFalse);
    });

    test('classifies follow-ups as concerns and positive notes as praise', () {
      final timeline = BehaviorTimeline([
        _behavior('b1', 's-1', 'Positive note', BehaviorSeverity.low, today),
        _behavior('b2', 's-1', 'Follow-up', BehaviorSeverity.low, today),
        _behavior('b3', 's-1', 'New', BehaviorSeverity.high, today),
      ]);

      expect(timeline.positiveCount, 1);
      expect(timeline.concernCount, 2);
    });

    test('picks strongest and weakest subjects from the latest scores', () {
      final records = ChildRecords(
        attendance: const [],
        grades: [
          _grade('g1', 's-1', 'Mathematics', 88, DateTime(2026, 11, 27)),
          _grade('g2', 's-1', 'English', 94, DateTime(2026, 11, 26)),
          _grade('g3', 's-1', 'Biology', 79, DateTime(2026, 11, 25)),
        ],
        behaviorReports: const [],
        checkIns: const [],
      );

      final overview = ChildOverview.build(
        records: records,
        acknowledgedBehaviorIds: const {},
        now: today,
      );

      expect(overview.strongest?.subject, 'English');
      expect(overview.weakest?.subject, 'Biology');
      expect(overview.averageScore, closeTo(87, 0.01));
    });
  });
}

extension on ChildRecords {
  /// Same records with the register emptied, for the not-marked case.
  ChildRecords copyWithoutAttendance() => ChildRecords(
    attendance: const [],
    grades: grades,
    behaviorReports: behaviorReports,
    checkIns: checkIns,
  );
}
