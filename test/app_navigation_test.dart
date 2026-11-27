// Generated with Claude, reviewed by Tamirat Petros

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parentlink/app.dart';

void main() {
  testWidgets('parent can open the child detail screen from the drawer', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: ParentLinkApp()));
    await tester.pumpAndSettle();

    expect(find.text('ParentLink'), findsOneWidget);
    await tester.enterText(
      find.byType(TextField).at(0),
      'parent@parentlink.test',
    );
    await tester.enterText(find.byType(TextField).at(1), 'demo');
    await tester.ensureVisible(find.text('Sign in'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Your children'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Child detail'));
    await tester.pumpAndSettle();

    expect(find.text('Mimi Bekele'), findsOneWidget);
    expect(find.text('Attendance'), findsOneWidget);
    expect(find.text('Grades'), findsOneWidget);
    expect(find.text('Behavior'), findsOneWidget);
    expect(find.text('Check-in/out'), findsOneWidget);
  });

  testWidgets('teacher can navigate to the report entry form', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ParentLinkApp()));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField).at(0),
      'teacher@parentlink.test',
    );
    await tester.enterText(find.byType(TextField).at(1), 'demo');
    await tester.ensureVisible(find.text('Sign in'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Your class'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add grade / behavior'));
    await tester.pumpAndSettle();

    expect(find.text('Add a report'), findsOneWidget);
    expect(find.text('Save report'), findsOneWidget);
  });
}
