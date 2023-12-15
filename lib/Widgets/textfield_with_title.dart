import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_placeholder/Helper/sizeHelper.dart';

class TextFieldWithTitle extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isRequired;
  final bool isMultiline;
  const TextFieldWithTitle({
    Key? key,
    required this.title,
    required this.controller,
    this.isRequired = false,
    this.isMultiline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Visibility(
              visible: isRequired,
              child: const Text(
                "*",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ],
        ),
        Gap(displayHeight(context) * 0.01),
        Container(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: TextField(
              controller: controller,
              maxLines: (isMultiline) ? 4 : 1,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                border: InputBorder.none,
              )),
        )
      ],
    );
  }
}
