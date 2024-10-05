import 'package:flutter/material.dart';
import 'package:glint/authentication/login/login.dart';
import 'package:glint/authentication/login/register.dart';
import 'package:glint/chat/chat_page.dart';
import 'package:glint/home_page/home_page.dart';
import 'package:glint/my_account/my_account.dart';
import 'package:glint/profile_image_upload/profile_image_upload.dart';
import 'package:glint/utils/variables.dart';
import 'package:glint/verification_page/verification_page.dart';
import 'package:glint/your_interests/your_interests_page.dart';
import 'package:glint/your_profile/your_profile_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  try {
    await Supabase.initialize(
      url: 'https://xpkwqnlgvbdkoizpkqbf.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInhwa3dxbmxndmJka29penBrcWJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc0MzE5NTUsImV4cCI6MjAzMzAwNzk1NX0.uHMSgmqBUCkRh-drLZapBwqnlOyNsRXqTiLFnysc7nI',
    );
  } catch (e) {
    print(e);
  }
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(style: BorderStyle.solid, color: Colors.black),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(cursorColor: darkGreen),
      ),
      home: const LoginPage(),
      routes: {
        'loginPage': (context) => const LoginPage(),
        'registerPage': (context) => const RegisterPage(),
        'yourProfileInfo': (context) => const YourProfileInfo(),
        'yourInterests': (context) => const YourInterestsPage(),
        'profileImageUpload': (context) => const ProfileImageUpload(),
        'verificationPage': (context) => const VerificationPage(),
        'homePage': (context) => const HomePage(),
        'homeWidget': (context) => const HomeWidget(),
        'myAccount': (context) => const MyAccount(),
        'chatPage': (context) => const ChatPage()
      },
    );
  }
}
