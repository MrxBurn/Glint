import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/authentication/login/login.dart';
import 'package:glint/authentication/login/register.dart';
import 'package:glint/chat/chat_page.dart';
import 'package:glint/environments.dart';
import 'package:glint/models/persistUserState.dart';
import 'package:glint/my_account/my_account.dart';
import 'package:glint/profile_image_upload/profile_image_upload.dart';
import 'package:glint/home_page/home_page_router.dart';
import 'package:glint/reusableWidgets/snack_bar.dart';
import 'package:glint/search_user_page/search_user_page.dart';
import 'package:glint/utils/variables.dart';
import 'package:glint/verification_page/verification_page.dart';
import 'package:glint/waitingApprovalPage/waiting_approval_page.dart';
import 'package:glint/your_profile/your_profile_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  try {
    await Supabase.initialize(
        url: SupabaseEnv.supabaseUrl, anonKey: SupabaseEnv.supabaseAnnonKey);
  } catch (e) {
    print(e);
  }
  runApp(const ProviderScope(child: MyApp()));
}

final supabase = Supabase.instance.client;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userIsLoggedIn = ref.watch(persistUserProvider);

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
      home: userIsLoggedIn.when(
          data: (persistedUser) {
            if (persistedUser.session?.user != null) {
              return const HomePageRouter();
            }
            return const LoginPage();
          },
          error: (error, stackTrace) => const Text('Something went wrong'),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
      routes: {
        'loginPage': (context) => const LoginPage(),
        'registerPage': (context) => const RegisterPage(),
        'yourProfileInfo': (context) => const YourProfileInfo(),
        'profileImageUpload': (context) => const ProfileImageUpload(),
        'verificationPage': (context) => const VerificationPage(),
        'homePage': (context) => const HomePageRouter(),
        'myAccount': (context) => const MyAccount(),
        'chatPage': (context) => const ChatPage(),
        'searchUser': (context) => const SearchUserPage()
      },
    );
  }
}
