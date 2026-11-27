/// A single message exchanged inside a [Conversation].
class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.createdAt,
    this.isRead = false,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String content;
  final bool isRead;
  final DateTime createdAt;

  ChatMessage copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? receiverId,
    String? content,
    bool? isRead,
    DateTime? createdAt,
  }) =>
      ChatMessage(
        id: id ?? this.id,
        conversationId: conversationId ?? this.conversationId,
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        content: content ?? this.content,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt ?? this.createdAt,
      );
}
