import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/presentation/admin_screens.dart';
import '../../features/auth/domain/user.dart';
import '../../features/auth/presentation/auth_controller.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/community/presentation/community_screens.dart';
import '../../features/leadership/presentation/leadership_screens.dart';
import '../../features/messaging/presentation/chat_screen.dart';
import '../../features/messaging/presentation/messages_screen.dart';
import '../../features/parent/presentation/parent_screens.dart';
import '../../features/teacher/presentation/teacher_screens.dart';
import 'routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      if (auth.isLoading) return null;
      final user = auth.asData?.value;
      final location = state.matchedLocation;
      if (user == null)
        return location == AppRoutes.login ? null : AppRoutes.login;
      if (location == AppRoutes.login)
        return AppRoutes.homeForRole(user.role.name);
      final allowedRole = switch (location) {
        _ when location.startsWith('/parent/') => UserRole.parent,
        _ when location.startsWith('/teacher/') => UserRole.teacher,
        _ when location.startsWith('/leader/') => UserRole.schoolLeader,
        _ when location.startsWith('/admin/') => UserRole.appAdmin,
        _ => null,
      };
      if (allowedRole != null && user.role != allowedRole)
        return AppRoutes.homeForRole(user.role.name);
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
          _Page(
            AppRoutes.parentHome,
            'Home',
            Icons.home_outlined,
            (_) => const ParentHomeScreen(),
          ),
          _Page(
            AppRoutes.childDetail,
            'Child detail',
            Icons.child_care,
            (state) => ChildDetailScreen(
              studentId: state.pathParameters['studentId'] ?? 's-101',
            ),
            destination: '/parent/child/s-101',
          ),
          _Page(
            AppRoutes.termSummary,
            'Term summary',
            Icons.auto_awesome_outlined,
            (state) => TermSummaryScreen(
              studentId: state.pathParameters['studentId'] ?? 's-101',
            ),
            destination: '/parent/child/s-101/summary',
          ),
          _Page(
            AppRoutes.announcements,
            'Announcements & schedule',
            Icons.campaign_outlined,
            (_) => const AnnouncementsScreen(),
          ),
          _Page(
            AppRoutes.parentMessages,
            'Messages',
            Icons.chat_bubble_outline,
            (_) => Builder(
              builder: (context) => MessagesScreen(
                onConversationTap: (conversation) =>
                    context.push(AppRoutes.parentChatFor(conversation.id)),
              ),
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
          _Page(
            AppRoutes.teacherHome,
            'Class & attendance',
            Icons.groups_outlined,
            (_) => const TeacherHomeScreen(),
          ),
          _Page(
            AppRoutes.qrScanner,
            'QR check-in',
            Icons.qr_code_scanner,
            (_) => const QrScannerScreen(),
          ),
          _Page(
            AppRoutes.reportEntry,
            'Add grade / behavior',
            Icons.note_add_outlined,
            (_) => const ReportEntryScreen(),
          ),
          _Page(
            AppRoutes.teacherMessages,
            'Messages',
            Icons.chat_bubble_outline,
            (_) => Builder(
              builder: (context) => MessagesScreen(
                onConversationTap: (conversation) =>
                    context.push(AppRoutes.teacherChatFor(conversation.id)),
              ),
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
          _Page(
            AppRoutes.leaderHome,
            'School overview',
            Icons.dashboard_outlined,
            (_) => const SchoolOverviewScreen(),
          ),
          _Page(
            AppRoutes.postAnnouncement,
            'Post update / schedule',
            Icons.campaign_outlined,
            (_) => const PostAnnouncementScreen(),
          ),
          _Page(
            AppRoutes.schoolOverview,
            'Reports by class',
            Icons.insights_outlined,
            (_) => const SchoolOverviewScreen(),
          ),
        ],
      ),
      _roleShell(
        title: 'App administrator',
        pages: [
          _Page(
            AppRoutes.adminHome,
            'Workspace status',
            Icons.dashboard_outlined,
            (_) => const AdminHomeScreen(),
          ),
          _Page(
            AppRoutes.manageUsers,
            'Manage users',
            Icons.manage_accounts_outlined,
            (_) => const ManageUsersScreen(),
          ),
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
      builder: (context, state, child) =>
          _RoleShell(title: title, pages: pages, child: child),
      routes: [
        for (final page in pages)
          GoRoute(
            path: page.path,
            builder: (context, state) => page.builder(state),
          ),
      ],
    );

class _Page {
  const _Page(
    this.path,
    this.title,
    this.icon,
    this.builder, {
    this.destination,
  });

  final String path;
  final String title;
  final IconData icon;
  final Widget Function(GoRouterState state) builder;
  final String? destination;
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    child: const Icon(Icons.school_outlined),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ParentLink',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  for (final page in pages)
                    ListTile(
                      leading: Icon(page.icon),
                      title: Text(page.title),
                      onTap: () {
                        Navigator.pop(context);
                        context.go(page.destinationPath);
                      },
                    ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                'Nativity Girls School · Demo',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
    body: child,
  );
}
