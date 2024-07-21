import 'package:flutter/material.dart';
import 'package:glint/reusableWidgets/scaffold.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
        isNavigationVisible: true,
        children: Column(
          children: [],
        ));
  }
}
