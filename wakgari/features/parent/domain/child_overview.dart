// One-screen summary of a child's current situation.
//
// The parent home card and the child detail header both read this, so the
// rules for what counts as "needs attention" live in one testable place.

import 'package:parentlink/features/school_data/domain/school_record.dart';

import 'child_records.dart';

class ChildOverview {
  const ChildOverview({
    required this.records,
    required this.presence,
    required this.attendance,
    required this.subjects,
    required this.behavior,
    required this.unreadConcerns,
    required this.attentionReasons,
  });

  factory ChildOverview.build({
    required ChildRecords records,
    required Set<String> acknowledgedBehaviorIds,
    required DateTime now,
  }) {
    final attendance = AttendanceSummary.fromRecords(records.attendance);
    final presence = TodayPresence.from(records: records, now: now);
    final subjects = SubjectProgress.listFrom(records.grades);
    final behavior = BehaviorTimeline(records.behaviorReports);
    final unreadConcerns = behavior.concerns
        .where((report) => !acknowledgedBehaviorIds.contains(report.id))
        .toList();
    return ChildOverview(
      records: records,
      presence: presence,
      attendance: attendance,
      subjects: subjects,
      behavior: behavior,
      unreadConcerns: unreadConcerns,
      attentionReasons: [
        if (presence.state == PresenceState.absent) 'Absent today',
        if (presence.state == PresenceState.late) 'Marked late today',
        if (unreadConcerns.isNotEmpty)
          '${unreadConcerns.length} unread behavior '
              '${unreadConcerns.length == 1 ? 'note' : 'notes'}',
        if (attendance.hasConcern) 'Attendance is ${attendance.ratePercent}%',
      ],
    );
  }

  final ChildRecords records;
  final TodayPresence presence;
  final AttendanceSummary attendance;
  final List<SubjectProgress> subjects;
  final BehaviorTimeline behavior;

  /// Concerns the parent has not marked as read yet.
  final List<BehaviorReport> unreadConcerns;

  final List<String> attentionReasons;

  bool get needsAttention => attentionReasons.isNotEmpty;

  bool get hasRecords => !records.isEmpty;

  GradeRecord? get latestGrade =>
      records.grades.isEmpty ? null : records.grades.first;

  SubjectProgress? get strongest => subjects.isEmpty
      ? null
      : subjects.reduce((a, b) => a.latest >= b.latest ? a : b);

  SubjectProgress? get weakest => subjects.isEmpty
      ? null
      : subjects.reduce((a, b) => a.latest <= b.latest ? a : b);

  /// Average of each subject's latest score, or 0 when nothing is recorded.
  double get averageScore => subjects.isEmpty
      ? 0
      : subjects.map((subject) => subject.latest).reduce((a, b) => a + b) /
            subjects.length;
}
