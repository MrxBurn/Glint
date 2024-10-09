import 'package:flutter/material.dart';
import 'package:glint/utils/variables.dart';

class CustomTextBox extends StatefulWidget {
  const CustomTextBox(
      {super.key,
      this.width,
      required this.controller,
      this.onTap,
      this.readOnly = false,
      this.keyboardType,
      this.validator});

  final double? width;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  State<CustomTextBox> createState() => _CustomTextBoxState();
}

class _CustomTextBoxState extends State<CustomTextBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        readOnly: widget.readOnly,
        decoration: const InputDecoration(
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(color: Colors.black),
          isDense: true,
          contentPadding: EdgeInsets.all(6),
        ),
        style: fontSize12,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: widget.controller,
        onTap: widget.onTap,
      ),
    );
  }
}
