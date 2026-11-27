// Generated with Claude, reviewed by Tamirat Petros

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parentlink/features/school_data/domain/school_record.dart';
import 'package:parentlink/features/school_data/presentation/school_data_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() => container = ProviderContainer());
  tearDown(() => container.dispose());

  test('loads the made-up school records from the in-memory repository', () {
    final state = container.read(schoolDataProvider);
    expect(state.attendance, isNotEmpty);
    expect(state.grades, isNotEmpty);
    expect(state.behaviorReports, isNotEmpty);
  });

  test('teacher can change a student attendance status', () {
    container
        .read(schoolDataProvider.notifier)
        .setAttendance('s-101', AttendanceStatus.late);
    final today = DateTime.now();
    final todayRecords = container
        .read(schoolDataProvider)
        .attendance
        .where(
          (item) =>
              item.studentId == 's-101' &&
              item.date.year == today.year &&
              item.date.month == today.month &&
              item.date.day == today.day,
        );
    expect(todayRecords, hasLength(1));
    expect(todayRecords.first.status, AttendanceStatus.late);
  });

  test('teacher can add a grade to the in-memory records', () {
    final before = container.read(schoolDataProvider).grades.length;
    container
        .read(schoolDataProvider.notifier)
        .addGrade(studentId: 's-103', subject: 'Chemistry', score: 87);
    final grades = container.read(schoolDataProvider).grades;
    expect(grades, hasLength(before + 1));
    expect(grades.last.subject, 'Chemistry');
    expect(grades.last.score, 87);
  });

  test('teacher can add a behavior report', () {
    final before = container.read(schoolDataProvider).behaviorReports.length;
    container
        .read(schoolDataProvider.notifier)
        .addBehavior(
          studentId: 's-104',
          description: 'Shared class materials.',
          severity: BehaviorSeverity.low,
        );
    final reports = container.read(schoolDataProvider).behaviorReports;
    expect(reports, hasLength(before + 1));
    expect(reports.last.studentId, 's-104');
    expect(reports.last.description, 'Shared class materials.');
  });

  test('school leader can add an announcement to the feed', () {
    final before = container.read(schoolDataProvider).announcements.length;
    container
        .read(schoolDataProvider.notifier)
        .addAnnouncement(
          title: 'Reading day',
          message: 'Bring a favorite book.',
          kind: 'Event',
        );
    final announcements = container.read(schoolDataProvider).announcements;
    expect(announcements, hasLength(before + 1));
    expect(announcements.first.title, 'Reading day');
  });
}
