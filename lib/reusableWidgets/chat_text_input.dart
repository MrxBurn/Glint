import 'package:flutter/material.dart';
import 'package:glint/utils/variables.dart';

class ChatTextInput extends StatefulWidget {
  const ChatTextInput({super.key});

  @override
  State<ChatTextInput> createState() => _ChatTextInputState();
}

class _ChatTextInputState extends State<ChatTextInput> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          style: const TextStyle(color: Colors.white),
          cursorColor: lightPink,
          decoration: InputDecoration(
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
        ),
        //TODO: Implement on submit
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () {},
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
