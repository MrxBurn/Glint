import 'package:flutter/material.dart';
import 'package:glint/utils/variables.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black), boxShadow: [boxShadowBlack]),
    );
  }
}
