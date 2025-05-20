import '../db/database_helper.dart';
import '../models/todo_model.dart';

class TodoRepository {
  final dbHelper = DatabaseHelper();

  Future<int> insertTodo(Todo todo) async {
    final db = await dbHelper.database;
    return await db.insert('todos', todo.toMap());
  }

  Future<List<Todo>> getTodos() async {
    final db = await dbHelper.database;
    final result = await db.query('todos');
    return result.map((e) => Todo.fromMap(e)).toList();
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await dbHelper.database;
    return await db.update('todos', todo.toMap(), where: 'taskId = ?', whereArgs: [todo.taskId]);
  }

  Future<int> deleteTodo(int id) async {
    final db = await dbHelper.database;
    return await db.delete('todos', where: 'taskId = ?', whereArgs: [id]);
  }
}
