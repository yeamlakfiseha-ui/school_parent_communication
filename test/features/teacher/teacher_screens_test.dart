import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parentlink/app.dart';

Future<void> _signInAsTeacher(WidgetTester tester) async {
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
}

void main() {
  testWidgets('teacher can mark student attendance and update today count', (
    tester,
  ) async {
    await _signInAsTeacher(tester);

    expect(find.text('Your class'), findsOneWidget);
    expect(find.text('Mimi Bekele'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.text('Absent').first);
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('teacher can submit a grade and a behavior report', (
    tester,
  ) async {
    await _signInAsTeacher(tester);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add grade / behavior'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(1), '92');
    await tester.ensureVisible(find.text('Save report'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save report'));
    await tester.pumpAndSettle();

    expect(find.text('Grade added to the sample records.'), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Behavior'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Behavior'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextField).first,
      'Asked thoughtful questions during lab.',
    );
    await tester.ensureVisible(find.text('Save report'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save report'));
    await tester.pumpAndSettle();

    expect(
      find.text('Behavior note added to the sample records.'),
      findsOneWidget,
    );
  });
}
