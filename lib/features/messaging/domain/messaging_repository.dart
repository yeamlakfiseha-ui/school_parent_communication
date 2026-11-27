import 'chat_message.dart';
import 'conversation.dart';

/// Abstraction for reading and updating local messaging threads.
abstract interface class MessagingRepository {
  List<Conversation> getConversationsForUser(String userId);

  ChatMessage sendMessage({
    required String conversationId,
    required String senderId,
    required String receiverId,
    required String content,
  });

  void markAsRead({
    required String conversationId,
    required String readerId,
  });
}
