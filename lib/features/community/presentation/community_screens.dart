// Generated with Claude, updated with Antigravity (Gemini 4 Hydrogen (High)), reviewed by Tamirat Petros

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/parent_link_widgets.dart';
import '../../school_data/presentation/school_data_provider.dart';

class AnnouncementsScreen extends ConsumerWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(schoolDataProvider);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const PageIntro(
            eyebrow: 'Stay in the loop',
            title: 'School updates',
            subtitle: 'Announcements and important dates, together.',
          ),
          const TabBar(
            tabs: [
              Tab(text: 'Announcements'),
              Tab(text: 'Schedule'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: [
                    for (final item in data.announcements)
                      Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Chip(label: Text(item.kind)),
                                  const Spacer(),
                                  Text(
                                    shortDate(item.date),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 7),
                              Text(item.message),
                              const SizedBox(height: 10),
                              Text(
                                'Posted by ${item.createdBy}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: [
                    for (final item in data.schedule)
                      Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text('${item.startDate.day}'),
                          ),
                          title: Text(item.title),
                          subtitle: Text(
                            '${fullDate(item.startDate)}${item.endDate.day == item.startDate.day ? '' : ' – ${fullDate(item.endDate)}'}\n${item.description}',
                          ),
                          isThreeLine: true,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
