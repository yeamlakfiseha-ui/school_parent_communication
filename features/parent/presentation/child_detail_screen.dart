import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parentlink/core/widgets/parent_link_widgets.dart';
import 'package:parentlink/features/students/domain/student.dart';
import 'package:parentlink/features/students/presentation/students_provider.dart';

import '../domain/child_overview.dart';
import 'formatting.dart';
import 'parent_providers.dart';
import 'widgets/attendance_summary_card.dart';
import 'widgets/behavior_note_card.dart';
import 'widgets/check_in_session_tile.dart';
import 'widgets/parent_states.dart';
import 'widgets/presence_chip.dart';
import 'widgets/subject_progress_tile.dart';

/// One child, with attendance, grades, behavior and gate times side by side.
///
/// The child is resolved from the parent's linked children, never from the
/// whole student list, so an id the parent does not own shows a locked state
/// instead of another family's records.
class ChildDetailScreen extends ConsumerWidget {
  const ChildDetailScreen({
    super.key,
    required this.studentId,
    required this.onOpenChild,
    this.onBack,
  });

  final String studentId;
  final ValueChanged<String> onOpenChild;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = ref.watch(parentChildrenProvider);
    return children.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ParentErrorState(
        message: '$error',
        onRetry: () => ref.invalidate(studentsProvider),
      ),
      data: (students) {
        final student = _find(students, studentId);
        if (student == null) {
          return ChildNotLinked(
            onBack: onBack ?? () => Navigator.maybePop(context),
          );
        }
        final overview = ref.watch(childOverviewProvider(student.id));
        final sessions = overview.records.sessions;
        return DefaultTabController(
          length: 4,
          child: Column(
            children: [
              _ChildHeader(
                student: student,
                siblings: students,
                overview: overview,
                onOpenChild: onOpenChild,
              ),
              TabBar(
                isScrollable: true,
                tabs: [
                  _TabLabel('Attendance', overview.attendance.total),
                  _TabLabel('Grades', overview.records.grades.length),
                  _TabLabel(
                    'Behavior',
                    overview.records.behaviorReports.length,
                  ),
                  _TabLabel('Check-in/out', sessions.length),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _AttendanceTab(overview: overview),
                    _GradesTab(overview: overview),
                    _BehaviorTab(overview: overview),
                    _CheckInTab(overview: overview),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Student? _find(List<Student> children, String id) {
  for (final child in children) {
    if (child.id == id) return child;
  }
  return null;
}

class _ChildHeader extends StatelessWidget {
  const _ChildHeader({
    required this.student,
    required this.siblings,
    required this.overview,
    required this.onOpenChild,
  });

  final Student student;
  final List<Student> siblings;
  final ChildOverview overview;
  final ValueChanged<String> onOpenChild;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26,
                child: Text(
                  initials(student.name),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${student.grade} · Section ${student.section}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    PresenceChip(presence: overview.presence),
                  ],
                ),
              ),
            ],
          ),
          if (siblings.length > 1) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final sibling in siblings)
                  ChoiceChip(
                    label: Text(sibling.name.split(' ').first),
                    selected: sibling.id == student.id,
                    onSelected: (_) {
                      if (sibling.id != student.id) onOpenChild(sibling.id);
                    },
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel(this.label, this.count);

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tab(
      height: 46,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '$count',
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceTab extends StatelessWidget {
  const _AttendanceTab({required this.overview});

  final ChildOverview overview;

  @override
  Widget build(BuildContext context) {
    final records = overview.records.attendance;
    if (records.isEmpty) {
      return const EmptyTabState(
        icon: Icons.event_available_outlined,
        title: 'No attendance yet',
        message:
            "Attendance appears here as soon as your child's teacher marks "
            'the register.',
      );
    }
    return ListView(
      padding: const EdgeInsets.only(top: 2, bottom: 20),
      children: [
        AttendanceSummaryCard(summary: overview.attendance),
        const SectionHeading('Recent marks'),
        for (final record in records)
          _RecordTile(
            icon: Icons.event_available_outlined,
            tint: attendanceColor(context, record.status),
            title: record.status.label,
            subtitle: '${fullDate(record.date)} · ${record.recordedBy}',
            trailing: Text(
              record.status.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: attendanceColor(context, record.status),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}

class _GradesTab extends StatelessWidget {
  const _GradesTab({required this.overview});

  final ChildOverview overview;

  @override
  Widget build(BuildContext context) {
    final records = overview.records.grades;
    if (records.isEmpty) {
      return const EmptyTabState(
        icon: Icons.menu_book_outlined,
        title: 'No grades yet',
        message:
            'Scores appear here after a teacher records them. Ask the teacher '
            'in Messages if you expected a result.',
      );
    }
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final strongest = overview.strongest;
    final weakest = overview.weakest;
    return ListView(
      padding: const EdgeInsets.only(top: 2, bottom: 20),
      children: [
        Card(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${overview.averageScore.toStringAsFixed(0)}%',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        'latest average',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${overview.subjects.length} '
                      '${overview.subjects.length == 1 ? 'subject' : 'subjects'}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                if (strongest != null && weakest != null) ...[
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _SubjectNote(
                        label: 'Strongest',
                        subject: strongest.subject,
                        color: scheme.primary,
                      ),
                      if (weakest.subject != strongest.subject)
                        _SubjectNote(
                          label: 'Needs practice',
                          subject: weakest.subject,
                          color: scheme.tertiary,
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
        const SectionHeading('By subject'),
        for (final subject in overview.subjects)
          SubjectProgressTile(progress: subject),
        const SectionHeading('All grade records'),
        for (final record in records)
          _RecordTile(
            icon: Icons.menu_book_outlined,
            title: record.subject,
            subtitle: '${record.term} · ${fullDate(record.date)}',
            trailing: Text(
              '${record.score.toStringAsFixed(0)}%',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}

class _SubjectNote extends StatelessWidget {
  const _SubjectNote({
    required this.label,
    required this.subject,
    required this.color,
  });

  final String label;
  final String subject;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      '$label · $subject',
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: color,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _BehaviorTab extends ConsumerWidget {
  const _BehaviorTab({required this.overview});

  final ChildOverview overview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = overview.records.behaviorReports;
    if (records.isEmpty) {
      return const EmptyTabState(
        icon: Icons.favorite_border,
        title: 'No behavior notes',
        message:
            'Positive notes and follow-ups from teachers will appear here. '
            'Nothing has been recorded for this child yet.',
      );
    }
    final theme = Theme.of(context);
    final acknowledged = ref.watch(acknowledgedBehaviorProvider);
    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            '${overview.behavior.positiveCount} positive · '
            '${overview.behavior.concernCount} to follow up',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        for (final report in records)
          BehaviorNoteCard(
            report: report,
            acknowledged: acknowledged.contains(report.id),
            onAcknowledge: () => ref
                .read(acknowledgedBehaviorProvider.notifier)
                .acknowledge(report.id),
          ),
      ],
    );
  }
}

class _CheckInTab extends StatelessWidget {
  const _CheckInTab({required this.overview});

  final ChildOverview overview;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sessions = overview.records.sessions;
    return ListView(
      padding: const EdgeInsets.only(top: 12, bottom: 20),
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Right now',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                PresenceChip(presence: overview.presence),
              ],
            ),
          ),
        ),
        if (sessions.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: EmptyTabState(
              icon: Icons.qr_code_scanner,
              title: 'No gate records yet',
              message:
                  'Check-in and check-out times show up here after staff scan '
                  "your child's card at the gate.",
            ),
          )
        else ...[
          const SectionHeading('Gate sessions'),
          for (final session in sessions) CheckInSessionTile(session: session),
        ],
      ],
    );
  }
}

class _RecordTile extends StatelessWidget {
  const _RecordTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.tint,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final Color? tint;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: tint?.withValues(alpha: 0.12),
        child: Icon(icon, size: 19, color: tint),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing,
    ),
  );
}
