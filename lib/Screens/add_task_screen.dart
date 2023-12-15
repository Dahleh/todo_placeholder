import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_placeholder/Helper/sizeHelper.dart';
import 'package:todo_placeholder/Network/api.dart';
import 'package:todo_placeholder/Widgets/common_dialog.dart';
import 'package:todo_placeholder/Widgets/submit_button.dart';
import 'package:todo_placeholder/Widgets/textfield_with_title.dart';

class AddTask extends StatefulWidget {
  static const String route = "/add";
  final bool isEdit;
  final int id;
  final String title;
  final bool isCompleted;
  const AddTask({
    Key? key,
    this.isEdit = false,
    this.id = 0,
    this.title = "",
    this.isCompleted = false,
  }) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isCompleted = false;
  @override
  void initState() {
    if (widget.isEdit) {
      titleController.text = widget.title;
      isCompleted = widget.isCompleted;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add new task",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFieldWithTitle(
              title: "Title",
              controller: titleController,
              isRequired: true,
            ),
            Gap(displayHeight(context) * 0.02),
            TextFieldWithTitle(
              title: "Description",
              controller: descriptionController,
              isMultiline: true,
              isRequired: true,
            ),
            Gap(displayHeight(context) * 0.02),
            CheckboxListTile(
                value: isCompleted,
                activeColor: Theme.of(context).colorScheme.primary,
                checkColor: Colors.white,
                side:
                    BorderSide(color: Theme.of(context).colorScheme.secondary),
                title: Text(
                  "Complete",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onChanged: (value) {
                  setState(() {
                    isCompleted = value!;
                  });
                }),
            Gap(displayHeight(context) * 0.04),
            SubmitButton(
              title: "Add",
              onTap: () async {
                if (titleController.text.isEmpty ||
                    descriptionController.text.isEmpty) {
                  commonDialog(context, () {}, () {
                    Navigator.pop(context);
                  }, "Warning", "Please fill the required fields", "Close",
                      "Close", false);
                } else {
                  context.loaderOverlay.show();
                  bool success = false;
                  if (widget.isEdit) {
                    success = await Api().updateTask(
                        context, widget.id, widget.title, widget.isCompleted);
                  } else {
                    success = await Api()
                        .createTask(context, titleController.text, isCompleted);
                  }
                  if (context.mounted) context.loaderOverlay.hide();
                  if (context.mounted) {
                    if (success) {
                      Navigator.pop(context);
                    } else {
                      commonDialog(context, () {}, () {
                        Navigator.pop(context);
                      }, "Warning", "Somthing went wrong!", "Close", "Close",
                          false);
                    }
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
