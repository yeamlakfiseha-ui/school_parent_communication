import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/in_memory_student_repository.dart';
import '../domain/student.dart';
import '../domain/student_repository.dart';

final studentRepositoryProvider = Provider<StudentRepository>(
  (ref) => InMemoryStudentRepository(),
);

final studentsProvider =
    AsyncNotifierProvider<StudentsController, List<Student>>(
      StudentsController.new,
    );

class StudentsController extends AsyncNotifier<List<Student>> {
  @override
  Future<List<Student>> build() =>
      ref.read(studentRepositoryProvider).getStudents();
}
