import 'package:flutter/material.dart';
import 'package:glint/utils/variables.dart';

class ErrorField extends StatelessWidget {
  const ErrorField({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Text(
      error,
      style: TextStyle(color: redError, fontSize: 12),
    );
  }
}
