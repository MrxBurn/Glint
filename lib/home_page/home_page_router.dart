import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint/models/homeRouter.dart';
import 'package:glint/my_account/my_account.dart';
import 'package:glint/reusableWidgets/bottom_navigation_bar.dart';
import 'package:glint/search_user_page/search_user_page.dart';

class HomePageRouter extends ConsumerStatefulWidget {
  const HomePageRouter(
      {super.key,
      this.isNavigationVisible = false,
      this.shouldNavigateBack = false});

  final bool isNavigationVisible;
  final bool shouldNavigateBack;

  @override
  ConsumerState<HomePageRouter> createState() => _HomePageRouterState();
}

class _HomePageRouterState extends ConsumerState<HomePageRouter> {
  // int _currentIndex = 1;
  Widget _customWidget = const MyAccount();
  Widget onTapCallBack(int currentIndex) {
    if (currentIndex == 0) {
      return const SearchUserPage();
    } else if (currentIndex == 1) {
      return const MyAccount();
    }

    return const Text('');
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(homeRouterNotifierProvider);

    print(currentIndex);

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
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) => {
            ref.read(homeRouterNotifierProvider.notifier).updateIndex(value),
            //TODO: When navigating back from chat to account, display modal making use of the homeRouterNotifierProvider in the search_page.dart
            if (currentIndex == 0 && value == 1)
              {print('navigating from chat => account')},
            _customWidget = onTapCallBack(value)
          },
        ));
  }
}
