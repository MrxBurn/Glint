import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/classes/user.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/utils/variables.dart';
import 'package:get/get.dart';

class SearchUserPage extends StatelessWidget {
  const SearchUserPage({super.key});

  // final UserClassController userController =
  //     Get.put<UserClassController>(UserClassController());

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          Header(),
          // Expanded(
          //   child: Padding(
          //     padding: paddingLRT,
          //     child: FormContainer(
          //         width: double.infinity,
          //         child: Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'Searching for your perfect match',
          //                 style: headerStyle,
          //               ),
          //               const Text(
          //                 "Relax while we do the work",
          //                 style: TextStyle(fontSize: 12),
          //               ),
          //               Text(userController.defaultUser.value.hobbies
          //                   .toString()),
          //               const Gap(16),
          //               Expanded(
          //                 child: Center(
          //                   child: Image.asset(
          //                     'assets/icons/loading_heart.gif',
          //                     width: 80,
          //                     height: 80,
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //         )),
          //   ),
          // ),
        ],
      ),
    );
  }
}
