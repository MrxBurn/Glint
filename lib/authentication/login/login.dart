import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/authentication/login/register.dart';
import 'package:glint/main.dart';
import 'package:glint/reusableWidgets/button.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/scaffold.dart';
import 'package:glint/reusableWidgets/snack_bar.dart';
import 'package:glint/reusableWidgets/text_box.dart';
import 'package:glint/utils/variables.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> login(BuildContext context) async {
    try {
      await supabase.auth.signInWithPassword(
          email: _emailController.text, password: _passwordController.text);
    } on AuthApiException catch (e) {
      SnackbarGlobal.show(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: Column(
        children: [
          const Header(),
          Padding(
            padding: paddingLRT,
            child: FormContainer(
                height: 300,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
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
                                  onTap: () => Navigator.pushNamed(
                                      context, 'registerPage'),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                        color: lightPink,
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                        decorationColor: lightPink),
                                  ))
                            ]),
                        const Gap(24),
                        CustomTextBox(
                          labelText: 'Email',
                          controller: _emailController,
                          validator: (value) {
                            if (_emailController.text.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!emailRegEx.hasMatch(_emailController.text)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const Gap(16),
                        CustomTextBox(
                          obscureText: true,
                          labelText: 'Password',
                          controller: _passwordController,
                          validator: (value) {
                            if (_passwordController.text.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const Gap(24),
                        Center(
                            child: CustomButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await login(context);
                              // Navigator.pushNamed(context, 'homePage');
                            }
                          },
                          text: 'Login',
                        )),
                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
