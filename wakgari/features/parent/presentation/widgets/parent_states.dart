import 'package:flutter/material.dart';

/// Empty tab body with a short explanation instead of a bare sentence.
class EmptyTabState extends StatelessWidget {
  const EmptyTabState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 38, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Recoverable failure while loading students.
class ParentErrorState extends StatelessWidget {
  const ParentErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_off_outlined,
            size: 38,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 12),
          const Text(
            'We could not load your children',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 14),
          FilledButton.tonal(
            onPressed: onRetry,
            child: const Text('Try again'),
          ),
        ],
      ),
    ),
  );
}

/// Shown when a parent opens a child that is not linked to their account,
/// or when a link points at a student that no longer exists.
class ChildNotLinked extends StatelessWidget {
  const ChildNotLinked({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock_outline,
            size: 38,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 12),
          Text(
            'This child is not linked to your account',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Only the children the school has linked to you can be opened. '
            'Ask the school office if a child is missing.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to my children'),
          ),
        ],
      ),
    ),
  );
}
