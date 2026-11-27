import '../domain/student.dart';
import '../domain/student_repository.dart';

const sampleStudents = <Student>[
  Student(
    id: 's-101',
    name: 'Mimi Bekele',
    grade: 'Grade 8',
    section: 'A',
  ),
  Student(
    id: 's-102',
    name: 'Hana Tesfaye',
    grade: 'Grade 8',
    section: 'A',
  ),
  Student(
    id: 's-103',
    name: 'Liya Abebe',
    grade: 'Grade 8',
    section: 'B',
  ),
  Student(
    id: 's-104',
    name: 'Rahel Alemu',
    grade: 'Grade 7',
    section: 'A',
  ),
];

class InMemoryStudentRepository implements StudentRepository {
  final List<Student> _students = List<Student>.from(sampleStudents);

  @override
  Future<List<Student>> getStudents() async => List.unmodifiable(_students);
}
