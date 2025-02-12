import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint/my_account/my_account.dart';
import 'package:glint/reusableWidgets/bottom_navigation_bar.dart';
import 'package:glint/search_user_page/search_user_page.dart';

class HomePageRouter extends StatefulWidget {
  const HomePageRouter(
      {super.key,
      this.isNavigationVisible = false,
      this.shouldNavigateBack = false});

  final bool isNavigationVisible;
  final bool shouldNavigateBack;

  @override
  State<HomePageRouter> createState() => _HomePageRouterState();
}

class _HomePageRouterState extends State<HomePageRouter> {
  int _currentIndex = 1;
  Widget _customWidget = const MyAccount();
  Widget onTapCallBack(int value) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    setState(() {
      _currentIndex = value;
    });
    if (_currentIndex == 0 && currentRoute != 'chatPage') {
      return const SearchUserPage();
    } else if (_currentIndex == 1 && currentRoute != 'homeWidget') {
      return const MyAccount();
    }

    return const Text('');
  }

  @override
  Widget build(BuildContext context) {
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
          SizedBox(child: _customWidget)
        ],
      ),
      bottomNavigationBar: widget.isNavigationVisible
          ? CustomBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (value) => {
                setState(() {
                  _customWidget = onTapCallBack(value);
                }),
              },
            )
          : null,
    );
  }
}
