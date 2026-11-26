import 'package:freezed_annotation/freezed_annotation.dart';

part 'school_record.freezed.dart';
part 'school_record.g.dart';

enum AttendanceStatus { present, absent, late }

enum BehaviorSeverity { low, medium, high }

@freezed
abstract class AttendanceRecord with _$AttendanceRecord {
  const factory AttendanceRecord({
    required String id,
    required String studentId,
    required DateTime date,
    required AttendanceStatus status,
    required String recordedBy,
  }) = _AttendanceRecord;

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRecordFromJson(json);
}

@freezed
abstract class GradeRecord with _$GradeRecord {
  const factory GradeRecord({
    required String id,
    required String studentId,
    required String subject,
    required double score,
    required String term,
    required DateTime date,
    required String recordedBy,
  }) = _GradeRecord;

  factory GradeRecord.fromJson(Map<String, dynamic> json) =>
      _$GradeRecordFromJson(json);
}

@freezed
abstract class BehaviorReport with _$BehaviorReport {
  const factory BehaviorReport({
    required String id,
    required String studentId,
    required String description,
    required BehaviorSeverity severity,
    required String status,
    required DateTime date,
    required String reportedBy,
  }) = _BehaviorReport;

  factory BehaviorReport.fromJson(Map<String, dynamic> json) =>
      _$BehaviorReportFromJson(json);
}

@freezed
abstract class CheckInOutRecord with _$CheckInOutRecord {
  const factory CheckInOutRecord({
    required String id,
    required String studentId,
    required bool checkedIn,
    required DateTime time,
    required String recordedBy,
  }) = _CheckInOutRecord;

  factory CheckInOutRecord.fromJson(Map<String, dynamic> json) =>
      _$CheckInOutRecordFromJson(json);
}

@freezed
abstract class SchoolAnnouncement with _$SchoolAnnouncement {
  const factory SchoolAnnouncement({
    required String id,
    required String title,
    required String message,
    required String kind,
    required DateTime date,
    required String createdBy,
  }) = _SchoolAnnouncement;

  factory SchoolAnnouncement.fromJson(Map<String, dynamic> json) =>
      _$SchoolAnnouncementFromJson(json);
}

@freezed
abstract class ScheduleItem with _$ScheduleItem {
  const factory ScheduleItem({
    required String id,
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required String description,
  }) = _ScheduleItem;

  factory ScheduleItem.fromJson(Map<String, dynamic> json) =>
      _$ScheduleItemFromJson(json);
}

@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String threadId,
    required String sender,
    required String text,
    required DateTime sentAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
