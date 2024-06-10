import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glint/authentication/login/login.dart';
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
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            SvgPicture.asset(
              'assets/illustrations/background.svg',
              fit: BoxFit.cover,
            ),
            const LoginPage()
          ],
        ),
      ),
    );
  }
}
