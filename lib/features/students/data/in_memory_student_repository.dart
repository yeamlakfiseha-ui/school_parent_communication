import '../domain/student.dart';
import '../domain/student_repository.dart';

class InMemoryStudentRepository implements StudentRepository {
  final List<Student> _students = const [];

  @override
  Future<List<Student>> getStudents() async => List.unmodifiable(_students);
}
