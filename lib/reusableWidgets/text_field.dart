import 'package:flutter/material.dart';
import 'package:glint/utils/variables.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.width,
      required this.labelText});

  final TextEditingController controller;
  final double? width;
  final String labelText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        cursorHeight: 16,
        decoration: InputDecoration(
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(width: 2)),
          border: const OutlineInputBorder(borderSide: BorderSide(width: 2)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Text(widget.labelText),
          labelStyle: const TextStyle(color: Colors.black),
          isDense: true,
          contentPadding: const EdgeInsets.all(6),
        ),
        style: fontSize12,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: widget.controller,
      ),
    );
  }
}
