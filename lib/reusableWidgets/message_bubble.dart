import 'package:flutter/material.dart';
import 'package:glint/models/message.dart';
import 'package:glint/models/user.dart';
import 'package:glint/utils/variables.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.messageObject, this.user});

  final Message messageObject;
  final UserClass? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
              color: messageObject.sender == user?.id ? lightPink : darkGreen,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              messageObject.message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
