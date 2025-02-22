import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:glint/models/message.dart';
import 'package:glint/reusableWidgets/chat_text_input.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/message_bubble.dart';
import 'package:glint/utils/variables.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
//TODO: On menu press, ask if wants to leave chat
//TODO: IMPROVEMENT, maybe a button to close the chat

  @override
  Widget build(BuildContext context) {
    var messages = ref.watch(messageNotifierProvider);

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
                        child: messages.when(
                            data: (messages) {
                              return ListView.separated(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  separatorBuilder: (context, idx) =>
                                      const Gap(10),
                                  itemCount: messages.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, idx) {
                                    return Align(
                                      alignment:
                                          messages[idx].sender == 'Florin'
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
                                  });
                            },
                            error: (Object error, StackTrace stackTrace) {
                              return const Text('Something went wrong');
                            },
                            loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ))),
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
