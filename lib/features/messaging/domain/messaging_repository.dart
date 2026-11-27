import 'chat_message.dart';
import 'conversation.dart';

/// Abstraction for reading and updating local messaging threads.
abstract interface class MessagingRepository {
  List<Conversation> getConversations();

  ChatMessage sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
  });

  void markAsRead(String conversationId);
}
