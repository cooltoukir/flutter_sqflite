import 'package:get/get.dart';
import '../../data/models/todo_model.dart';
import '../../data/repositories/todo_repository.dart';

class TodoController extends GetxController {
  final RxList<Todo> todos = <Todo>[].obs;
  final TodoRepository _repository = TodoRepository();

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  /// Loads all todos from the database and updates the list
  Future<void> loadTodos() async {
    try {
      final data = await _repository.getTodos();
      todos.value = data;
    } catch (e) {
      print('Failed to load todos: $e');
    }
  }

  /// Adds a new todo
  Future<void> addTodo(String content) async {
    if (content.trim().isEmpty) return;
    try {
      final todo = Todo(content: content.trim());
      await _repository.insertTodo(todo);
      await loadTodos();
    } catch (e) {
      print('Failed to add todo: $e');
    }
  }

  /// Updates an existing todo
  Future<void> updateTodo(Todo todo) async {
    if (todo.taskId == null || todo.content.trim().isEmpty) return;
    try {
      await _repository.updateTodo(todo);
      await loadTodos();
    } catch (e) {
      print('Failed to update todo: $e');
    }
  }

  /// Deletes a todo by taskId
  Future<void> deleteTodo(int taskId) async {
    try {
      await _repository.deleteTodo(taskId);
      await loadTodos();
    } catch (e) {
      print('Failed to delete todo: $e');
    }
  }

  /// Clears all todos
  Future<void> clearAll() async {
    try {
      for (final todo in todos) {
        await _repository.deleteTodo(todo.taskId!);
      }
      await loadTodos();
    } catch (e) {
      print('Failed to clear todos: $e');
    }
  }
}
