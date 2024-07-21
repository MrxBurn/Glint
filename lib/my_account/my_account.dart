import 'package:flutter/material.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/scaffold.dart';
import 'package:glint/utils/variables.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        isNavigationVisible: true,
        children: Column(
          children: [
            const Header(),
            FormContainer(
                child: Column(
              children: [
                Text(
                  'My Account',
                  style: headerStyle,
                )
              ],
            ))
          ],
        ));
  }
}
