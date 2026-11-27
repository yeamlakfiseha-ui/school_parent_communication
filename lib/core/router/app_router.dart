import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/domain/user.dart';
import '../../features/auth/presentation/auth_controller.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/messaging/presentation/chat_screen.dart';
import '../../features/messaging/presentation/messages_screen.dart';
import 'routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      if (auth.isLoading) return null;
      final user = auth.asData?.value;
      final location = state.matchedLocation;
      if (user == null) {
        return location == AppRoutes.login ? null : AppRoutes.login;
      }
      if (location == AppRoutes.login) {
        return AppRoutes.homeForRole(user.role.name);
      }

      final allowedRole = switch (location) {
        _ when location.startsWith('/parent/') => UserRole.parent,
        _ when location.startsWith('/teacher/') => UserRole.teacher,
        _ when location.startsWith('/leader/') => UserRole.schoolLeader,
        _ when location.startsWith('/admin/') => UserRole.appAdmin,
        _ => null,
      };
      if (allowedRole != null && user.role != allowedRole) {
        return AppRoutes.homeForRole(user.role.name);
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      _roleShell(
        title: 'Parent',
        pages: [
          _Page(AppRoutes.parentHome, 'Parent home'),
          _Page(AppRoutes.childDetail, 'Child detail',
              destination: '/parent/child/demo-student'),
          _Page(AppRoutes.termSummary, 'Term summary',
              destination: '/parent/child/demo-student/summary'),
          _Page(AppRoutes.announcements, 'Announcements and schedule'),
          _Page(
            AppRoutes.parentMessages,
            'Messages',
            builder: (context, state) => MessagesScreen(
              onConversationTap: (conversation) =>
                  context.push(AppRoutes.parentChatFor(conversation.id)),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.parentChat,
        builder: (context, state) => ChatScreen(
          conversationId: state.pathParameters['conversationId'] ?? '',
        ),
      ),
      _roleShell(
        title: 'Teacher',
        pages: [
          _Page(AppRoutes.teacherHome, 'Teacher home'),
          _Page(AppRoutes.qrScanner, 'QR scanner'),
          _Page(AppRoutes.reportEntry, 'Add grade / behavior report'),
          _Page(
            AppRoutes.teacherMessages,
            'Messages',
            builder: (context, state) => MessagesScreen(
              onConversationTap: (conversation) =>
                  context.push(AppRoutes.teacherChatFor(conversation.id)),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.teacherChat,
        builder: (context, state) => ChatScreen(
          conversationId: state.pathParameters['conversationId'] ?? '',
        ),
      ),
      _roleShell(
        title: 'School leader',
        pages: [
          _Page(AppRoutes.leaderHome, 'School leader home'),
          _Page(AppRoutes.postAnnouncement, 'Post announcement / schedule'),
          _Page(AppRoutes.schoolOverview, 'School overview'),
        ],
      ),
      _roleShell(
        title: 'App administrator',
        pages: [
          _Page(AppRoutes.adminHome, 'Administrator home'),
          _Page(AppRoutes.manageUsers, 'Manage users'),
        ],
      ),
    ],
  );

  ref.listen(authControllerProvider, (previous, next) => router.refresh());
  ref.onDispose(router.dispose);
  return router;
});

ShellRoute _roleShell({required String title, required List<_Page> pages}) =>
    ShellRoute(
      builder: (context, state, child) => _RoleShell(
        title: title,
        pages: pages,
        child: child,
      ),
      routes: [
        for (final page in pages)
          GoRoute(
            path: page.path,
            builder: (context, state) =>
                page.builder?.call(context, state) ??
                _FeaturePage(
                  title: page.title,
                  studentId: state.pathParameters['studentId'],
                ),
          ),
      ],
    );

class _Page {
  const _Page(this.path, this.title, {this.destination, this.builder});

  final String path;
  final String title;
  final String? destination;
  final GoRouterWidgetBuilder? builder;

  String get destinationPath => destination ?? path;
}

class _RoleShell extends ConsumerWidget {
  const _RoleShell({
    required this.title,
    required this.pages,
    required this.child,
  });

  final String title;
  final List<_Page> pages;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
              tooltip: 'Sign out',
              onPressed: () async {
                await ref.read(authControllerProvider.notifier).signOut();
                if (context.mounted) context.go(AppRoutes.login);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        drawer: Drawer(
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(title,
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                for (final page in pages)
                  ListTile(
                    title: Text(page.title),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(page.destinationPath);
                    },
                  ),
              ],
            ),
          ),
        ),
        body: child,
      );
}

class _FeaturePage extends StatelessWidget {
  const _FeaturePage({required this.title, this.studentId});

  final String title;
  final String? studentId;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            if (studentId != null) Text('Student: $studentId'),
          ],
        ),
      );
}
