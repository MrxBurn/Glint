import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint/models/encryption.dart';
import 'package:glint/models/encryption_service.dart';
import 'package:glint/models/homeRouter.dart';
import 'package:glint/models/user.dart';
import 'package:glint/my_account/my_account.dart';
import 'package:glint/reusableWidgets/bottom_navigation_bar.dart';
import 'package:glint/reusableWidgets/disconnect_chat_modal.dart';
import 'package:glint/search_user_page/search_user_page.dart';
import 'package:glint/waitingApprovalPage/waiting_approval_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<Widget> widgets = [
    const SearchUserPage(),
    const MyAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userNotifierProvider).value;

    final currentIndex = ref.watch(homeRouterNotifierProvider);

    final isValid = ref.watch(encryptionServiceProvider);

    print(isValid.value);

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
            userAsync != null && userAsync.isApproved
                ? widgets[currentIndex]
                : const WaitingApprovalPage()
          ],
        ),
        bottomNavigationBar: userAsync != null && userAsync.isApproved
            ? CustomBottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (value) {
                  ref
                      .read(homeRouterNotifierProvider.notifier)
                      .updateIndex(value);
                },
              )
            : null);
  }
}
