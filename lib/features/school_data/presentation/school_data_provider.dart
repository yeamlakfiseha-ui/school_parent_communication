import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/auth_controller.dart';
import '../data/in_memory_school_repository.dart';
import '../domain/school_record.dart';
import '../domain/school_repository.dart';

final schoolRepositoryProvider = Provider<SchoolRepository>(
  (ref) => InMemorySchoolRepository(),
);

final schoolDataProvider = NotifierProvider<SchoolDataController, SchoolData>(
  SchoolDataController.new,
);

class SchoolDataController extends Notifier<SchoolData> {
  @override
  SchoolData build() => ref.read(schoolRepositoryProvider).loadInitialData();

  String _actorName(String fallback) {
    final user = ref.read(authControllerProvider).asData?.value;
    if (user == null || user.name.trim().isEmpty) return fallback;
    return user.name;
  }

  void setAttendance(String studentId, AttendanceStatus status) {
    final today = DateTime.now();
    final remaining = state.attendance.where(
      (item) => item.studentId != studentId || !_sameDay(item.date, today),
    );
    state = state.copyWith(
      attendance: [
        ...remaining,
        AttendanceRecord(
          id: 'a-${today.microsecondsSinceEpoch}-$studentId',
          studentId: studentId,
          date: today,
          status: status,
          recordedBy: _actorName('Ms. Selam'),
        ),
      ],
    );
  }

  void addGrade({
    required String studentId,
    required String subject,
    required double score,
    String term = 'Term 1',
  }) {
    final now = DateTime.now();
    state = state.copyWith(
      grades: [
        ...state.grades,
        GradeRecord(
          id: 'g-${now.microsecondsSinceEpoch}',
          studentId: studentId,
          subject: subject,
          score: score,
          term: term,
          date: now,
          recordedBy: _actorName('Ms. Selam'),
        ),
      ],
    );
  }

  void addBehavior({
    required String studentId,
    required String description,
    required BehaviorSeverity severity,
  }) {
    final now = DateTime.now();
    state = state.copyWith(
      behaviorReports: [
        ...state.behaviorReports,
        BehaviorReport(
          id: 'b-${now.microsecondsSinceEpoch}',
          studentId: studentId,
          description: description,
          severity: severity,
          status: 'New',
          date: now,
          reportedBy: _actorName('Ms. Selam'),
        ),
      ],
    );
  }

  void addAnnouncement({
    required String title,
    required String message,
    required String kind,
  }) {
    final now = DateTime.now();
    state = state.copyWith(
      announcements: [
        SchoolAnnouncement(
          id: 'n-${now.microsecondsSinceEpoch}',
          title: title,
          message: message,
          kind: kind,
          date: now,
          createdBy: _actorName('Principal'),
        ),
        ...state.announcements,
      ],
    );
  }

  void addSchedule({
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final now = DateTime.now();
    state = state.copyWith(
      schedule: [
        ScheduleItem(
          id: 'sc-${now.microsecondsSinceEpoch}',
          title: title,
          description: description,
          startDate: startDate,
          endDate: endDate,
        ),
        ...state.schedule,
      ],
    );
  }

  void sendMessage(String threadId, String text) {
    final now = DateTime.now();
    state = state.copyWith(
      messages: [
        ...state.messages,
        ChatMessage(
          id: 'm-${now.microsecondsSinceEpoch}',
          threadId: threadId,
          sender: 'You',
          text: text,
          sentAt: now,
        ),
      ],
    );
  }

  void recordCheckIn(String studentId, {required bool checkedIn}) {
    final now = DateTime.now();
    state = state.copyWith(
      checkInOut: [
        ...state.checkInOut,
        CheckInOutRecord(
          id: 'c-${now.microsecondsSinceEpoch}',
          studentId: studentId,
          checkedIn: checkedIn,
          time: now,
          recordedBy: _actorName('Ms. Selam'),
        ),
      ],
    );
  }
}

bool _sameDay(DateTime first, DateTime second) =>
    first.year == second.year &&
    first.month == second.month &&
    first.day == second.day;
