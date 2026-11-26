import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/in_memory_auth_repository.dart';
import '../domain/auth_repository.dart';
import '../domain/user.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => InMemoryAuthRepository(),
);

final authControllerProvider =
    AsyncNotifierProvider<AuthController, User?>(AuthController.new);

class AuthController extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async => null;

  Future<bool> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() => ref
        .read(authRepositoryProvider)
        .signIn(email: email, password: password));
    state = result;
    return result.asData?.value != null;
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AsyncData(null);
  }
}
