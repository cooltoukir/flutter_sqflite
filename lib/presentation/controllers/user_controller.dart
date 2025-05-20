import 'package:get/get.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

class UserController extends GetxController {
  var users = <User>[].obs;
  final _repo = UserRepository();

  Future<void> loadUsers() async {
    users.value = await _repo.getUsers();
  }

  Future<void> addUser(String name) async {
    await _repo.insertUser(User(userName: name));
    loadUsers();
  }

  Future<void> updateUser(User user) async {
    await _repo.updateUser(user);
    loadUsers();
  }

  Future<void> deleteUser(int id) async {
    await _repo.deleteUser(id);
    loadUsers();
  }
}
