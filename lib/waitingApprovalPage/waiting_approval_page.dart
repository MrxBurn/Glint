import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/utils/variables.dart';

class WaitingApprovalPage extends StatelessWidget {
  const WaitingApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: paddingLRT,
      child: FormContainer(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/illustrations/waiting_approval.svg',
                  width: 128,
                  height: 128,
                ),
              ),
              const Gap(50),
              const Text(
                'Sit tight while we approve your account!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          )),
    ));
  }
}
