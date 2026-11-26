import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import 'auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('ParentLink')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Demo accounts: parent@parentlink.test, teacher@parentlink.test, '
                  'leader@parentlink.test, admin@parentlink.test',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: auth.isLoading
                      ? null
                      : () async {
                          final signedIn = await ref
                              .read(authControllerProvider.notifier)
                              .signIn(email: _email.text, password: _password.text);
                          final user = ref.read(authControllerProvider).asData?.value;
                          if (signedIn && user != null && context.mounted) {
                            context.go(AppRoutes.homeForRole(user.role.name));
                          }
                        },
                  child: auth.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Sign in'),
                ),
                if (auth.hasError)
                  Text('Sign in failed: ${auth.error}',
                      style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
