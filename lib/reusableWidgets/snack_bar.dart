import 'package:flutter/material.dart';

class SnackbarGlobal {
  static GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static void show(String message, [Color? color]) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: color ?? Colors.red,
      ));
  }
}
