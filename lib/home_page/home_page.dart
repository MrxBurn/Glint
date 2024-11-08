import 'package:flutter/material.dart';
import 'package:glint/reusableWidgets/home_page_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageRouter(
      isNavigationVisible: true,
    );
  }
}
