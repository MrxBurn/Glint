import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:glint/models/chat.dart';
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
  Widget build(BuildContext context) {
    var messages = ref.watch(messageNotifierProvider);
    var currentUser = ref.read(userNotifierProvider).value;
    final matchedUser = ref.read(fetchMatchedUsersProvider).value;
    final chatRoom = ref.watch(chatRoomNotifierProvider);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
      ref.read(isChattingNotifierProvider.notifier).setIsChatting(true);
    });

    return SafeArea(
      child: Column(
        children: [
          const Header(),
          Expanded(
            child: Padding(
              padding: paddingLRT,
              child: FormContainer(
                width: double.infinity,
                child: chatRoom.when(
                    data: (room) {
                      bool? isChatActive =
                          (!!room['user_1_active'] && !!room['user_2_active']);

                      return isChatActive
                          ? Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Gap(10),
                                Center(
                                  child: CircleAvatar(
                                    radius: 45,
                                    backgroundColor: darkGreen,
                                    foregroundImage: NetworkImage(
                                      ref
                                          .read(userNotifierProvider.notifier)
                                          .getProfilePhoto(
                                              userId: matchedUser?['id']),
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
                                      final returnedWidget = messages.isNotEmpty
                                          ? ListView.separated(
                                              controller: _scrollController,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              separatorBuilder:
                                                  (context, idx) =>
                                                      const Gap(10),
                                              itemCount: messages.length,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, idx) {
                                                return Align(
                                                  alignment:
                                                      messages[idx].sender ==
                                                              currentUser?.id
                                                          ? Alignment.topRight
                                                          : Alignment.topLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 16.0,
                                                      right: 16,
                                                    ),
                                                    child: MessageBubble(
                                                      messageObject:
                                                          messages[idx],
                                                      user: currentUser,
                                                    ),
                                                  ),
                                                );
                                              })
                                          : const Text(
                                              'There are currently no messages. Feel free to start chatting',
                                              textAlign: TextAlign.center,
                                            );

                                      return returnedWidget;
                                    },
                                    error:
                                        (Object error, StackTrace stackTrace) {
                                      return const Text('Something went wrong');
                                    },
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                isChatActive
                                    ? const ChatTextInput()
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
                            );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return const Text('Something went wrong');
                    },
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
