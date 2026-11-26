import '../../auth/domain/user.dart';

abstract interface class UsersRepository {
  List<User> loadUsers();
}
