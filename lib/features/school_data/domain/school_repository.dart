import 'school_record.dart';

class SchoolData {
  const SchoolData({
    required this.attendance,
    required this.grades,
    required this.behaviorReports,
    required this.checkInOut,
    required this.announcements,
    required this.schedule,
    required this.messages,
  });

  final List<AttendanceRecord> attendance;
  final List<GradeRecord> grades;
  final List<BehaviorReport> behaviorReports;
  final List<CheckInOutRecord> checkInOut;
  final List<SchoolAnnouncement> announcements;
  final List<ScheduleItem> schedule;
  final List<ChatMessage> messages;

  SchoolData copyWith({
    List<AttendanceRecord>? attendance,
    List<GradeRecord>? grades,
    List<BehaviorReport>? behaviorReports,
    List<CheckInOutRecord>? checkInOut,
    List<SchoolAnnouncement>? announcements,
    List<ScheduleItem>? schedule,
    List<ChatMessage>? messages,
  }) => SchoolData(
    attendance: attendance ?? this.attendance,
    grades: grades ?? this.grades,
    behaviorReports: behaviorReports ?? this.behaviorReports,
    checkInOut: checkInOut ?? this.checkInOut,
    announcements: announcements ?? this.announcements,
    schedule: schedule ?? this.schedule,
    messages: messages ?? this.messages,
  );
}

abstract interface class SchoolRepository {
  SchoolData loadInitialData();
}
