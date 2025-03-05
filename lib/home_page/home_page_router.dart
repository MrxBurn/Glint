import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint/models/homeRouter.dart';
import 'package:glint/models/isChatting.dart';
import 'package:glint/models/user.dart';
import 'package:glint/my_account/my_account.dart';
import 'package:glint/reusableWidgets/bottom_navigation_bar.dart';
import 'package:glint/reusableWidgets/disconnect_chat_modal.dart';
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
  Widget _customWidget = const MyAccount();
  Widget onTapCallBack(int currentIndex, WidgetRef ref) {
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
    final isChatting = ref.watch(isChattingNotifierProvider);

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
            if (currentIndex == 0 && value == 1)
              {
                openBox(context, ref),
                _customWidget = onTapCallBack(value, ref),
              },
            if (!isChatting)
              {
                ref
                    .read(homeRouterNotifierProvider.notifier)
                    .updateIndex(value),
                _customWidget = onTapCallBack(value, ref),
              }
          },
        ));
  }
}
