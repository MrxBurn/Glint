import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/scaffold.dart';
import 'package:glint/utils/variables.dart';

class YourProfileInfo extends StatefulWidget {
  const YourProfileInfo({super.key});

  @override
  State<YourProfileInfo> createState() => _YourProfileInfoState();
}

class _YourProfileInfoState extends State<YourProfileInfo> {
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
                    'Your profile',
                    style: headerStyle,
                  ),
                  const Text(
                    "Tell us a bit about yourself",
                    style: TextStyle(fontSize: 12),
                  ),
                  const Gap(16),
                  GridView.count(
                    childAspectRatio: 5.0,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: const [
                      Text('Date of birth'),
                      Text('test'),
                      Text('Height'),
                      Text('value'),
                      Text('Gender'),
                      Text('value'),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
