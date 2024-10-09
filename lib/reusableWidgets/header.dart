import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: SizedBox(
        child: Center(child: Image.asset('assets/illustrations/logo.png')),
      ),
    );
  }
}
