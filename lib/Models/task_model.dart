import 'dart:convert';

class Task {
  int id;
  String title;
  bool isCompleted;
  Task({
    this.id = 0,
    this.title = "",
    this.isCompleted = false,
  });

  static Map<String, dynamic> toMap(Task task) => {
        'id': task.id,
        'title': task.title,
        'completed': task.isCompleted,
      };

  static String encode(List<Task> tasks) => json.encode(
        tasks.map<Map<String, dynamic>>((task) => Task.toMap(task)).toList(),
      );

  static List<Task> decode(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map<Task>((item) => Task.fromJson(item))
          .toList();

  factory Task.fromJson(Map<String, dynamic> source) {
    return Task(
      id: source['id'] ?? 0,
      title: source['title'] ?? '',
      isCompleted: source['completed'] ?? false,
    );
  }
}
