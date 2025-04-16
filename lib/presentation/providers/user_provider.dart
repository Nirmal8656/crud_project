import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:crud_project/domain/repositories/user_repository_impl.dart';
import '../../domain/entities/user.dart';

final userRepoProvider = Provider((ref) => UserRepositoryImpl());

final usersProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) {
  final repo = ref.watch(userRepoProvider);
  return UserNotifier(repo);
});

class UserNotifier extends StateNotifier<List<User>> {
  final UserRepositoryImpl _repo;

  UserNotifier(this._repo) : super([]);

  void addUser(String name, String email) {
    final user = User(id: const Uuid().v4(), name: name, email: email);
    _repo.createUser(user);
    state = _repo.getAllUsers();
  }

  void updateUser(User updatedUser) {
    _repo.updateUser(updatedUser);
    state = _repo.getAllUsers();
  }

  void deleteUser(String id) {
    _repo.deleteUser(id);
    state = _repo.getAllUsers();
  }
}
