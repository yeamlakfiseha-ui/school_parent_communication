import 'user.dart';

abstract interface class AuthRepository {
  Future<User?> signIn({required String email, required String password});
  Future<void> signOut();
}
