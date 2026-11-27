// Generated with Claude, reviewed by Tamirat Petros

import '../../auth/domain/user.dart';
import '../domain/users_repository.dart';

class InMemoryUsersRepository implements UsersRepository {
  @override
  List<User> loadUsers() => const [
    User(
      id: 'u1',
      name: 'Mimi Bekele',
      email: 'mimi.parent@example.test',
      role: UserRole.parent,
    ),
    User(
      id: 'u2',
      name: 'Ms. Selam',
      email: 'selam.teacher@example.test',
      role: UserRole.teacher,
    ),
    User(
      id: 'u3',
      name: 'Principal Aster',
      email: 'aster.leader@example.test',
      role: UserRole.schoolLeader,
    ),
  ];
}
