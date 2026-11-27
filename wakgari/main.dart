// Demo entrypoint for the parent-side work in this folder.
//
// It composes the new screens with the app theme and the demo parent account
// without changing any shared file. Run it with:
//
//   flutter run -t wakgari/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parentlink/core/theme/app_theme.dart';
import 'package:parentlink/features/auth/presentation/auth_controller.dart';

import 'features/parent/presentation/child_detail_screen.dart';
import 'features/parent/presentation/parent_home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container
      .read(authControllerProvider.notifier)
      .signIn(email: 'parent@parentlink.test', password: 'demo');
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const ParentDemoApp(),
    ),
  );
}

class ParentDemoApp extends StatelessWidget {
  const ParentDemoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'ParentLink · parent',
    theme: AppTheme.light,
    home: const ParentDemoShell(),
  );
}

class ParentDemoShell extends StatelessWidget {
  const ParentDemoShell({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Parent')),
    body: ParentHomeScreen(onOpenChild: (id) => _openChild(context, id)),
  );

  void _openChild(BuildContext context, String id) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => ChildDetailPage(studentId: id)),
    );
  }
}

class ChildDetailPage extends StatelessWidget {
  const ChildDetailPage({super.key, required this.studentId});

  final String studentId;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Child detail')),
    body: ChildDetailScreen(
      studentId: studentId,
      onBack: () => Navigator.of(context).maybePop(),
      onOpenChild: (id) => Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => ChildDetailPage(studentId: id)),
      ),
    ),
  );
}
