import 'package:flutter/material.dart';
import 'package:glint/reusableWidgets/custom_elevated_button.dart';
import 'package:glint/utils/variables.dart';

class ArrowButton extends StatefulWidget {
  const ArrowButton({super.key, this.onPressed, this.isDisabled = false});

  final void Function()? onPressed;
  final bool isDisabled;

  @override
  State<ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<ArrowButton> {
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      style: ButtonStyle(
        backgroundColor: widget.isDisabled
            ? const WidgetStatePropertyAll(Colors.grey)
            : WidgetStatePropertyAll(darkGreen),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: widget.isDisabled ? null : widget.onPressed,
      child: Icon(
        Icons.arrow_forward,
        color: widget.isDisabled ? darkGreen : lightPink,
      ),
    );
  }
}
