import 'package:flutter/material.dart';
import 'package:parentlink/core/widgets/parent_link_widgets.dart';

import '../../domain/child_records.dart';
import '../formatting.dart';

/// One gate session: arrival, departure and how long the child was at school.
class CheckInSessionTile extends StatelessWidget {
  const CheckInSessionTile({super.key, required this.session});

  final CheckInSession session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final checkIn = session.checkIn;
    final checkOut = session.checkOut;
    final duration = session.duration;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            session.isOpen
                ? Icons.login
                : session.isOrphanCheckOut
                ? Icons.logout
                : Icons.done_all,
            size: 19,
          ),
        ),
        title: Text(
          [
            if (checkIn != null) 'In ${clockLabel(context, checkIn)}',
            if (checkOut != null) 'Out ${clockLabel(context, checkOut)}',
          ].join(' · '),
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          [
            fullDate(session.day),
            if (duration != null) durationLabel(duration),
            if (session.isOpen) 'No check-out recorded yet',
            if (session.isOrphanCheckOut) 'Check-out without a check-in',
          ].join(' · '),
          style: theme.textTheme.bodySmall?.copyWith(
            color: session.isOpen || session.isOrphanCheckOut
                ? scheme.tertiary
                : scheme.onSurfaceVariant,
          ),
        ),
        trailing: session.isOpen || session.isOrphanCheckOut
            ? Icon(Icons.error_outline, color: scheme.tertiary, size: 20)
            : null,
      ),
    );
  }
}
