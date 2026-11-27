import '../../auth/domain/user.dart';
import 'chat_message.dart';

/// A direct messaging thread between a parent and a teacher about a student.
class Conversation {
  const Conversation({
    required this.id,
    required this.parentId,
    required this.teacherId,
    required this.studentId,
    required this.parent,
    required this.teacher,
    required this.messages,
    this.studentName,
  });

  final String id;
  final String parentId;
  final String teacherId;
  final String studentId;
  final User parent;
  final User teacher;
  final String? studentName;
  final List<ChatMessage> messages;

  bool includesUser(String userId) =>
      parentId == userId || teacherId == userId;

  User counterpartFor(String currentUserId) =>
      currentUserId == teacherId ? parent : teacher;

  int unreadCountFor(String currentUserId) => messages
      .where((message) => !message.isRead && message.senderId != currentUserId)
      .length;

  bool hasUnreadFor(String currentUserId) => unreadCountFor(currentUserId) > 0;

  ChatMessage? get lastMessage => messages.isNotEmpty ? messages.last : null;

  DateTime? get lastMessageTime => lastMessage?.createdAt;

  Conversation copyWith({
    String? id,
    String? parentId,
    String? teacherId,
    String? studentId,
    User? parent,
    User? teacher,
    String? studentName,
    List<ChatMessage>? messages,
  }) =>
      Conversation(
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        teacherId: teacherId ?? this.teacherId,
        studentId: studentId ?? this.studentId,
        parent: parent ?? this.parent,
        teacher: teacher ?? this.teacher,
        studentName: studentName ?? this.studentName,
        messages: messages ?? this.messages,
      );
}
