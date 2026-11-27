import 'package:flutter/material.dart';

import '../../../auth/domain/user.dart';

/// Displays a circular initials avatar for a messaging [User].
class ContactAvatar extends StatelessWidget {
  const ContactAvatar({
    super.key,
    required this.user,
    this.radius = 22,
  });

  final User user;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final (backgroundColor, foregroundColor) = switch (user.role) {
      UserRole.teacher => (
          colorScheme.primaryContainer,
          colorScheme.onPrimaryContainer,
        ),
      UserRole.schoolLeader => (
          colorScheme.tertiaryContainer,
          colorScheme.onTertiaryContainer,
        ),
      UserRole.appAdmin => (
          colorScheme.secondaryContainer,
          colorScheme.onSecondaryContainer,
        ),
      UserRole.parent => (
          colorScheme.surfaceContainerHighest,
          colorScheme.onSurface,
        ),
    };

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      child: Text(
        _initials(user.name),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: radius * 0.72,
        ),
      ),
    );
  }

  static String _initials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    // Skip common honorifics like "Ms.", "Mr.", "Sr." when picking initials.
    const titles = {'ms.', 'mr.', 'mrs.', 'dr.', 'sr.'};
    final meaningful =
        parts.where((p) => !titles.contains(p.toLowerCase())).toList();
    final source = meaningful.length >= 2 ? meaningful : parts;
    return '${source.first[0]}${source.last[0]}'.toUpperCase();
  }
}
