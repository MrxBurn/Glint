import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/authentication/login/login.dart';
import 'package:glint/authentication/login/register.dart';
import 'package:glint/chat/chat_page.dart';
import 'package:glint/home_page/home_page.dart';
import 'package:glint/my_account/my_account.dart';
import 'package:glint/profile_image_upload/profile_image_upload.dart';
import 'package:glint/reusableWidgets/snack_bar.dart';
import 'package:glint/search_user/search_user_page.dart';
import 'package:glint/utils/variables.dart';
import 'package:glint/verification_page/verification_page.dart';
import 'package:glint/your_profile/your_profile_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  try {
    await Supabase.initialize(
        url: 'https://xpkwqnlgvbdkoizpkqbf.supabase.co',
        anonKey:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhwa3dxbmxndmJka29penBrcWJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc0MzE5NTUsImV4cCI6MjAzMzAwNzk1NX0.uHMSgmqBUCkRh-drLZapBwqnlOyNsRXqTiLFnysc7nI');
  } catch (e) {
    print(e);
  }
  runApp(const ProviderScope(child: MyApp()));
}

final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

Future<UserResponse> isUserLoggedIn() async {
  UserResponse user = await supabase.auth.getUser();
  return user;
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: SnackbarGlobal.key,
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
      home: FutureBuilder(
          future: isUserLoggedIn(),
          builder: (context, AsyncSnapshot<UserResponse> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData && snapshot.data?.user != null) {
              return const HomePage();
            }
            return const LoginPage();
          }),
      routes: {
        'loginPage': (context) => const LoginPage(),
        'registerPage': (context) => const RegisterPage(),
        'yourProfileInfo': (context) => const YourProfileInfo(),
        'profileImageUpload': (context) => const ProfileImageUpload(),
        'verificationPage': (context) => const VerificationPage(),
        'homePage': (context) => const HomePage(),
        'myAccount': (context) => const MyAccount(),
        'chatPage': (context) => const ChatPage(),
        'searchPage': (context) => const SearchUserPage(),
      },
    );
  }
}
