class TodoModel {
  final int? id;
  final String title;
  final String description;
  final DateTime time;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.time,
  });

  TodoModel.fromTodo(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        time = map['time'];

  Map<String, dynamic> toTodoMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time.toString(),
    };
  }
}
