import 'package:flutter/material.dart';
import 'package:glint/utils/variables.dart';

class FormContainer extends StatelessWidget {
  const FormContainer(
      {super.key, this.height = 0, this.width = 0, required this.child});

  final double height;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.white,
          border: Border.all(color: Colors.black),
          boxShadow: [boxShadowBlack]),
      child: child,
    );
  }
}
