import 'package:flutter/material.dart';
import 'package:glint/utils/variables.dart';

class ArrowButton extends StatefulWidget {
  const ArrowButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  State<ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<ArrowButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(darkGreen),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: widget.onPressed,
        child: Icon(
          Icons.arrow_forward,
          color: lightPink,
        ));
  }
}
