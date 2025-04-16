import '../entities/user.dart';

abstract class UserRepository {
  void createUser(User user);
  User? getUser(String id);
  List<User> getAllUsers();
  void updateUser(User user);
  void deleteUser(String id);
}
