import 'package:crud_project/domain/entities/user.dart';
import 'package:crud_project/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final List<User> _users = [];

  @override
  void createUser(User user) {
    _users.add(user);
  }

  @override
  void deleteUser(String id) {
    _users.removeWhere((u) => u.id == id);
  }

  @override
  List<User> getAllUsers() {
    return [..._users];
  }

  @override
  User? getUser(String id) {
    final foundUsers = _users.where((u) => u.id == id);
    return foundUsers.isNotEmpty ? foundUsers.first : null;
  }


  @override
  void updateUser(User user) {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
    }
  }
}
