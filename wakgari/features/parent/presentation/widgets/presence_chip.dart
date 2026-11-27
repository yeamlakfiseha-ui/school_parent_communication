import 'package:flutter/material.dart';

import '../../domain/child_records.dart';
import '../formatting.dart';

/// Today's gate state for a child, as a compact coloured chip.
class PresenceChip extends StatelessWidget {
  const PresenceChip({super.key, required this.presence, this.dense = false});

  final TodayPresence presence;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tint = switch (presence.state) {
      PresenceState.inSchool || PresenceState.present => scheme.primary,
      PresenceState.checkedOut => scheme.secondary,
      PresenceState.late => scheme.tertiary,
      PresenceState.absent => scheme.error,
      PresenceState.notMarked => scheme.onSurfaceVariant,
    };
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? 8 : 10,
        vertical: dense ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: dense ? 13 : 15, color: tint),
          const SizedBox(width: 5),
          Text(
            label(context),
            style:
                (dense
                        ? Theme.of(context).textTheme.labelSmall
                        : Theme.of(context).textTheme.labelMedium)
                    ?.copyWith(color: tint, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  String label(BuildContext context) => switch (presence.state) {
    PresenceState.inSchool =>
      'In school since ${clockLabel(context, presence.since!)}',
    PresenceState.checkedOut =>
      presence.since == null
          ? 'Checked out'
          : 'Checked out ${clockLabel(context, presence.since!)}',
    PresenceState.absent => 'Absent today',
    PresenceState.late => 'Marked late today',
    PresenceState.present => 'Present today',
    PresenceState.notMarked => 'Today not marked yet',
  };

  IconData get _icon => switch (presence.state) {
    PresenceState.inSchool => Icons.login,
    PresenceState.checkedOut => Icons.logout,
    PresenceState.absent => Icons.cancel_outlined,
    PresenceState.late => Icons.schedule,
    PresenceState.present => Icons.check_circle_outline,
    PresenceState.notMarked => Icons.help_outline,
  };
}
