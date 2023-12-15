import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_placeholder/Models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];

  Future<void> updateTasksList(allTasks) async {
    tasks = allTasks;
    notifyListeners();
  }

  Future<void> updateTaskComplete(
      int id, bool isCompleted, String title) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    tasks.firstWhere((element) => element.id == id).isCompleted = isCompleted;
    tasks.firstWhere((element) => element.id == id).title = title;
    final String encodedData = Task.encode(tasks);
    await prefs.setString('tasks', encodedData);
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    tasks.removeWhere((element) => element.id == id);
    final String encodedData = Task.encode(tasks);
    await prefs.setString('tasks', encodedData);
    notifyListeners();
  }

  Future<void> createTask(Task newTask) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    tasks.add(newTask);
    final String encodedData = Task.encode(tasks);
    await prefs.setString('tasks', encodedData);
    notifyListeners();
  }
}
