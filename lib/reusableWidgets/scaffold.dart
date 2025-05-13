import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold(
      {super.key, required this.children, this.shouldNavigateBack = false});

  final Widget children;
  final bool shouldNavigateBack;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/illustrations/background.svg',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  automaticallyImplyLeading: widget.shouldNavigateBack,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                    ),
                    child: widget.children,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
