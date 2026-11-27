import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parentlink/core/widgets/parent_link_widgets.dart';
import 'package:parentlink/features/school_data/presentation/school_data_provider.dart';
import 'package:parentlink/features/students/presentation/students_provider.dart';

import 'parent_providers.dart';
import 'widgets/child_status_card.dart';
import 'widgets/parent_states.dart';

/// The parent's landing screen: each linked child with today's status, the
/// numbers parents open the app for, and anything that needs attention.
///
/// Navigation is a callback (`onOpenChild`) so the screen works with either
/// `go_router` or a plain `Navigator`.
class ParentHomeScreen extends ConsumerWidget {
  const ParentHomeScreen({super.key, required this.onOpenChild});

  final ValueChanged<String> onOpenChild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = ref.watch(parentChildrenProvider);
    final announcements = ref
        .watch(schoolDataProvider)
        .announcements
        .take(2)
        .toList();
    final greeting = _greeting(ref.watch(nowProvider)());

    return children.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ParentErrorState(
        message: '$error',
        onRetry: () => ref.invalidate(studentsProvider),
      ),
      data: (students) => ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          PageIntro(
            eyebrow: 'Your family',
            title: greeting,
            subtitle: 'Here is what is happening at school today.',
          ),
          if (students.isEmpty)
            const _NoChildrenLinked()
          else ...[
            const SectionHeading('Your children'),
            for (final student in students)
              ChildStatusCard(
                student: student,
                overview: ref.watch(childOverviewProvider(student.id)),
                onTap: () => onOpenChild(student.id),
              ),
          ],
          if (announcements.isNotEmpty) ...[
            const SectionHeading('From the school'),
            for (final announcement in announcements)
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.campaign_outlined, size: 19),
                  ),
                  title: Text(announcement.title),
                  subtitle: Text(
                    '${announcement.kind} · '
                    '${shortDate(announcement.date)}',
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

String _greeting(DateTime now) {
  if (now.hour < 12) return 'Good morning';
  if (now.hour < 17) return 'Good afternoon';
  return 'Good evening';
}

class _NoChildrenLinked extends StatelessWidget {
  const _NoChildrenLinked();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.family_restroom_outlined,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Text(
                  'No children linked yet',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Ask the school office to link your child to this account. '
              'Their attendance, grades, behavior notes and gate times will '
              'appear here as soon as the link is made.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
