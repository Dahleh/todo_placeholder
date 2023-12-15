import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_placeholder/Models/task_model.dart';
import 'package:todo_placeholder/Providers/task_povider.dart';

class Api {
  static String baseUrl = "https://jsonplaceholder.typicode.com/";
  Future<List<Task>> getAllTasks(BuildContext context) async {
    List<Task> tasks = [];

    Response response;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null && tasksString.isNotEmpty) {
      tasks = Task.decode(tasksString);
    } else {
      try {
        response = await Dio().get("${baseUrl}todos");
        if (response.statusCode == 200) {
          for (var item in response.data) {
            tasks.add(Task.fromJson(item));
          }
        }
      } on DioException catch (e) {
        if (kDebugMode) {
          print("URL: ${e.response!.realUri}");
          print("Error Message: ${e.message}");
        }
      }
    }
    if (context.mounted) {
      context.read<TaskProvider>().updateTasksList(tasks);
      final String encodedData = Task.encode(tasks);
      await prefs.setString('tasks', encodedData);
    }

    return tasks;
  }

  Future<bool> updateTask(
      BuildContext context, int id, String title, bool isCompleted) async {
    Response response;
    bool success = false;

    try {
      response = await Dio().put("${baseUrl}todos/${id}",
          data: {"completed": isCompleted, "title": title});
      if (response.statusCode == 200) {
        success = true;
        if (context.mounted) {
          context
              .read<TaskProvider>()
              .updateTaskComplete(id, isCompleted, title);
        }
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("URL: ${e.response!.realUri}");
        print("Error Message: ${e.message}");
      }
    }
    return success;
  }

  Future<bool> deleteTask(BuildContext context, int id) async {
    bool success = false;
    Response response;

    try {
      response = await Dio().delete("${baseUrl}todos/$id");
      if (response.statusCode == 200) {
        success = true;
        if (context.mounted) context.read<TaskProvider>().deleteTask(id);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("URL: ${e.response!.realUri}");
        print("Error Message: ${e.message}");
      }
    }
    return success;
  }

  Future<bool> createTask(
      BuildContext context, String title, bool isCompleted) async {
    bool success = false;
    Response response;

    try {
      response = await Dio().post(
        "${baseUrl}todos",
        data: {
          'title': title,
          'completed': isCompleted,
        },
      );
      if (response.statusCode == 201) {
        success = true;
        if (context.mounted) {
          context.read<TaskProvider>().createTask(Task.fromJson(response.data));
        }
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("URL: ${e.response!.realUri}");
        print("Error Message: ${e.message}");
      }
    }
    return success;
  }
}
