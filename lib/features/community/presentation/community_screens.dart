import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/parent_link_widgets.dart';
import '../../school_data/presentation/school_data_provider.dart';
import '../../students/domain/student.dart';
import '../../students/presentation/students_provider.dart';

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

class MessagesScreen extends ConsumerStatefulWidget {
  const MessagesScreen({super.key});

  @override
  ConsumerState<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends ConsumerState<MessagesScreen> {
  String? _threadId;
  final _message = TextEditingController();

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(schoolDataProvider);
    final students =
        ref.watch(studentsProvider).asData?.value ?? const <Student>[];
    if (_threadId == null) {
      return ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          const PageIntro(
            eyebrow: 'Conversations',
            title: 'Messages',
            subtitle: 'A direct line between home and school.',
          ),
          for (final student in students.take(2))
            Builder(
              builder: (context) {
                final messages =
                    data.messages
                        .where((item) => item.threadId == student.id)
                        .toList()
                      ..sort((a, b) => b.sentAt.compareTo(a.sentAt));
                final latest = messages.firstOrNull;
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        student.name
                            .split(' ')
                            .map((part) => part[0])
                            .take(2)
                            .join(),
                      ),
                    ),
                    title: Text(
                      student.name,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      latest?.text ?? 'Start a conversation with the teacher',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => setState(() => _threadId = student.id),
                  ),
                );
              },
            ),
        ],
      );
    }
    if (students.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    final student = students.firstWhere(
      (item) => item.id == _threadId,
      orElse: () => students.first,
    );
    final messages =
        data.messages.where((item) => item.threadId == student.id).toList()
          ..sort((a, b) => a.sentAt.compareTo(b.sentAt));
    return Column(
      children: [
        Material(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => setState(() => _threadId = null),
                  icon: const Icon(Icons.arrow_back),
                ),
                CircleAvatar(child: Text(student.name[0])),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const Text('Teacher conversation'),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final item in messages)
                Align(
                  alignment: item.sender == 'You'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 310),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: item.sender == 'You'
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.text),
                        const SizedBox(height: 4),
                        Text(
                          '${item.sender} · ${TimeOfDay.fromDateTime(item.sentAt).format(context)}',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _message,
                    decoration: const InputDecoration(
                      hintText: 'Write a message',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _send,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _send() {
    final text = _message.text.trim();
    if (text.isEmpty || _threadId == null) return;
    ref.read(schoolDataProvider.notifier).sendMessage(_threadId!, text);
    _message.clear();
  }
}
