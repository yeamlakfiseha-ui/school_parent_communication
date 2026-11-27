import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'students_provider.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsAsync = ref.watch(studentsProvider);
    return studentsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Unable to load students: $error')),
      data: (students) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final student in students)
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    student.name.split(' ').map((part) => part[0]).take(2).join(),
                  ),
                ),
                title: Text(student.name),
                subtitle: Text('${student.grade} · Section ${student.section}'),
              ),
            ),
        ],
      ),
    );
  }
}
