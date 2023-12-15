import 'package:flutter/material.dart';
import 'package:todo_placeholder/Helper/sizeHelper.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const SubmitButton({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: displayWidth(context) * 0.6,
      child: ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.fromLTRB(30, 15, 30, 15)),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.outlineVariant),
                    borderRadius: BorderRadius.circular(25)))),
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary, fontSize: 16),
        ),
      ),
    );
  }
}
