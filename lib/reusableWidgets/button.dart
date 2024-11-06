import 'package:flutter/material.dart';
import 'package:glint/reusableWidgets/custom_elevated_button.dart';
import 'package:glint/utils/variables.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, this.onPressed, required this.text});

  final void Function()? onPressed;
  final String text;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(darkGreen),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
