import 'student.dart';

abstract interface class StudentRepository {
  Future<List<Student>> getStudents();
}
