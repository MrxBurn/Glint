import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:glint/main.dart';
import 'package:glint/models/registeredUser.dart';
import 'package:glint/models/user.dart';
import 'package:glint/reusableWidgets/custom_elevated_button.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/utils/variables.dart';

class WaitingApprovalPage extends ConsumerWidget {
  const WaitingApprovalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider).value;
    return SafeArea(
        child: Padding(
      padding: paddingLRT,
      child: FormContainer(
          width: double.infinity,
          child: user == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
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
                    Text(
                      user.isAuthFinished != false
                          ? 'We are currently in the process of approving your account. \nPlease try again later!'
                          : 'You have not finished your authentication process,\nplease upload your profile photo.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        user.isAuthFinished == false
                            ? CustomElevatedButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, 'profileImageUpload'),
                                isLoading: false,
                                child: const Text('Upload photos'),
                              )
                            : const SizedBox(),
                        const Gap(32),
                        CustomElevatedButton(
                          onPressed: () async {
                            ref.invalidate(userNotifierProvider);
                            ref.invalidate(registeredUserNotifierProvider);
                          },
                          isLoading: false,
                          child: const Text('Refresh'),
                        ),
                      ],
                    ),
                  ],
                )),
    ));
  }
}
