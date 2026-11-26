import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/widgets/parent_link_widgets.dart';
import '../../school_data/data/in_memory_school_repository.dart';
import '../../school_data/domain/school_record.dart';
import '../../school_data/presentation/school_data_provider.dart';

class SchoolOverviewScreen extends ConsumerWidget {
  const SchoolOverviewScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(schoolDataProvider);
    final attendanceToday = data.attendance.where((item) {
      final now = DateTime.now();
      return item.date.year == now.year &&
          item.date.month == now.month &&
          item.date.day == now.day;
    }).toList();
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const PageIntro(
          eyebrow: 'School leadership',
          title: 'School overview',
          subtitle: 'A snapshot of student progress and attendance.',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: StatTile(
                  label: 'Students',
                  value: '${demoStudents.length}',
                  icon: Icons.groups_outlined,
                ),
              ),
              Expanded(
                child: StatTile(
                  label: 'Grades recorded',
                  value: '${data.grades.length}',
                  icon: Icons.school_outlined,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: StatTile(
                  label: 'Present today',
                  value:
                      '${attendanceToday.where((item) => item.status == AttendanceStatus.present).length}',
                  icon: Icons.check_circle_outline,
                ),
              ),
              Expanded(
                child: StatTile(
                  label: 'Reports',
                  value: '${data.behaviorReports.length}',
                  icon: Icons.assignment_outlined,
                ),
              ),
            ],
          ),
        ),
        const SectionHeading('By grade and section'),
        for (final group in {
          'Grade 8 · A': ['s-101', 's-102'],
          'Grade 8 · B': ['s-103'],
          'Grade 7 · A': ['s-104'],
        }.entries)
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: ExpansionTile(
              title: Text(group.key),
              subtitle: Text('${group.value.length} students'),
              children: [
                for (final id in group.value)
                  Builder(
                    builder: (context) {
                      final student = demoStudents.firstWhere(
                        (item) => item.id == id,
                      );
                      final grades = data.grades
                          .where((item) => item.studentId == id)
                          .toList();
                      final average = grades.isEmpty
                          ? 0
                          : grades
                                    .map((item) => item.score)
                                    .reduce((a, b) => a + b) /
                                grades.length;
                      return ListTile(
                        title: Text(student.name),
                        subtitle: Text('${grades.length} grade records'),
                        trailing: Text(
                          grades.isEmpty
                              ? '—'
                              : '${average.toStringAsFixed(0)}%',
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: OutlinedButton.icon(
            onPressed: () => context.go(AppRoutes.postAnnouncement),
            icon: const Icon(Icons.campaign_outlined),
            label: const Text('Post update or schedule item'),
          ),
        ),
      ],
    );
  }
}

class PostAnnouncementScreen extends StatefulWidget {
  const PostAnnouncementScreen({super.key});
  @override
  State<PostAnnouncementScreen> createState() => _PostAnnouncementScreenState();
}

class _PostAnnouncementScreenState extends State<PostAnnouncementScreen> {
  var _isAnnouncement = true;
  final _title = TextEditingController();
  final _message = TextEditingController();
  var _kind = 'Event';
  var _startDate = DateTime.now().add(const Duration(days: 7));
  var _endDate = DateTime.now().add(const Duration(days: 7));
  @override
  void dispose() {
    _title.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Consumer(
    builder: (context, ref, _) => ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const PageIntro(
          eyebrow: 'School communication',
          title: 'Create an update',
          subtitle: 'Share a notice or add an important date.',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('Announcement')),
              ButtonSegment(value: false, label: Text('Schedule')),
            ],
            selected: {_isAnnouncement},
            showSelectedIcon: false,
            onSelectionChanged: (value) =>
                setState(() => _isAnnouncement = value.first),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  TextField(
                    controller: _title,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _message,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: _isAnnouncement ? 'Message' : 'Description',
                      alignLabelWithHint: true,
                      prefixIcon: const Icon(Icons.notes),
                    ),
                  ),
                  if (_isAnnouncement) ...[
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: _kind,
                      decoration: const InputDecoration(labelText: 'Type'),
                      items: const [
                        DropdownMenuItem(value: 'Event', child: Text('Event')),
                        DropdownMenuItem(
                          value: 'Meeting',
                          child: Text('Meeting'),
                        ),
                        DropdownMenuItem(
                          value: 'Schedule change',
                          child: Text('Schedule change'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) setState(() => _kind = value);
                      },
                    ),
                  ] else ...[
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _chooseDate(start: true),
                            icon: const Icon(Icons.calendar_today),
                            label: Text('Starts ${shortDate(_startDate)}'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _chooseDate(start: false),
                            icon: const Icon(Icons.event),
                            label: Text('Ends ${shortDate(_endDate)}'),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        if (_title.text.trim().isEmpty ||
                            _message.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Add a title and message first.'),
                            ),
                          );
                          return;
                        }
                        if (_isAnnouncement) {
                          ref
                              .read(schoolDataProvider.notifier)
                              .addAnnouncement(
                                title: _title.text.trim(),
                                message: _message.text.trim(),
                                kind: _kind,
                              );
                        } else {
                          ref
                              .read(schoolDataProvider.notifier)
                              .addSchedule(
                                title: _title.text.trim(),
                                description: _message.text.trim(),
                                startDate: _startDate,
                                endDate: _endDate,
                              );
                        }
                        _title.clear();
                        _message.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Saved to the in-memory school feed.',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.publish),
                      label: Text(
                        _isAnnouncement
                            ? 'Post announcement'
                            : 'Add schedule item',
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Push notifications and shared storage are part of Milestone 2.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Future<void> _chooseDate({required bool start}) async {
    final chosen = await showDatePicker(
      context: context,
      initialDate: start ? _startDate : _endDate,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (chosen != null)
      setState(() {
        if (start) {
          _startDate = chosen;
          if (_endDate.isBefore(chosen)) _endDate = chosen;
        } else {
          _endDate = chosen;
        }
      });
  }
}
