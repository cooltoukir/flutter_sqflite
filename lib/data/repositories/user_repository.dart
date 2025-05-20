import '../db/database_helper.dart';
import '../models/user_model.dart';

class UserRepository {
  final dbHelper = DatabaseHelper();

  Future<int> insertUser(User user) async {
    final db = await dbHelper.database;
    return await db.insert('users', user.toMap());
  }

  Future<List<User>> getUsers() async {
    final db = await dbHelper.database;
    final result = await db.query('users');
    return result.map((e) => User.fromMap(e)).toList();
  }

  Future<int> updateUser(User user) async {
    final db = await dbHelper.database;
    return await db.update('users', user.toMap(), where: 'userId = ?', whereArgs: [user.userId]);
  }

  Future<int> deleteUser(int id) async {
    final db = await dbHelper.database;
    return await db.delete('users', where: 'userId = ?', whereArgs: [id]);
  }
}
