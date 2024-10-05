import 'package:flutter/material.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/home_page_router.dart';
import 'package:glint/utils/variables.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageRouter(
      isNavigationVisible: true,
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const String user = 'Alex';
    return Column(
      children: [
        const Header(),
        FormContainer(
          child: Column(
            children: [
              Text(
                'Hello $user',
                style: headerStyle,
              )
            ],
          ),
        ),
      ],
    );
  }
}
