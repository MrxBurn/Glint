import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/reusableWidgets/arrow_button.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/scaffold.dart';
import 'package:glint/reusableWidgets/text_box.dart';
import 'package:glint/utils/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

RegExp passwordRegEx = RegExp(
    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");

RegExp emailRegEx = RegExp(r"^[\w.-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$");

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

  final _formKey = GlobalKey<FormState>();

  void onRegister() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('email', _emailController.text);
    prefs.setString('firstName', _firstNameController.text);
    prefs.setString('lastName', _lastNameController.text);
    prefs.setString('password', _passwordController.text);

    setState(() {
      _firstNameController.text = '';
      _lastNameController.text = '';
      _emailController.text = '';
      _passwordController.text = '';
      _confirmPasswordController.text = '';
    });
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
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
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
                    CustomTextBox(
                      labelText: 'First name',
                      controller: _firstNameController,
                      validator: (value) {
                        if (_firstNameController.text.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    CustomTextBox(
                      labelText: 'Last name',
                      controller: _lastNameController,
                      validator: (value) {
                        if (_lastNameController.text.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
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
                          return 'Please enter a valid password';
                        }
                        if (!passwordRegEx.hasMatch(_passwordController.text)) {
                          return 'Password must be at least 8 characters long, include at least one uppercase letter, one lowercase letter, one number, and one special character (e.g., @, !, %, )';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    CustomTextBox(
                      obscureText: true,
                      labelText: 'Confirm Password',
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (_confirmPasswordController.text.isEmpty) {
                          return 'Please confirm the password';
                        }
                        if (_confirmPasswordController.text !=
                            _passwordController.text) {
                          return 'Passwords must match';
                        }
                        return null;
                      },
                    ),
                    const Gap(24),
                    Center(
                      child: ArrowButton(
                        onPressed: () => {
                          if (_formKey.currentState!.validate())
                            {
                              onRegister(),
                              Navigator.pushNamed(context, 'yourProfileInfo')
                            }
                        },
                      ),
                    ),
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
