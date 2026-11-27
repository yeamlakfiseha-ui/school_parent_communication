import 'package:flutter/material.dart';
import 'package:parentlink/core/widgets/parent_link_widgets.dart';
import 'package:parentlink/features/school_data/domain/school_record.dart';

import '../../domain/child_records.dart';
import '../formatting.dart';

/// Attendance rate, the present/late/absent counts and the last ten marks.
class AttendanceSummaryCard extends StatelessWidget {
  const AttendanceSummaryCard({super.key, required this.summary});

  final AttendanceSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${summary.ratePercent}%',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    'attendance rate',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  '${summary.total} ${summary.total == 1 ? 'day' : 'days'}',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _CountChip(
                  label: 'Present',
                  count: summary.present,
                  color: attendanceColor(context, AttendanceStatus.present),
                ),
                _CountChip(
                  label: 'Late',
                  count: summary.late,
                  color: attendanceColor(context, AttendanceStatus.late),
                ),
                _CountChip(
                  label: 'Absent',
                  count: summary.absent,
                  color: attendanceColor(context, AttendanceStatus.absent),
                ),
              ],
            ),
            if (summary.recent.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Recent days',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final record in summary.recent)
                    Tooltip(
                      message:
                          '${fullDate(record.date)} · '
                          '${record.status.label}',
                      child: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: attendanceColor(
                            context,
                            record.status,
                          ).withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                            color: attendanceColor(
                              context,
                              record.status,
                            ).withValues(alpha: 0.45),
                          ),
                        ),
                        child: Text(
                          '${record.date.day}',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: attendanceColor(context, record.status),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CountChip extends StatelessWidget {
  const _CountChip({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      '$label $count',
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: color,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
