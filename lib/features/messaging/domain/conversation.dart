import '../../auth/domain/user.dart';
import 'chat_message.dart';

/// A direct messaging thread between the signed-in user and a [contact].
class Conversation {
  const Conversation({
    required this.id,
    required this.contact,
    required this.messages,
    this.contextLabel,
    this.unreadCount = 0,
  });

  final String id;
  final User contact;
  final String? contextLabel;
  final List<ChatMessage> messages;
  final int unreadCount;

  bool get hasUnread => unreadCount > 0;

  ChatMessage? get lastMessage => messages.isNotEmpty ? messages.last : null;

  DateTime? get lastMessageTime => lastMessage?.sentAt;

  Conversation copyWith({
    String? id,
    User? contact,
    String? contextLabel,
    List<ChatMessage>? messages,
    int? unreadCount,
  }) =>
      Conversation(
        id: id ?? this.id,
        contact: contact ?? this.contact,
        contextLabel: contextLabel ?? this.contextLabel,
        messages: messages ?? this.messages,
        unreadCount: unreadCount ?? this.unreadCount,
      );
}
