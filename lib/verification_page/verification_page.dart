import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/reusableWidgets/arrow_button.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/scaffold.dart';
import 'package:glint/utils/variables.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final double gap = 16;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        children: Column(
      children: [
        const Header(),
        Padding(
          padding: paddingLRT,
          child: FormContainer(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verification',
                      style: headerStyle,
                    ),
                    const Text(
                      "Let’s verify you are real!",
                      style: TextStyle(fontSize: 12),
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 75,
                        backgroundColor: darkGreen,
                        child: const Text(
                          'Scan face',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                    Gap(gap),
                    Center(
                      child: ArrowButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, 'homePage'),
                      ),
                    ),
                  ],
                ),
              )),
        )
      ],
    ));
  }
}
