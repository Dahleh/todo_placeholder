import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_placeholder/Helper/sizeHelper.dart';
import 'package:todo_placeholder/Models/task_model.dart';
import 'package:todo_placeholder/Network/api.dart';
import 'package:todo_placeholder/Screens/add_task_screen.dart';
import 'package:todo_placeholder/Widgets/common_dialog.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: FontAwesomeIcons.trash,
          label: 'Delete',
          onPressed: (ctx) async {
            commonDialog(context, () async {
              context.loaderOverlay.show();
              bool deleted = await Api().deleteTask(context, task.id);
              if (deleted) {
                if (context.mounted) {
                  context.loaderOverlay.hide();
                  Navigator.pop(context);
                }
              }
            }, () {
              Navigator.pop(context);
            }, "Warning", "Are you sure to delete this task?", "Yes", "No");
          },
        ),
      ]),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTask(
                        isEdit: true,
                        id: task.id,
                        title: task.title,
                        isCompleted: task.isCompleted,
                      ),
                  settings: const RouteSettings(name: '/add')));
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 8),
          height: displayHeight(context) * 0.1,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: displayWidth(context) * 0.7,
                child: Text(
                  task.title,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              GestureDetector(
                onTap: () {
                  commonDialog(context, () async {
                    context.loaderOverlay.show();
                    bool updated = await Api().updateTask(
                        context, task.id, task.title, !task.isCompleted);
                    if (updated) {
                      if (context.mounted) {
                        context.loaderOverlay.hide();
                        Navigator.pop(context);
                      }
                    }
                  }, () {
                    Navigator.pop(context);
                  },
                      "Warning",
                      (task.isCompleted)
                          ? "Are you sure you want to uncomplete the task"
                          : "Are you sure in completing the task?",
                      "Yes",
                      "No");
                },
                child: FaIcon(
                  (task.isCompleted)
                      ? FontAwesomeIcons.squareCheck
                      : FontAwesomeIcons.square,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
