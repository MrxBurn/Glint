import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:glint/models/isChatting.dart';
import 'package:glint/models/matchUser.dart';
import 'package:glint/models/message.dart';
import 'package:glint/models/user.dart';
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
  //TODO: If chat is closed, add a button to start process again

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future(
      () {
        ref.read(isChattingNotifierProvider.notifier).setIsChatting(true);
      },
    );
  }

  Map<String, dynamic> chatRoom = {};

  void setChatRoom(Map<String, dynamic> pChatRoom) {
    setState(() {
      chatRoom = pChatRoom;
    });
  }

  @override
  Widget build(BuildContext context) {
    var messages = ref.watch(messageNotifierProvider);
    var currentUser = ref.read(userNotifierProvider).value;
    final matchedUser = ref.read(fetchMatchedUsersProvider).value;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });

    bool isChatActive = chatRoom.isEmpty || chatRoom['is_chat_active'] == true;

    return SafeArea(
      child: Column(
        children: [
          const Header(),
          Expanded(
            child: Padding(
              padding: paddingLRT,
              child: FormContainer(
                width: double.infinity,
                child: isChatActive
                    ? Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Gap(10),
                          Center(
                            child: CircleAvatar(
                              radius: 45,
                              backgroundColor: darkGreen,
                              child: const Text(
                                'Photo',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                          const Gap(10),
                          Text(
                            matchedUser?['first_name'],
                            style: const TextStyle(fontSize: 24),
                          ),
                          const Gap(24),
                          Expanded(
                              child: messages.when(
                                  data: (messages) {
                                    return ListView.separated(
                                        controller: _scrollController,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        separatorBuilder: (context, idx) =>
                                            const Gap(10),
                                        itemCount: messages.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, idx) {
                                          return Align(
                                            alignment: messages[idx].sender ==
                                                    currentUser?.id
                                                ? Alignment.topRight
                                                : Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16.0,
                                                right: 16,
                                              ),
                                              child: MessageBubble(
                                                messageObject: messages[idx],
                                                user: currentUser,
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
                          const Gap(10),
                          isChatActive
                              ? ChatTextInput(
                                  onPressed: setChatRoom,
                                )
                              : const SizedBox()
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              constraints: const BoxConstraints(
                                  maxHeight: 300, maxWidth: 300),
                              child: Image.asset(
                                'illustrations/disconnect_img.jpg',
                              ),
                            ),
                          ),
                          const Text(
                            'The chat has been closed by the other person :(',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
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
