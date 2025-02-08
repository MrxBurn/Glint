import 'package:flutter/material.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/utils/variables.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

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
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Searching for your perfect match',
                          style: headerStyle,
                        ),
                        const Text(
                          "Relax while we do the work",
                          style: TextStyle(fontSize: 12),
                        ),
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              'assets/icons/loading_heart.gif',
                              width: 256,
                              height: 256,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
