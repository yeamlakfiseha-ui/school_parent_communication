// Small presentation helpers shared by the parent screens.

import 'package:flutter/material.dart';
import 'package:parentlink/features/school_data/domain/school_record.dart';

extension AttendanceStatusLabel on AttendanceStatus {
  String get label => switch (this) {
    AttendanceStatus.present => 'Present',
    AttendanceStatus.absent => 'Absent',
    AttendanceStatus.late => 'Late',
  };
}

extension BehaviorSeverityLabel on BehaviorSeverity {
  String get label => switch (this) {
    BehaviorSeverity.low => 'Low',
    BehaviorSeverity.medium => 'Medium',
    BehaviorSeverity.high => 'High',
  };
}

/// Up to two initials from a student name, for avatars.
String initials(String name) => name
    .trim()
    .split(RegExp(r'\s+'))
    .where((part) => part.isNotEmpty)
    .map((part) => part[0])
    .take(2)
    .join()
    .toUpperCase();

/// A short clock label such as `7:42`.
String clockLabel(BuildContext context, DateTime time) =>
    TimeOfDay.fromDateTime(time).format(context);

/// A compact duration label such as `7h 38m` or `45m`.
String durationLabel(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  if (hours == 0) return '${minutes}m';
  if (minutes == 0) return '${hours}h';
  return '${hours}h ${minutes}m';
}

/// Colour used for a record status, kept consistent across the tabs.
Color attendanceColor(BuildContext context, AttendanceStatus status) {
  final scheme = Theme.of(context).colorScheme;
  return switch (status) {
    AttendanceStatus.present => scheme.primary,
    AttendanceStatus.absent => scheme.error,
    AttendanceStatus.late => scheme.tertiary,
  };
}

Color behaviorColor(BuildContext context, BehaviorSeverity severity) {
  final scheme = Theme.of(context).colorScheme;
  return switch (severity) {
    BehaviorSeverity.low => scheme.primary,
    BehaviorSeverity.medium => scheme.tertiary,
    BehaviorSeverity.high => scheme.error,
  };
}
