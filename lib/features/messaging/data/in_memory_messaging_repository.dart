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
  List<Conversation> getConversations() => List.unmodifiable(_conversations);

  @override
  ChatMessage sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
  }) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(text, 'text', 'Message text cannot be empty.');
    }

    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index == -1) {
      throw StateError('Conversation "$conversationId" not found.');
    }

    final message = ChatMessage(
      id: 'msg-${_nextMessageId++}',
      conversationId: conversationId,
      senderId: senderId,
      text: trimmed,
      sentAt: DateTime.now(),
    );

    final current = _conversations[index];
    _conversations[index] = current.copyWith(
      messages: [...current.messages, message],
      unreadCount: 0,
    );
    return message;
  }

  @override
  void markAsRead(String conversationId) {
    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index == -1) return;
    final current = _conversations[index];
    if (current.unreadCount == 0) return;
    _conversations[index] = current.copyWith(unreadCount: 0);
  }

  static List<Conversation> _defaultConversations() {
    final now = DateTime.now();
    return [
      Conversation(
        id: 'conv-1',
        contact: const User(
          id: 'teacher-hanna',
          name: 'Ms. Hanna Bekele',
          email: 'hanna.bekele@ngs.edu.et',
          role: UserRole.teacher,
        ),
        contextLabel: 'About: Abigail T. · Grade 7 Math',
        unreadCount: 2,
        messages: [
          ChatMessage(
            id: 'm1',
            conversationId: 'conv-1',
            senderId: 'current-user',
            text:
                'Hello, Ms. Hanna. Abigail was absent Wednesday. Is there homework to catch up on?',
            sentAt: now.subtract(const Duration(minutes: 45)),
          ),
          ChatMessage(
            id: 'm2',
            conversationId: 'conv-1',
            senderId: 'teacher-hanna',
            text:
                'Hello! Yes, exercises 4–6 on page 52. She can show me on Monday.',
            sentAt: now.subtract(const Duration(minutes: 18)),
          ),
          ChatMessage(
            id: 'm3',
            conversationId: 'conv-1',
            senderId: 'teacher-hanna',
            text:
                'Also, please remind her to bring her geometry set for Tuesday.',
            sentAt: now.subtract(const Duration(minutes: 12)),
          ),
        ],
      ),
      Conversation(
        id: 'conv-2',
        contact: const User(
          id: 'teacher-dawit',
          name: 'Mr. Dawit Tadesse',
          email: 'dawit.tadesse@ngs.edu.et',
          role: UserRole.teacher,
        ),
        contextLabel: 'About: Abigail T. · Grade 7 Science',
        unreadCount: 0,
        messages: [
          ChatMessage(
            id: 'm4',
            conversationId: 'conv-2',
            senderId: 'teacher-dawit',
            text: 'Abigail did a great job presenting her science project today.',
            sentAt: now.subtract(const Duration(hours: 3)),
          ),
          ChatMessage(
            id: 'm5',
            conversationId: 'conv-2',
            senderId: 'current-user',
            text: 'Thank you for letting me know, Mr. Dawit!',
            sentAt: now.subtract(const Duration(hours: 2, minutes: 30)),
          ),
        ],
      ),
      Conversation(
        id: 'conv-3',
        contact: const User(
          id: 'leader-marta',
          name: 'Sr. Marta Hailu',
          email: 'marta.hailu@ngs.edu.et',
          role: UserRole.schoolLeader,
        ),
        contextLabel: 'School Administration',
        unreadCount: 1,
        messages: [
          ChatMessage(
            id: 'm6',
            conversationId: 'conv-3',
            senderId: 'leader-marta',
            text:
                'Reminder: Parent–teacher conference slots open tomorrow morning.',
            sentAt: now.subtract(const Duration(days: 1, hours: 2)),
          ),
        ],
      ),
      Conversation(
        id: 'conv-4',
        contact: const User(
          id: 'teacher-tigist',
          name: 'Ms. Tigist Alemu',
          email: 'tigist.alemu@ngs.edu.et',
          role: UserRole.teacher,
        ),
        contextLabel: 'Homeroom · Grade 7B',
        unreadCount: 0,
        messages: [
          ChatMessage(
            id: 'm7',
            conversationId: 'conv-4',
            senderId: 'current-user',
            text: 'Good morning Ms. Tigist, Abigail will arrive 10 minutes late.',
            sentAt: now.subtract(const Duration(days: 2)),
          ),
          ChatMessage(
            id: 'm8',
            conversationId: 'conv-4',
            senderId: 'teacher-tigist',
            text: 'Noted, thank you for the heads-up.',
            sentAt: now.subtract(const Duration(days: 2)),
          ),
        ],
      ),
    ];
  }
}
