// Generated with Antigravity (Gemini 4 Hydrogen (High)), reviewed by Tamirat Petros

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parentlink/features/students/presentation/students_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() => container = ProviderContainer());
  tearDown(() => container.dispose());

  test('loads sample students from the in-memory student repository', () async {
    final students = await container.read(studentsProvider.future);
    expect(students, hasLength(4));
    expect(students.first.name, 'Mimi Bekele');
  });
}
