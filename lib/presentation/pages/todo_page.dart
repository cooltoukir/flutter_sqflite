import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presentation/controllers/todo_controller.dart';

class TodoPage extends StatelessWidget {
  final TodoController controller = Get.find();
  final TextEditingController textController = TextEditingController();

  TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Form
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter a task',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    controller.addTodo(textController.text);
                    textController.clear();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // List
            Expanded(
              child: Obx(() {
                final todos = controller.todos;
                if (todos.isEmpty) {
                  return const Center(child: Text('No todos yet.'));
                }
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (_, index) {
                    final todo = todos[index];
                    return ListTile(
                      title: Text(todo.content),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          controller.deleteTodo(todo.taskId!);
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
