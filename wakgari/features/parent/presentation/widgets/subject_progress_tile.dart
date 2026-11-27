import 'package:flutter/material.dart';

import '../../domain/child_records.dart';

/// One subject's latest score, its change since the previous score and its
/// average across the records we have.
class SubjectProgressTile extends StatelessWidget {
  const SubjectProgressTile({super.key, required this.progress});

  final SubjectProgress progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final change = progress.change;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    progress.subject,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (change == null)
                  _Chip(label: 'First score', color: scheme.onSurfaceVariant)
                else if (change == 0)
                  _Chip(label: 'No change', color: scheme.onSurfaceVariant)
                else
                  _Chip(
                    label:
                        '${change > 0 ? '▲' : '▼'} '
                        '${change.abs().toStringAsFixed(0)}',
                    color: change > 0 ? scheme.primary : scheme.error,
                  ),
                const SizedBox(width: 8),
                Text(
                  '${progress.latest.toStringAsFixed(0)}%',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                value: (progress.latest / 100).clamp(0, 1),
                minHeight: 6,
                backgroundColor: scheme.surfaceContainerHighest,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Average ${progress.average.toStringAsFixed(0)}% · '
              '${progress.recordCount} '
              '${progress.recordCount == 1 ? 'record' : 'records'}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: color,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
