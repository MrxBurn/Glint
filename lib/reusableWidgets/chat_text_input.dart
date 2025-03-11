import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/models/chat.dart';
import 'package:glint/models/matchUser.dart';
import 'package:glint/models/message.dart';
import 'package:glint/utils/variables.dart';

void sendMessage(WidgetRef ref, TextEditingController controller,
    Map<String, dynamic>? matchedUser) {
  ref
      .read(messageNotifierProvider.notifier)
      .postMessage(matchedUser?['chat_id'], controller.text);

  ref.invalidate(chatRoomNotifierProvider);

  controller.clear();
}

class ChatTextInput extends ConsumerStatefulWidget {
  const ChatTextInput({
    super.key,
  });

  @override
  ConsumerState<ChatTextInput> createState() => _ChatTextInputState();
}

class _ChatTextInputState extends ConsumerState<ChatTextInput> {
  TextEditingController inputController = TextEditingController();

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final matchedUser = ref.watch(fetchMatchedUsersProvider).value;

    return Stack(
      children: [
        TextField(
          focusNode: focusNode,
          controller: inputController,
          style: const TextStyle(color: Colors.white),
          cursorColor: lightPink,
          decoration: InputDecoration(
            hintText: 'Press to type...',
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: darkGreen,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          onSubmitted: (_) {
            sendMessage(ref, inputController, matchedUser);
            FocusScope.of(context).requestFocus(focusNode);
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () async {
                sendMessage(ref, inputController, matchedUser);
                FocusScope.of(context).requestFocus(focusNode);
              },
              icon: Icon(
                size: 32,
                Icons.arrow_circle_right,
                color: lightBlue,
              )),
        )
      ],
    );
  }
}
