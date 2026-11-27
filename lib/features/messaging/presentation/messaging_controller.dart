import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/auth_controller.dart';
import '../data/in_memory_messaging_repository.dart';
import '../domain/conversation.dart';
import '../domain/messaging_repository.dart';

const defaultMessagingUserId = 'parent@parentlink.test';

final messagingRepositoryProvider = Provider<MessagingRepository>(
  (ref) => InMemoryMessagingRepository(),
);

final currentMessagingUserIdProvider = Provider<String>(
  (ref) => ref.watch(authControllerProvider).asData?.value?.id ??
      defaultMessagingUserId,
);

final messagingControllerProvider =
    NotifierProvider<MessagingController, List<Conversation>>(
  MessagingController.new,
);

final conversationByIdProvider = Provider.family<Conversation?, String>(
  (ref, conversationId) {
    final conversations = ref.watch(messagingControllerProvider);
    for (final conversation in conversations) {
      if (conversation.id == conversationId) return conversation;
    }
    return null;
  },
);

class MessagingController extends Notifier<List<Conversation>> {
  @override
  List<Conversation> build() {
    final userId = ref.watch(currentMessagingUserIdProvider);
    return ref.watch(messagingRepositoryProvider).getConversationsForUser(userId);
  }

  bool sendMessage({
    required String conversationId,
    required String content,
  }) {
    final trimmed = content.trim();
    if (trimmed.isEmpty) return false;

    final senderId = ref.read(currentMessagingUserIdProvider);
    final conversation = state.cast<Conversation?>().firstWhere(
          (c) => c?.id == conversationId,
          orElse: () => null,
        );
    if (conversation == null) return false;

    final receiverId = senderId == conversation.teacherId
        ? conversation.parentId
        : conversation.teacherId;

    final repository = ref.read(messagingRepositoryProvider);
    repository.sendMessage(
      conversationId: conversationId,
      senderId: senderId,
      receiverId: receiverId,
      content: trimmed,
    );
    state = List<Conversation>.unmodifiable(
      repository.getConversationsForUser(senderId),
    );
    return true;
  }

  void markAsRead(String conversationId) {
    final readerId = ref.read(currentMessagingUserIdProvider);
    final repository = ref.read(messagingRepositoryProvider);
    repository.markAsRead(
      conversationId: conversationId,
      readerId: readerId,
    );
    state = List<Conversation>.unmodifiable(
      repository.getConversationsForUser(readerId),
    );
  }
}
