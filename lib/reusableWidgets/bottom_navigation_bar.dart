import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar(
      {super.key, required this.onTap, this.currentIndex = 1});

  final void Function(int value) onTap;
  final int currentIndex;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 100.0,
          right: 100,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            child: BottomNavigationBar(
              unselectedFontSize: 13,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.black,
              elevation: 0,
              backgroundColor: Colors.white,
              currentIndex: widget.currentIndex,
              onTap: widget.onTap,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/chat.png',
                    width: 18,
                    height: 18,
                  ),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/user.png',
                      width: 18,
                      height: 18,
                    ),
                    label: 'Account')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
