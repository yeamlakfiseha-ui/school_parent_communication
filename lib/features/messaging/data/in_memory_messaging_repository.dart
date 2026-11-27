import '../../auth/domain/user.dart';
import '../domain/chat_message.dart';
import '../domain/conversation.dart';
import '../domain/messaging_repository.dart';

/// In-memory mock implementation of [MessagingRepository] for Milestone 1.
class InMemoryMessagingRepository implements MessagingRepository {
  InMemoryMessagingRepository({List<Conversation>? initialConversations})
      : _conversations =
            List<Conversation>.of(initialConversations ?? _defaultConversations());

  final List<Conversation> _conversations;
  int _nextMessageId = 100;

  @override
  List<Conversation> getConversationsForUser(String userId) => List.unmodifiable(
        _conversations.where((conversation) => conversation.includesUser(userId)),
      );

  @override
  ChatMessage sendMessage({
    required String conversationId,
    required String senderId,
    required String receiverId,
    required String content,
  }) {
    final trimmed = content.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(
        content,
        'content',
        'Message content cannot be empty.',
      );
    }

    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index == -1) {
      throw StateError('Conversation "$conversationId" not found.');
    }

    final message = ChatMessage(
      id: 'msg-${_nextMessageId++}',
      conversationId: conversationId,
      senderId: senderId,
      receiverId: receiverId,
      content: trimmed,
      isRead: false,
      createdAt: DateTime.now(),
    );

    final current = _conversations[index];
    _conversations[index] = current.copyWith(
      messages: [...current.messages, message],
    );
    return message;
  }

  @override
  void markAsRead({
    required String conversationId,
    required String readerId,
  }) {
    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index == -1) return;
    final current = _conversations[index];
    var changed = false;
    final updatedMessages = current.messages.map((message) {
      if (!message.isRead && message.senderId != readerId) {
        changed = true;
        return message.copyWith(isRead: true);
      }
      return message;
    }).toList();

    if (!changed) return;
    _conversations[index] = current.copyWith(messages: updatedMessages);
  }

  static List<Conversation> _defaultConversations() {
    final now = DateTime.now();

    const parentDemo = User(
      id: 'parent@parentlink.test',
      name: 'Selam Tesfaye',
      email: 'parent@parentlink.test',
      role: UserRole.parent,
    );
    const teacherDemo = User(
      id: 'teacher@parentlink.test',
      name: 'Ms. Hanna Bekele',
      email: 'teacher@parentlink.test',
      role: UserRole.teacher,
    );
    const teacherDawit = User(
      id: 'teacher-dawit@parentlink.test',
      name: 'Mr. Dawit Tadesse',
      email: 'teacher-dawit@parentlink.test',
      role: UserRole.teacher,
    );
    const teacherTigist = User(
      id: 'teacher-tigist@parentlink.test',
      name: 'Ms. Tigist Alemu',
      email: 'teacher-tigist@parentlink.test',
      role: UserRole.teacher,
    );
    const parentMeron = User(
      id: 'parent-meron@parentlink.test',
      name: 'Meron Girma',
      email: 'parent-meron@parentlink.test',
      role: UserRole.parent,
    );
    const parentKebede = User(
      id: 'parent-kebede@parentlink.test',
      name: 'Kebede Alemu',
      email: 'parent-kebede@parentlink.test',
      role: UserRole.parent,
    );

    return [
      Conversation(
        id: 'conv-1',
        parentId: parentDemo.id,
        teacherId: teacherDemo.id,
        studentId: 'student-abigail',
        studentName: 'Abigail T. · Grade 7 Math',
        parent: parentDemo,
        teacher: teacherDemo,
        messages: [
          ChatMessage(
            id: 'm1',
            conversationId: 'conv-1',
            senderId: parentDemo.id,
            receiverId: teacherDemo.id,
            content:
                'Hello, Ms. Hanna. Abigail was absent Wednesday. Is there homework to catch up on?',
            isRead: true,
            createdAt: now.subtract(const Duration(minutes: 45)),
          ),
          ChatMessage(
            id: 'm2',
            conversationId: 'conv-1',
            senderId: teacherDemo.id,
            receiverId: parentDemo.id,
            content:
                'Hello! Yes, exercises 4–6 on page 52. She can show me on Monday.',
            isRead: false,
            createdAt: now.subtract(const Duration(minutes: 18)),
          ),
          ChatMessage(
            id: 'm3',
            conversationId: 'conv-1',
            senderId: teacherDemo.id,
            receiverId: parentDemo.id,
            content:
                'Also, please remind her to bring her geometry set for Tuesday.',
            isRead: false,
            createdAt: now.subtract(const Duration(minutes: 12)),
          ),
        ],
      ),
      Conversation(
        id: 'conv-2',
        parentId: parentDemo.id,
        teacherId: teacherDawit.id,
        studentId: 'student-abigail',
        studentName: 'Abigail T. · Grade 7 Science',
        parent: parentDemo,
        teacher: teacherDawit,
        messages: [
          ChatMessage(
            id: 'm4',
            conversationId: 'conv-2',
            senderId: teacherDawit.id,
            receiverId: parentDemo.id,
            content: 'Abigail did a great job presenting her science project today.',
            isRead: true,
            createdAt: now.subtract(const Duration(hours: 3)),
          ),
          ChatMessage(
            id: 'm5',
            conversationId: 'conv-2',
            senderId: parentDemo.id,
            receiverId: teacherDawit.id,
            content: 'Thank you for letting me know, Mr. Dawit!',
            isRead: true,
            createdAt: now.subtract(const Duration(hours: 2, minutes: 30)),
          ),
        ],
      ),
      Conversation(
        id: 'conv-3',
        parentId: parentDemo.id,
        teacherId: teacherTigist.id,
        studentId: 'student-abigail',
        studentName: 'Abigail T. · Grade 7B',
        parent: parentDemo,
        teacher: teacherTigist,
        messages: [
          ChatMessage(
            id: 'm6',
            conversationId: 'conv-3',
            senderId: parentDemo.id,
            receiverId: teacherTigist.id,
            content: 'Good morning Ms. Tigist, Abigail will arrive 10 minutes late.',
            isRead: true,
            createdAt: now.subtract(const Duration(days: 2)),
          ),
          ChatMessage(
            id: 'm7',
            conversationId: 'conv-3',
            senderId: teacherTigist.id,
            receiverId: parentDemo.id,
            content: 'Noted, thank you for the heads-up.',
            isRead: true,
            createdAt: now.subtract(const Duration(days: 2)),
          ),
        ],
      ),
      Conversation(
        id: 'conv-4',
        parentId: parentMeron.id,
        teacherId: teacherDemo.id,
        studentId: 'student-sara',
        studentName: 'Sara M. · Grade 7 Math',
        parent: parentMeron,
        teacher: teacherDemo,
        messages: [
          ChatMessage(
            id: 'm8',
            conversationId: 'conv-4',
            senderId: parentMeron.id,
            receiverId: teacherDemo.id,
            content: 'Good afternoon Ms. Hanna, could we review Sara’s quiz score?',
            isRead: false,
            createdAt: now.subtract(const Duration(hours: 1, minutes: 10)),
          ),
        ],
      ),
      Conversation(
        id: 'conv-5',
        parentId: parentKebede.id,
        teacherId: teacherDemo.id,
        studentId: 'student-ruth',
        studentName: 'Ruth K. · Grade 7 Math',
        parent: parentKebede,
        teacher: teacherDemo,
        messages: [
          ChatMessage(
            id: 'm9',
            conversationId: 'conv-5',
            senderId: teacherDemo.id,
            receiverId: parentKebede.id,
            content: 'Ruth completed all of this week’s math assignments.',
            isRead: true,
            createdAt: now.subtract(const Duration(days: 1, hours: 3)),
          ),
          ChatMessage(
            id: 'm10',
            conversationId: 'conv-5',
            senderId: parentKebede.id,
            receiverId: teacherDemo.id,
            content: 'That is wonderful to hear, thank you!',
            isRead: true,
            createdAt: now.subtract(const Duration(days: 1, hours: 2)),
          ),
        ],
      ),
    ];
  }
}
