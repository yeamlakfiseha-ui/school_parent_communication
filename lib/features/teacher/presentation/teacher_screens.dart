import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/widgets/parent_link_widgets.dart';
import '../../school_data/data/in_memory_school_repository.dart';
import '../../school_data/domain/school_record.dart';
import '../../school_data/presentation/school_data_provider.dart';

class TeacherHomeScreen extends ConsumerWidget {
  const TeacherHomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(schoolDataProvider);
    final today = DateTime.now();
    final todayRecords = state.attendance
        .where(
          (record) =>
              record.date.year == today.year &&
              record.date.month == today.month &&
              record.date.day == today.day,
        )
        .toList();
    final present = todayRecords
        .where((item) => item.status == AttendanceStatus.present)
        .length;
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const PageIntro(
          eyebrow: 'Teacher workspace',
          title: 'Your class',
          subtitle: 'Grade 8 · Sections A and B · Homeroom',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: StatTile(
                  label: 'Present today',
                  value: '$present',
                  icon: Icons.check_circle_outline,
                ),
              ),
              Expanded(
                child: StatTile(
                  label: 'Students',
                  value: '${demoStudents.length}',
                  icon: Icons.groups_outlined,
                ),
              ),
            ],
          ),
        ),
        SectionHeading(
          'Attendance · ${shortDate(today)}',
          trailing: TextButton.icon(
            onPressed: () => context.go(AppRoutes.qrScanner),
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Check-in'),
          ),
        ),
        for (final student in demoStudents)
          _StudentAttendanceRow(
            studentId: student.id,
            name: student.name,
            detail: '${student.grade} · Section ${student.section}',
          ),
        const SectionHeading('Quick actions'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              FilledButton.tonalIcon(
                onPressed: () => context.go(AppRoutes.reportEntry),
                icon: const Icon(Icons.add_chart),
                label: const Text('Add grade or note'),
              ),
              OutlinedButton.icon(
                onPressed: () => context.go(AppRoutes.qrScanner),
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Student check-in'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StudentAttendanceRow extends ConsumerWidget {
  const _StudentAttendanceRow({
    required this.studentId,
    required this.name,
    required this.detail,
  });
  final String studentId;
  final String name;
  final String detail;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(schoolDataProvider);
    final today = DateTime.now();
    final record = state.attendance
        .where(
          (item) =>
              item.studentId == studentId &&
              item.date.year == today.year &&
              item.date.month == today.month &&
              item.date.day == today.day,
        )
        .firstOrNull;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Text(detail, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 6),
            SegmentedButton<AttendanceStatus>(
              segments: const [
                ButtonSegment(
                  value: AttendanceStatus.present,
                  label: Text('Present'),
                ),
                ButtonSegment(
                  value: AttendanceStatus.absent,
                  label: Text('Absent'),
                ),
                ButtonSegment(
                  value: AttendanceStatus.late,
                  label: Text('Late'),
                ),
              ],
              selected: {record?.status ?? AttendanceStatus.present},
              showSelectedIcon: false,
              onSelectionChanged: (values) => ref
                  .read(schoolDataProvider.notifier)
                  .setAttendance(studentId, values.first),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportEntryScreen extends StatefulWidget {
  const ReportEntryScreen({super.key});
  @override
  State<ReportEntryScreen> createState() => _ReportEntryScreenState();
}

class _ReportEntryScreenState extends State<ReportEntryScreen> {
  var _isGrade = true;
  String _studentId = demoStudents.first.id;
  final _subject = TextEditingController(text: 'Mathematics');
  final _score = TextEditingController();
  final _description = TextEditingController();
  var _severity = BehaviorSeverity.low;

  @override
  void dispose() {
    _subject.dispose();
    _score.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Consumer(
    builder: (context, ref, _) => ListView(
      padding: const EdgeInsets.only(bottom: 28),
      children: [
        const PageIntro(
          eyebrow: 'Class records',
          title: 'Add a report',
          subtitle: 'Share a timely update with a student’s family.',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SegmentedButton<bool>(
            segments: const [
              ButtonSegment(
                value: true,
                label: Text('Grade'),
                icon: Icon(Icons.school_outlined),
              ),
              ButtonSegment(
                value: false,
                label: Text('Behavior'),
                icon: Icon(Icons.favorite_border),
              ),
            ],
            selected: {_isGrade},
            onSelectionChanged: (value) =>
                setState(() => _isGrade = value.first),
            showSelectedIcon: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _studentId,
                    decoration: const InputDecoration(labelText: 'Student'),
                    items: [
                      for (final student in demoStudents)
                        DropdownMenuItem(
                          value: student.id,
                          child: Text(student.name),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => _studentId = value);
                    },
                  ),
                  const SizedBox(height: 14),
                  if (_isGrade) ...[
                    TextField(
                      controller: _subject,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        prefixIcon: Icon(Icons.menu_book_outlined),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _score,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Score',
                        suffixText: '%',
                        prefixIcon: Icon(Icons.percent),
                      ),
                    ),
                  ] else ...[
                    TextField(
                      controller: _description,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'What happened?',
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.notes),
                      ),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<BehaviorSeverity>(
                      initialValue: _severity,
                      decoration: const InputDecoration(labelText: 'Severity'),
                      items: [
                        for (final level in BehaviorSeverity.values)
                          DropdownMenuItem(
                            value: level,
                            child: Text(
                              level.name[0].toUpperCase() +
                                  level.name.substring(1),
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        if (value != null) setState(() => _severity = value);
                      },
                    ),
                  ],
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        if (_isGrade) {
                          final score = double.tryParse(_score.text);
                          if (_subject.text.trim().isEmpty ||
                              score == null ||
                              score < 0 ||
                              score > 100) {
                            _showMessage(
                              context,
                              'Enter a subject and score from 0 to 100.',
                            );
                            return;
                          }
                          ref
                              .read(schoolDataProvider.notifier)
                              .addGrade(
                                studentId: _studentId,
                                subject: _subject.text.trim(),
                                score: score,
                              );
                          _score.clear();
                        } else {
                          if (_description.text.trim().isEmpty) {
                            _showMessage(
                              context,
                              'Add a short description first.',
                            );
                            return;
                          }
                          ref
                              .read(schoolDataProvider.notifier)
                              .addBehavior(
                                studentId: _studentId,
                                description: _description.text.trim(),
                                severity: _severity,
                              );
                          _description.clear();
                        }
                        _showMessage(
                          context,
                          _isGrade
                              ? 'Grade added to the sample records.'
                              : 'Behavior note added to the sample records.',
                        );
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Save report'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'This milestone stores updates in memory on this device only.',
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
}

class QrScannerScreen extends ConsumerStatefulWidget {
  const QrScannerScreen({super.key});
  @override
  ConsumerState<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends ConsumerState<QrScannerScreen> {
  String _studentId = demoStudents.first.id;
  var _checkedIn = true;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.only(bottom: 24),
    children: [
      const PageIntro(
        eyebrow: 'Arrival log',
        title: 'Student check-in',
        subtitle: 'Milestone 1 demo: choose a student to simulate a QR scan.',
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.qr_code_2,
                    size: 108,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Camera scanning is planned for the next milestone.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'For this walkthrough, select the student whose ID would be scanned.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                DropdownButtonFormField<String>(
                  initialValue: _studentId,
                  decoration: const InputDecoration(labelText: 'Student'),
                  items: [
                    for (final student in demoStudents)
                      DropdownMenuItem(
                        value: student.id,
                        child: Text(student.name),
                      ),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _studentId = value);
                  },
                ),
                const SizedBox(height: 14),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text('Check in')),
                    ButtonSegment(value: false, label: Text('Check out')),
                  ],
                  selected: {_checkedIn},
                  onSelectionChanged: (value) =>
                      setState(() => _checkedIn = value.first),
                  showSelectedIcon: false,
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      ref
                          .read(schoolDataProvider.notifier)
                          .recordCheckIn(_studentId, checkedIn: _checkedIn);
                      _showMessage(context, 'Check-in record added.');
                    },
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text('Record scan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

void _showMessage(BuildContext context, String message) => ScaffoldMessenger.of(
  context,
).showSnackBar(SnackBar(content: Text(message)));
