// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceRecord _$AttendanceRecordFromJson(Map<String, dynamic> json) =>
    _AttendanceRecord(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      date: DateTime.parse(json['date'] as String),
      status: $enumDecode(_$AttendanceStatusEnumMap, json['status']),
      recordedBy: json['recordedBy'] as String,
    );

Map<String, dynamic> _$AttendanceRecordToJson(_AttendanceRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'date': instance.date.toIso8601String(),
      'status': _$AttendanceStatusEnumMap[instance.status]!,
      'recordedBy': instance.recordedBy,
    };

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.present: 'present',
  AttendanceStatus.absent: 'absent',
  AttendanceStatus.late: 'late',
};

_GradeRecord _$GradeRecordFromJson(Map<String, dynamic> json) => _GradeRecord(
  id: json['id'] as String,
  studentId: json['studentId'] as String,
  subject: json['subject'] as String,
  score: (json['score'] as num).toDouble(),
  term: json['term'] as String,
  date: DateTime.parse(json['date'] as String),
  recordedBy: json['recordedBy'] as String,
);

Map<String, dynamic> _$GradeRecordToJson(_GradeRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'subject': instance.subject,
      'score': instance.score,
      'term': instance.term,
      'date': instance.date.toIso8601String(),
      'recordedBy': instance.recordedBy,
    };

_BehaviorReport _$BehaviorReportFromJson(Map<String, dynamic> json) =>
    _BehaviorReport(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      description: json['description'] as String,
      severity: $enumDecode(_$BehaviorSeverityEnumMap, json['severity']),
      status: json['status'] as String,
      date: DateTime.parse(json['date'] as String),
      reportedBy: json['reportedBy'] as String,
    );

Map<String, dynamic> _$BehaviorReportToJson(_BehaviorReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'description': instance.description,
      'severity': _$BehaviorSeverityEnumMap[instance.severity]!,
      'status': instance.status,
      'date': instance.date.toIso8601String(),
      'reportedBy': instance.reportedBy,
    };

const _$BehaviorSeverityEnumMap = {
  BehaviorSeverity.low: 'low',
  BehaviorSeverity.medium: 'medium',
  BehaviorSeverity.high: 'high',
};

_CheckInOutRecord _$CheckInOutRecordFromJson(Map<String, dynamic> json) =>
    _CheckInOutRecord(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      checkedIn: json['checkedIn'] as bool,
      time: DateTime.parse(json['time'] as String),
      recordedBy: json['recordedBy'] as String,
    );

Map<String, dynamic> _$CheckInOutRecordToJson(_CheckInOutRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'checkedIn': instance.checkedIn,
      'time': instance.time.toIso8601String(),
      'recordedBy': instance.recordedBy,
    };

_SchoolAnnouncement _$SchoolAnnouncementFromJson(Map<String, dynamic> json) =>
    _SchoolAnnouncement(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      kind: json['kind'] as String,
      date: DateTime.parse(json['date'] as String),
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$SchoolAnnouncementToJson(_SchoolAnnouncement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'kind': instance.kind,
      'date': instance.date.toIso8601String(),
      'createdBy': instance.createdBy,
    };

_ScheduleItem _$ScheduleItemFromJson(Map<String, dynamic> json) =>
    _ScheduleItem(
      id: json['id'] as String,
      title: json['title'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      description: json['description'] as String,
    );

Map<String, dynamic> _$ScheduleItemToJson(_ScheduleItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'description': instance.description,
    };
