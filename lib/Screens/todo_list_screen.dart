import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:todo_placeholder/Models/task_model.dart';
import 'package:todo_placeholder/Network/api.dart';
import 'package:todo_placeholder/Providers/task_povider.dart';
import 'package:todo_placeholder/Widgets/task_card.dart';

class TodoList extends StatefulWidget {
  static const String route = "/";
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Task> tasks = [];

  Future<List<Task>> fetchTasks() async {
    if (context.mounted) {
      context.loaderOverlay.show();
      tasks = await Api().getAllTasks(context);
    }

    if (context.mounted) context.loaderOverlay.hide();

    return tasks;
  }

  @override
  void initState() {
    fetchTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tasks = context.watch<TaskProvider>().tasks;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/add');
              },
              child: const FaIcon(FontAwesomeIcons.plus),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => fetchTasks(),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return TaskCard(task: tasks[index]);
          },
        ),
      ),
    );
  }
}
