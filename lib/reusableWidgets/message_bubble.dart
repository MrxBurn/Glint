import 'package:flutter/material.dart';
import 'package:glint/utils/variables.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
              color: lightPink,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
