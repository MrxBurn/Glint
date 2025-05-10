import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glint/models/chat.dart';
import 'package:glint/models/encryption.dart';
import 'package:glint/models/matchUser.dart';
import 'package:glint/models/message.dart';
import 'package:glint/models/user.dart';
import 'package:glint/utils/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> sendMessage(
    WidgetRef ref,
    TextEditingController controller,
    Map<String, dynamic>? matchedUser,
    UserClass? currentUser,
    EncryptionRepo repo) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final derivedKey = await repo.deriveKey(
      //TODO: Store this also in database or somewhere else
      prefs.getString('privateKey_${currentUser?.id}') ?? '',
      matchedUser?['public_key']);

  final encryptedMessage =
      await repo.encryptMessage(controller.text, derivedKey);

  ref
      .read(messageNotifierProvider.notifier)
      .postMessage(matchedUser?['chat_id'], encryptedMessage);

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

  EncryptionRepo encryptionRepo = EncryptionRepo();

  @override
  Widget build(BuildContext context) {
    final matchedUser = ref.watch(fetchMatchedUsersProvider).value;
    final currentUser = ref.read(userNotifierProvider).value;

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
          onSubmitted: (_) async {
            await sendMessage(
                ref, inputController, matchedUser, currentUser, encryptionRepo);
            FocusScope.of(context).requestFocus(focusNode);
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () async {
                await sendMessage(ref, inputController, matchedUser,
                    currentUser, encryptionRepo);
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
