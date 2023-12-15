import 'package:flutter/material.dart';

Future<void> commonDialog(
    BuildContext context,
    VoidCallback onTapYes,
    VoidCallback onTapNo,
    String title,
    String content,
    String yesButton,
    String noButton,
    [bool showYesBtn = true]) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          content: Text(
            content,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            Visibility(
              visible: showYesBtn,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.fromLTRB(20, 5, 20, 5)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: onTapYes,
                child: Text(
                  yesButton,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 13),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.fromLTRB(20, 5, 20, 5)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1, color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              onPressed: onTapNo,
              child: Text(
                noButton,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        );
      });
}
