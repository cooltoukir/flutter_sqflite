class Todo {
  int? taskId;
  String content;

  Todo({this.taskId, required this.content});

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'content': content,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      taskId: map['taskId'],
      content: map['content'],
    );
  }
}
