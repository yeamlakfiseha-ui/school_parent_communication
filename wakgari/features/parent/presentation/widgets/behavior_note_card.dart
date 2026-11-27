import 'package:flutter/material.dart';
import 'package:parentlink/core/widgets/parent_link_widgets.dart';
import 'package:parentlink/features/school_data/domain/school_record.dart';

import '../../domain/child_records.dart';
import '../formatting.dart';

/// One behavior report, with the parent's read state.
///
/// Acknowledging is what turns a concern into "read"; the teacher side can
/// later show the same flag as a read receipt.
class BehaviorNoteCard extends StatelessWidget {
  const BehaviorNoteCard({
    super.key,
    required this.report,
    required this.acknowledged,
    required this.onAcknowledge,
  });

  final BehaviorReport report;
  final bool acknowledged;
  final VoidCallback onAcknowledge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isConcern = BehaviorTimeline.isConcern(report);
    final tint = behaviorColor(context, report.severity);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isConcern ? Icons.priority_high : Icons.favorite_border,
                  size: 18,
                  color: tint,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isConcern ? 'Follow-up' : 'Positive note',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: tint,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (isConcern)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: tint.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '${report.severity.label} priority',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: tint,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(report.description),
            const SizedBox(height: 6),
            Text(
              '${fullDate(report.date)} · ${report.status} · '
              '${report.reportedBy}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            if (isConcern) ...[
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: acknowledged
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 16,
                            color: scheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Read',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: scheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )
                    : TextButton.icon(
                        onPressed: onAcknowledge,
                        icon: const Icon(Icons.check, size: 18),
                        label: const Text('Mark as read'),
                      ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
