import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parentlink/features/messaging/presentation/chat_screen.dart';
import 'package:parentlink/features/messaging/presentation/messages_screen.dart';

void main() {
  testWidgets('Messages screen displays the conversation list', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: MessagesScreen(),
        ),
      ),
    );

    expect(find.text('Messages'), findsOneWidget);
    expect(find.text('Ms. Hanna Bekele'), findsOneWidget);
    expect(find.text('Mr. Dawit Tadesse'), findsOneWidget);
    expect(find.text('Sr. Marta Hailu'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('Sending a message adds it to the conversation', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ChatScreen(conversationId: 'conv-1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Ms. Hanna Bekele'), findsOneWidget);

    const newMessage = 'Thank you, Ms. Hanna! She will bring it.';
    await tester.enterText(find.byType(TextField), newMessage);
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    expect(find.text(newMessage), findsOneWidget);
  });

  testWidgets('Empty message is not added when tapping send', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ChatScreen(conversationId: 'conv-2'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '   ');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    expect(
      find.text('Please enter a message before sending.'),
      findsOneWidget,
    );
  });
}
