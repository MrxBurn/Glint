import 'package:flutter/material.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/utils/variables.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header(),
        Padding(
          padding: paddingLRT,
          child: FormContainer(
              height: 300,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: headerStyle,
                    ),
                    Wrap(
                        spacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 12),
                          ),
                          InkWell(
                              onTap: () {},
                              child: Text(
                                'Register',
                                style:
                                    TextStyle(color: lightPink, fontSize: 12),
                              ))
                        ])
                  ],
                ),
              )),
        )
      ],
    );
  }
}
