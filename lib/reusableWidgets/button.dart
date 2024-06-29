import 'package:flutter/material.dart';
import 'package:glint/utils/variables.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, this.onPressed});

  final void Function()? onPressed;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
