import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/auth_controller.dart';
import '../data/in_memory_messaging_repository.dart';
import '../domain/conversation.dart';
import '../domain/messaging_repository.dart';

final messagingRepositoryProvider = Provider<MessagingRepository>(
  (ref) => InMemoryMessagingRepository(),
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
  List<Conversation> build() =>
      ref.watch(messagingRepositoryProvider).getConversations();

  bool sendMessage({
    required String conversationId,
    required String text,
  }) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return false;

    final senderId =
        ref.read(authControllerProvider).asData?.value?.id ?? 'current-user';
    final repository = ref.read(messagingRepositoryProvider);
    repository.sendMessage(
      conversationId: conversationId,
      senderId: senderId,
      text: trimmed,
    );
    state = List<Conversation>.unmodifiable(repository.getConversations());
    return true;
  }

  void markAsRead(String conversationId) {
    final repository = ref.read(messagingRepositoryProvider);
    repository.markAsRead(conversationId);
    state = List<Conversation>.unmodifiable(repository.getConversations());
  }
}
