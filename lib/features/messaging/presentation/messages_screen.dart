import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/conversation.dart';
import 'chat_screen.dart';
import 'messaging_controller.dart';
import 'widgets/contact_avatar.dart';
import 'widgets/message_time_formatter.dart';

/// Displays the list of message conversations for the signed-in user.
class MessagesScreen extends ConsumerWidget {
  const MessagesScreen({
    super.key,
    this.onConversationTap,
  });

  final void Function(Conversation conversation)? onConversationTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversations = ref.watch(messagingControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: conversations.isEmpty
          ? const _EmptyConversationsView()
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: conversations.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final conversation = conversations[index];
                    return _ConversationTile(
                      conversation: conversation,
                      onTap: () => _openConversation(context, ref, conversation),
                    );
                  },
                ),
              ),
            ),
    );
  }

  void _openConversation(
    BuildContext context,
    WidgetRef ref,
    Conversation conversation,
  ) {
    ref.read(messagingControllerProvider.notifier).markAsRead(conversation.id);
    if (onConversationTap != null) {
      onConversationTap!(conversation);
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChatScreen(conversationId: conversation.id),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({
    required this.conversation,
    required this.onTap,
  });

  final Conversation conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isUnread = conversation.hasUnread;
    final lastMessage = conversation.lastMessage;
    final previewText = lastMessage?.text ?? 'No messages yet';
    final timestampText = lastMessage != null
        ? formatMessageTime(lastMessage.sentAt)
        : '';

    return Material(
      color: isUnread
          ? colorScheme.primaryContainer.withValues(alpha: 0.25)
          : Colors.transparent,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          clipBehavior: Clip.none,
          children: [
            ContactAvatar(user: conversation.contact, radius: 24),
            if (isUnread)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.surface,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                conversation.contact.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: isUnread ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
            if (timestampText.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                timestampText,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isUnread
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  fontWeight: isUnread ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  previewText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isUnread
                        ? colorScheme.onSurface
                        : colorScheme.onSurfaceVariant,
                    fontWeight: isUnread ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              if (isUnread) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${conversation.unreadCount}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyConversationsView extends StatelessWidget {
  const _EmptyConversationsView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.forum_outlined,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'No messages yet',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
