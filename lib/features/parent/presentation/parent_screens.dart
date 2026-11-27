// Generated with Claude, updated with Antigravity (Gemini 4 Hydrogen (High)), reviewed by Tamirat Petros

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/parent_link_widgets.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../school_data/domain/school_record.dart';
import '../../school_data/presentation/school_data_provider.dart';
import '../../students/domain/student.dart';
import '../../students/presentation/students_provider.dart';
import '../../users/presentation/users_provider.dart';

class ParentHomeScreen extends ConsumerWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(schoolDataProvider);
    final students =
        ref.watch(studentsProvider).asData?.value ?? const <Student>[];
    final currentUser = ref.watch(authControllerProvider).asData?.value;
    final linkedChildren = ref.watch(linkedChildrenProvider);
    final linkedId = currentUser == null
        ? null
        : linkedChildren[currentUser.id];
    final visibleStudents = linkedId != null
        ? students.where((student) => student.id == linkedId).toList()
        : students.take(2).toList();

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const PageIntro(
          eyebrow: 'Your family',
          title: 'Good morning',
          subtitle: 'Here is what is happening at school today.',
        ),
        const SectionHeading('Your children'),
        for (final student in visibleStudents)
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  student.name.split(' ').map((part) => part[0]).take(2).join(),
                ),
              ),
              title: Text(
                student.name,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text('${student.grade} · Section ${student.section}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => context.go('/parent/child/${student.id}'),
            ),
          ),
        const SectionHeading('From the school'),
        for (final announcement in data.announcements.take(2))
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.campaign_outlined)),
              title: Text(announcement.title),
              subtitle: Text(
                '${announcement.kind} · ${shortDate(announcement.date)}',
              ),
              isThreeLine: false,
            ),
          ),
      ],
    );
  }
}

