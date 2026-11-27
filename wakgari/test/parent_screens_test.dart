import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parentlink/core/theme/app_theme.dart';
import 'package:parentlink/features/auth/presentation/auth_controller.dart';
import 'package:parentlink/features/school_data/domain/school_record.dart';
import 'package:parentlink/features/school_data/domain/school_repository.dart';
import 'package:parentlink/features/school_data/presentation/school_data_provider.dart';

import '../features/parent/presentation/child_detail_screen.dart';
import '../features/parent/presentation/parent_home_screen.dart';
import '../features/parent/presentation/parent_providers.dart';

class _FixedLinks extends ParentChildLinksController {
  _FixedLinks(this.links);

  final Map<String, List<String>> links;

  @override
  Map<String, List<String>> build() => links;
}

class _FakeSchoolRepository implements SchoolRepository {
  _FakeSchoolRepository(this.data);

  final SchoolData data;

  @override
  SchoolData loadInitialData() => data;
}

Future<ProviderContainer> _signedInContainer({
  Map<String, List<String>>? links,
  DateTime Function()? now,
  SchoolRepository? schoolRepository,
}) async {
  final container = ProviderContainer(
    overrides: [
      if (links != null)
        parentChildLinksProvider.overrideWith(() => _FixedLinks(links)),
      if (now != null) nowProvider.overrideWithValue(now),
      if (schoolRepository != null)
        schoolRepositoryProvider.overrideWithValue(schoolRepository),
    ],
  );
  addTearDown(container.dispose);
  await container
      .read(authControllerProvider.notifier)
      .signIn(email: 'parent@parentlink.test', password: 'demo');
  return container;
}

Future<void> _pump(
  WidgetTester tester,
  ProviderContainer container,
  Widget screen,
) async {
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(body: screen),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('Parent home', () {
    testWidgets('shows linked children only', (tester) async {
      final container = await _signedInContainer();
      await _pump(tester, container, ParentHomeScreen(onOpenChild: (_) {}));

      expect(find.text('Your children'), findsOneWidget);
      expect(find.text('Mimi Bekele'), findsOneWidget);
      expect(find.text('Liya Abebe'), findsOneWidget);
      expect(find.text('Hana Tesfaye'), findsNothing);
      expect(find.text('Rahel Alemu'), findsNothing);
      expect(find.textContaining('In school since'), findsOneWidget);
    });

    testWidgets('opens the tapped child', (tester) async {
      String? opened;
      final container = await _signedInContainer();
      await _pump(
        tester,
        container,
        ParentHomeScreen(onOpenChild: (id) => opened = id),
      );

      await tester.tap(find.text('Mimi Bekele'));
      await tester.pumpAndSettle();

      expect(opened, 's-101');
    });

    testWidgets('greets the parent by time of day', (tester) async {
      final container = await _signedInContainer(
        now: () => DateTime(2026, 11, 27, 9),
      );
      await _pump(tester, container, ParentHomeScreen(onOpenChild: (_) {}));

      expect(find.text('Good morning'), findsOneWidget);
    });

    testWidgets('explains an account with no linked children', (tester) async {
      final container = await _signedInContainer(links: const {});
      await _pump(tester, container, ParentHomeScreen(onOpenChild: (_) {}));

      expect(find.text('No children linked yet'), findsOneWidget);
      expect(find.text('Mimi Bekele'), findsNothing);
    });
  });

  group('Child detail', () {
    testWidgets('shows the four tabs and the attendance summary', (
      tester,
    ) async {
      final container = await _signedInContainer();
      await _pump(
        tester,
        container,
        ChildDetailScreen(studentId: 's-101', onOpenChild: (_) {}),
      );

      expect(find.text('Mimi Bekele'), findsOneWidget);
      expect(find.text('Attendance'), findsOneWidget);
      expect(find.text('Grades'), findsOneWidget);
      expect(find.text('Behavior'), findsOneWidget);
      expect(find.text('Check-in/out'), findsOneWidget);
      expect(find.text('100%'), findsOneWidget);
      expect(find.text('2 days'), findsOneWidget);
    });

    testWidgets('shows subject trends on the grades tab', (tester) async {
      final container = await _signedInContainer();
      await _pump(
        tester,
        container,
        ChildDetailScreen(studentId: 's-101', onOpenChild: (_) {}),
      );

      await tester.tap(find.text('Grades'));
      await tester.pumpAndSettle();

      expect(find.text('By subject'), findsOneWidget);
      expect(find.text('Mathematics'), findsWidgets);
      expect(find.textContaining('Average'), findsWidgets);
    });

    testWidgets('pairs gate records and marks an unclosed session', (
      tester,
    ) async {
      final container = await _signedInContainer();
      await _pump(
        tester,
        container,
        ChildDetailScreen(studentId: 's-101', onOpenChild: (_) {}),
      );

      await tester.tap(find.text('Check-in/out'));
      await tester.pumpAndSettle();

      expect(find.text('Gate sessions'), findsOneWidget);
      expect(find.textContaining('No check-out recorded yet'), findsOneWidget);
      expect(find.textContaining('In 7:42'), findsOneWidget);
    });

    testWidgets('refuses a child that is not linked to the parent', (
      tester,
    ) async {
      final container = await _signedInContainer();
      await _pump(
        tester,
        container,
        ChildDetailScreen(studentId: 's-102', onOpenChild: (_) {}),
      );

      expect(
        find.text('This child is not linked to your account'),
        findsOneWidget,
      );
      expect(find.text('Mimi Bekele'), findsNothing);
      expect(find.text('Attendance'), findsNothing);
    });

    testWidgets('lets a parent mark a concern as read', (tester) async {
      final container = await _signedInContainer(
        schoolRepository: _FakeSchoolRepository(
          SchoolData(
            attendance: const [],
            grades: const [],
            behaviorReports: [
              BehaviorReport(
                id: 'b9',
                studentId: 's-101',
                description: 'Talked during the exam.',
                severity: BehaviorSeverity.high,
                status: 'New',
                date: DateTime(2026, 11, 26),
                reportedBy: 'Ms. Selam',
              ),
            ],
            checkInOut: const [],
            announcements: const [],
            schedule: const [],
          ),
        ),
      );
      await _pump(
        tester,
        container,
        ChildDetailScreen(studentId: 's-101', onOpenChild: (_) {}),
      );

      await tester.tap(find.text('Behavior'));
      await tester.pumpAndSettle();

      expect(find.text('Mark as read'), findsOneWidget);
      await tester.tap(find.text('Mark as read'));
      await tester.pumpAndSettle();

      expect(find.text('Mark as read'), findsNothing);
      expect(find.text('Read'), findsOneWidget);
    });
  });
}
