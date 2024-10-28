import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/classes/message.dart';
import 'package:glint/reusableWidgets/chat_text_input.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/message_bubble.dart';
import 'package:glint/utils/variables.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

// Define the messages properly
List<Message> messages = [
  {"sender": 'Florin', "message": 'Hi'},
  {"sender": 'Florin', "message": 'How are you?'},
  {"sender": 'Florin', "message": 'What’s up?'},
  {"sender": 'Alex', "message": 'Hello!'},
  {"sender": 'Alex', "message": 'I’m fine, thanks!'},
].map((json) => Message.fromJson(json)).toList();

class _ChatPageState extends State<ChatPage> {
//TODO: On menu press, ask if wants to leave chat
//TODO: IMPROVEMENT, maybe a button to close the chat

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Header(),
          Expanded(
            child: Padding(
              padding: paddingLRT,
              child: FormContainer(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Gap(10),
                    Center(
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: darkGreen,
                        child: const Text(
                          'Photo',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      'Name of user',
                      style: TextStyle(fontSize: 24),
                    ),
                    Expanded(
                      child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          separatorBuilder: (context, idx) => const Gap(10),
                          itemCount: messages.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, idx) {
                            return Align(
                              alignment: messages[idx].sender == 'Florin'
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16,
                                ),
                                child: MessageBubble(
                                  message: messages[idx].message,
                                ),
                              ),
                            );
                          }),
                    ),
                    const ChatTextInput()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
