import '../domain/auth_repository.dart';
import '../domain/user.dart';

class InMemoryAuthRepository implements AuthRepository {
  User? _currentUser;

  @override
  Future<User?> signIn({required String email, required String password}) async {
    if (email.trim().isEmpty || password.isEmpty) return null;
    final normalizedEmail = email.trim().toLowerCase();
    final role = switch (normalizedEmail.split('@').first) {
      'teacher' => UserRole.teacher,
      'leader' => UserRole.schoolLeader,
      'admin' => UserRole.appAdmin,
      _ => UserRole.parent,
    };
    _currentUser = User(
      id: normalizedEmail,
      name: normalizedEmail.split('@').first,
      email: email.trim(),
      role: role,
    );
    return _currentUser;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
  }
}
