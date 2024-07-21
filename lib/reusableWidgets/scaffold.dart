import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint/reusableWidgets/bottom_navigation_bar.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold(
      {super.key,
      required this.children,
      this.isNavigationVisible = false,
      this.shouldNavigateBack = false});

  final Widget children;
  final bool isNavigationVisible;
  final bool shouldNavigateBack;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  int _currentIndex = 1;
  void onTapCallBack(int value) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    setState(() {
      _currentIndex = value;
    });
    if (_currentIndex == 0 && currentRoute != 'chatPage') {
      Navigator.pushNamed(context, 'chatPage');
    } else if (_currentIndex == 1 && currentRoute != 'homePage') {
      Navigator.pushNamed(context, 'homePage');
    } else if (_currentIndex == 2 && currentRoute != 'myAccount') {
      Navigator.pushNamed(context, 'myAccount');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_currentIndex);
    return Scaffold(
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/illustrations/background.svg',
            fit: BoxFit.cover,
          ),
          AppBar(
            automaticallyImplyLeading: widget.shouldNavigateBack,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          widget.children,
        ],
      ),
      bottomNavigationBar: widget.isNavigationVisible
          ? CustomBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (value) => onTapCallBack(value),
            )
          : null,
    );
  }
}
