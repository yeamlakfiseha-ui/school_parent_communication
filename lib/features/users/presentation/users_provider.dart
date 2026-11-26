import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/domain/user.dart';
import '../data/in_memory_users_repository.dart';
import '../domain/users_repository.dart';

final usersRepositoryProvider = Provider<UsersRepository>(
  (ref) => InMemoryUsersRepository(),
);
final usersProvider = NotifierProvider<UsersController, List<User>>(
  UsersController.new,
);
final linkedChildrenProvider =
    NotifierProvider<LinkedChildrenController, Map<String, String>>(
      LinkedChildrenController.new,
    );

class UsersController extends Notifier<List<User>> {
  @override
  List<User> build() => ref.read(usersRepositoryProvider).loadUsers();

  String add({
    required String name,
    required String email,
    required UserRole role,
  }) {
    final id = 'u-${DateTime.now().microsecondsSinceEpoch}';
    state = [...state, User(id: id, name: name, email: email, role: role)];
    return id;
  }

  void remove(String id) =>
      state = state.where((user) => user.id != id).toList();
}

class LinkedChildrenController extends Notifier<Map<String, String>> {
  @override
  Map<String, String> build() => const {'u1': 's-101'};

  void link(String userId, String studentId) =>
      state = {...state, userId: studentId};
}
