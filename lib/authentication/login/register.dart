import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/reusableWidgets/arrow_button.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/scaffold.dart';
import 'package:glint/reusableWidgets/text_field.dart';
import 'package:glint/utils/variables.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: Column(
        children: [
          const Header(),
          Padding(
            padding: paddingLRT,
            child: FormContainer(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: headerStyle,
                  ),
                  Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 12),
                        ),
                        InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, 'loginPage'),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: lightPink,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  decorationColor: lightPink),
                            ))
                      ]),
                  const Gap(24),
                  CustomTextField(
                    labelText: 'First name',
                    controller: _firstNameController,
                  ),
                  const Gap(16),
                  CustomTextField(
                    labelText: 'Last name',
                    controller: _lastNameController,
                  ),
                  const Gap(16),
                  CustomTextField(
                    labelText: 'Email',
                    controller: _emailController,
                  ),
                  const Gap(16),
                  CustomTextField(
                    labelText: 'Password',
                    controller: _passwordController,
                  ),
                  const Gap(16),
                  CustomTextField(
                    labelText: 'Confirm Password',
                    controller: _confirmPasswordController,
                  ),
                  const Gap(24),
                  const Center(child: ArrowButton())
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
