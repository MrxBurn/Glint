import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.children});

  final Widget children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/illustrations/background.svg',
            fit: BoxFit.cover,
          ),
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          children,
        ],
      ),
    );
  }
}
