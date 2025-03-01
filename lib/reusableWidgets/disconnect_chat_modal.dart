import 'package:flutter/material.dart';

void openBox(BuildContext context, Function(bool) onYesFunction,
    Function(int) setIndex) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 100,
        width: 100,
        padding: const EdgeInsets.all(0),
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: const Text(
            'Are you sure you want to end the chat?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => {onYesFunction(false), setIndex(1)},
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    },
  );
}
