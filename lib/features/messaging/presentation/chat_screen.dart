import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/chat_message.dart';
import '../domain/conversation.dart';
import 'messaging_controller.dart';
import 'widgets/contact_avatar.dart';
import 'widgets/message_time_formatter.dart';

/// Displays an individual conversation thread with message bubbles and input.
class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
    required this.conversationId,
  });

  final String conversationId;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      ref
          .read(messagingControllerProvider.notifier)
          .markAsRead(widget.conversationId);
    });
    _scheduleScrollToBottom(animate: false);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scheduleScrollToBottom({bool animate = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      final target = _scrollController.position.maxScrollExtent;
      if (animate) {
        _scrollController.animateTo(
          target,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(target);
      }
    });
  }

  void _handleSend() {
    final sent = ref.read(messagingControllerProvider.notifier).sendMessage(
          conversationId: widget.conversationId,
          content: _messageController.text,
        );

    if (!sent) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Please enter a message before sending.'),
          ),
        );
      return;
    }

    _messageController.clear();
    _scheduleScrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final conversation = ref.watch(
      conversationByIdProvider(widget.conversationId),
    );
    final currentUserId = ref.watch(currentMessagingUserIdProvider);

    if (conversation == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Chat')),
        body: const Center(child: Text('Conversation not found.')),
      );
    }

    ref.listen<Conversation?>(
      conversationByIdProvider(widget.conversationId),
      (previous, next) {
        if (next != null &&
            (previous == null ||
                next.messages.length > previous.messages.length)) {
          _scheduleScrollToBottom();
        }
      },
    );

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final counterpart = conversation.counterpartFor(currentUserId);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            ContactAvatar(user: counterpart, radius: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                counterpart.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (conversation.studentName != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                border: Border(
                  bottom: BorderSide(color: colorScheme.outlineVariant),
                ),
              ),
              child: Text(
                'About: ${conversation.studentName!}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: conversation.messages.isEmpty
                    ? Center(
                        child: Text(
                          'Start the conversation with ${counterpart.name}.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        itemCount: conversation.messages.length,
                        itemBuilder: (context, index) {
                          final message = conversation.messages[index];
                          final isSent = message.senderId == currentUserId;
                          return _MessageBubble(
                            message: message,
                            isSent: isSent,
                          );
                        },
                      ),
              ),
            ),
          ),
          _MessageComposer(
            controller: _messageController,
            onSend: _handleSend,
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.isSent,
  });

  final ChatMessage message;
  final bool isSent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final maxBubbleWidth = math.min(
      MediaQuery.sizeOf(context).width * 0.75,
      480.0,
    );

    final bubbleColor = isSent
        ? colorScheme.primaryContainer
        : colorScheme.surfaceContainerHighest;
    final textColor =
        isSent ? colorScheme.onPrimaryContainer : colorScheme.onSurface;
    final timestampText = formatMessageTime(message.createdAt);
    final statusLabel = message.isRead ? 'Read' : 'Sent';
    final metaText = isSent ? '$timestampText  $statusLabel' : timestampText;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxBubbleWidth),
          child: Column(
            crossAxisAlignment:
                isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isSent ? 16 : 4),
                    bottomRight: Radius.circular(isSent ? 4 : 16),
                  ),
                ),
                child: Text(
                  message.content,
                  style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  metaText,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageComposer extends StatelessWidget {
  const _MessageComposer({
    required this.controller,
    required this.onSend,
  });

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(
            top: BorderSide(color: colorScheme.outlineVariant),
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => onSend(),
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Write a message...',
                      filled: true,
                      fillColor: colorScheme.surfaceContainerLow,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: colorScheme.outlineVariant,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: colorScheme.outlineVariant,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: onSend,
                  tooltip: 'Send message',
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
