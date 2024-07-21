import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint/chat/chat_page.dart';
import 'package:glint/home_page/home_page.dart';
import 'package:glint/my_account/my_account.dart';
import 'package:glint/reusableWidgets/bottom_navigation_bar.dart';

class ScaffoldWithMenu extends StatefulWidget {
  const ScaffoldWithMenu({
    super.key,
    required this.children,
  });

  final Widget children;

  @override
  State<ScaffoldWithMenu> createState() => _ScaffoldWithMenuState();
}

class _ScaffoldWithMenuState extends State<ScaffoldWithMenu> {
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

  static const List<Widget> pages = [ChatPage(), HomePage(), MyAccount()];

  @override
  Widget build(BuildContext context) {
    //TODO: Fix too many renders
    print(_currentIndex);
    return Scaffold(
        extendBody: true,
        body: pages.elementAt(_currentIndex),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) => onTapCallBack(value),
        ));
  }
}


// Stack(
//           fit: StackFit.expand,
//           children: [
//             SvgPicture.asset(
//               'assets/illustrations/background.svg',
//               fit: BoxFit.cover,
//             ),
//             AppBar(
//               automaticallyImplyLeading: false,
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//             ),
//             pages.elementAt(_currentIndex),
//           ],
//         ),