class ChildDetailScreen extends ConsumerWidget {
  const ChildDetailScreen({super.key, required this.studentId});
  final String studentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students =
        ref.watch(studentsProvider).asData?.value ?? const <Student>[];
    if (students.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    final student = students.firstWhere(
      (item) => item.id == studentId,
      orElse: () => students.first,
    );
    final data = ref.watch(schoolDataProvider);
    final attendance =
        data.attendance.where((item) => item.studentId == student.id).toList()
          ..sort((a, b) => b.date.compareTo(a.date));
    final grades =
        data.grades.where((item) => item.studentId == student.id).toList()
          ..sort((a, b) => b.date.compareTo(a.date));
    final reports =
        data.behaviorReports
            .where((item) => item.studentId == student.id)
            .toList()
          ..sort((a, b) => b.date.compareTo(a.date));
    final checkIns =
        data.checkInOut.where((item) => item.studentId == student.id).toList()
          ..sort((a, b) => b.time.compareTo(a.time));

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  child: Text(
                    student.name
                        .split(' ')
                        .map((part) => part[0])
                        .take(2)
                        .join(),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text('${student.grade} · Section ${student.section}'),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'View term summary',
                  onPressed: () =>
                      context.go('/parent/child/${student.id}/summary'),
                  icon: const Icon(Icons.auto_awesome_outlined),
                ),
              ],
            ),
          ),
          const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Attendance'),
              Tab(text: 'Grades'),
              Tab(text: 'Behavior'),
              Tab(text: 'Check-in/out'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _recordList(
                  attendance
                      .map(
                        (item) => _RecordLine(
                          icon: Icons.event_available_outlined,
                          title: _statusName(item.status),
                          subtitle:
                              '${fullDate(item.date)} · ${item.recordedBy}',
                          badge: item.status.name,
                        ),
                      )
                      .toList(),
                  empty: 'No attendance recorded yet.',
                ),
                _recordList(
                  grades
                      .map(
                        (item) => _RecordLine(
                          icon: Icons.menu_book_outlined,
                          title: item.subject,
                          subtitle: '${item.term} · ${fullDate(item.date)}',
                          badge: '${item.score.toStringAsFixed(0)}%',
                        ),
                      )
                      .toList(),
                  empty: 'No grades recorded yet.',
                ),
                _recordList(
                  reports
                      .map(
                        (item) => _RecordLine(
                          icon: Icons.favorite_border,
                          title: item.description,
                          subtitle: '${item.status} · ${fullDate(item.date)}',
                          badge: item.severity.name,
                        ),
                      )
                      .toList(),
                  empty: 'No behavior notes yet.',
                ),
                _recordList(
                  checkIns
                      .map(
                        (item) => _RecordLine(
                          icon: item.checkedIn ? Icons.login : Icons.logout,
                          title: item.checkedIn ? 'Checked in' : 'Checked out',
                          subtitle:
                              '${fullDate(item.time)} · ${item.recordedBy}',
                          badge: TimeOfDay.fromDateTime(
                            item.time,
                          ).format(context),
                        ),
                      )
                      .toList(),
                  empty: 'No check-in records yet.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecordLine extends StatelessWidget {
  const _RecordLine({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.badge,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String badge;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    child: ListTile(
      leading: CircleAvatar(child: Icon(icon, size: 19)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(badge, style: Theme.of(context).textTheme.labelLarge),
    ),
  );
}

Widget _recordList(List<Widget> records, {required String empty}) =>
    records.isEmpty
    ? Center(child: Text(empty))
    : ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: records,
      );

String _statusName(AttendanceStatus status) => switch (status) {
  AttendanceStatus.present => 'Present',
  AttendanceStatus.absent => 'Absent',
  AttendanceStatus.late => 'Late',
};

class TermSummaryScreen extends ConsumerWidget {
  const TermSummaryScreen({super.key, required this.studentId});
  final String studentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(schoolDataProvider);
    final students =
        ref.watch(studentsProvider).asData?.value ?? const <Student>[];
    if (students.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    final student = students.firstWhere(
      (item) => item.id == studentId,
      orElse: () => students.first,
    );
    final grades =
        data.grades.where((item) => item.studentId == student.id).toList()
          ..sort((a, b) => b.score.compareTo(a.score));
    final attendance = data.attendance
        .where((item) => item.studentId == student.id)
        .toList();
    final average = grades.isEmpty
        ? 0.0
        : grades.map((item) => item.score).reduce((a, b) => a + b) /
              grades.length;
    final present = attendance
        .where((item) => item.status == AttendanceStatus.present)
        .length;
    final strongest = grades.isEmpty ? 'No grades yet' : grades.first.subject;
    final lowest = grades.isEmpty ? 'No grades yet' : grades.last.subject;
    final behaviorCount = data.behaviorReports
        .where(
          (item) =>
              item.studentId == student.id &&
              item.severity != BehaviorSeverity.low,
        )
        .length;

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const PageIntro(
          eyebrow: 'Term 1 · preview',
          title: 'A quick summary',
          subtitle: 'A plain-language view of the records currently available.',
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Text(
                  '${student.name.split(' ').first} has an average score of ${average.toStringAsFixed(0)}% across ${grades.length} recorded subjects. ${strongest == lowest ? '' : 'The strongest result is in $strongest, while $lowest may need extra practice. '}Attendance shows $present present day${present == 1 ? '' : 's'} in the records shown. ${behaviorCount == 0 ? 'There are no high-priority behavior concerns recorded.' : 'There are $behaviorCount behavior note(s) to review with the teacher.'}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                const Chip(
                  avatar: Icon(Icons.auto_awesome, size: 17),
                  label: Text('Template summary · sample data'),
                ),
                Text(
                  'This demo summary is generated from sample records. A hosted AI summary is planned for a later milestone; this is not an official school report.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        const SectionHeading('At a glance'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: StatTile(
                  label: 'Average score',
                  value: '${average.toStringAsFixed(0)}%',
                  icon: Icons.school_outlined,
                ),
              ),
              Expanded(
                child: StatTile(
                  label: 'Present records',
                  value: '$present',
                  icon: Icons.event_available_outlined,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
