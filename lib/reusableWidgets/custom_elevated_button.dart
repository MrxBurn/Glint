import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  const CustomElevatedButton(
      {super.key,
      this.onPressed,
      this.isLoading = false,
      this.style,
      this.child});

  final void Function()? onPressed;
  final bool isLoading;
  final ButtonStyle? style;
  final Widget? child;

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: widget.style,
        onPressed: widget.onPressed,
        child: !widget.isLoading
            ? widget.child
            : Transform.scale(
                scale: 0.5, child: const CircularProgressIndicator()));
  }
}
