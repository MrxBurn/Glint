import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/editPreferences/edit_preferences.dart';
import 'package:glint/main.dart';
import 'package:glint/reusableWidgets/custom_elevated_button.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/multi_select_box.dart';
import 'package:glint/reusableWidgets/single_select_box.dart';
import 'package:glint/reusableWidgets/text_box.dart';
import 'package:glint/utils/lists.dart';
import 'package:glint/utils/variables.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:glint/classes/user.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

double gap = 10;

class _MyAccountState extends State<MyAccount> {
  TextEditingController dobController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  int? _genderSelectedIndex;
  int? _interestSelectedIndex;
  int? _lookingForIndex;

  List<String> _selectedHobbies = [];

  double width = 200;
  double gap = 10;

  Future<List<UserClass>> getUser() async {
    UserResponse user = await supabase.auth.getUser();

    if (user.user?.id != null) {
      List<Map<String, dynamic>> response =
          await supabase.from('users').select().eq('id', user.user!.id);

      return response.map((data) => UserClass.fromMap(data)).toList();
    }
    return [];
  }
  
  Fa ca controlerele sa fie setate cu fetchUser

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
                    padding: const EdgeInsets.all(16.0),
                    child: FutureBuilder<List<UserClass>>(
                      future: getUser(),
                      builder:
                          (context, AsyncSnapshot<List<UserClass>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          UserClass data = snapshot.data![0];

                          _genderSelectedIndex = genders.indexOf(data.gender);
                          _selectedHobbies += List<String>.from(data.hobbies);
                          _interestSelectedIndex =
                              genders.indexOf(data.interestIn);
                          _lookingForIndex =
                              lookingForListEnums.indexOf(data.lookingFor);

                          dobController.text = DateFormat('dd-MM-yyyy')
                              .format(DateTime.parse(data.dob))
                              .toString();
                          heightController.text = data.height.toString();

                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: CustomElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditPreferences(user: data),
                                          ),
                                        );
                                      },
                                      isLoading: false,
                                      child: const Text('Edit preferences'),
                                    )),
                                Text(
                                  'My Account',
                                  style: headerStyle,
                                ),
                                const Gap(24),
                                CustomTextBox(
                                  labelText: 'Date of birth',
                                  readOnly: true,
                                  width: width,
                                  controller: dobController,
                                  onTap: null,
                                ),
                                const Gap(24),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 10,
                                  children: [
                                    CustomTextBox(
                                      readOnly: true,
                                      labelText: 'Height',
                                      width: width,
                                      controller: heightController,
                                    ),
                                    const Text('cm'),
                                  ],
                                ),
                                Gap(gap),
                                const Text('Gender:'),
                                Gap(gap),
                                SizedBox(
                                    width: double.infinity,
                                    height: 32,
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            const Gap(6),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: genders.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, idx) {
                                          return SingleSelectBox(
                                            color: colourList[idx],
                                            imageString: images[idx],
                                            gender: genders[idx],
                                            onTap: null,
                                            isSelected:
                                                _genderSelectedIndex == idx,
                                          );
                                        })),
                                Gap(gap),
                                const Text('Hobbies:'),
                                Gap(gap),
                                SizedBox(
                                  width: double.infinity,
                                  height: 32,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const Gap(6),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: hobbiesList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, idx) {
                                      return MultiSelectBox(
                                          hobby: hobbiesList[idx],
                                          isSelected: _selectedHobbies
                                              .contains(hobbiesList[idx]),
                                          onTap: null);
                                    },
                                  ),
                                ),
                                Gap(gap),
                                const Text('Interested in:'),
                                Gap(gap),
                                SizedBox(
                                  width: double.infinity,
                                  height: 32,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const Gap(6),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: genders.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, idx) {
                                      return SingleSelectBox(
                                        color: colourList[idx],
                                        imageString: images[idx],
                                        gender: genders[idx],
                                        onTap: null,
                                        isSelected:
                                            _interestSelectedIndex == idx,
                                      );
                                    },
                                  ),
                                ),
                                Gap(gap),
                                const Text('Looking for:'),
                                Gap(gap),
                                SizedBox(
                                  width: double.infinity,
                                  height: 32,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const Gap(6),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: lookingForText.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, idx) {
                                      return MultiSelectBox(
                                        hobby: lookingForText[idx],
                                        onTap: null,
                                        isSelected: _lookingForIndex == idx,
                                      );
                                    },
                                  ),
                                ),
                                Gap(gap),
                                Row(
                                  children: [
                                    const Text('Age search: '),
                                    Text(
                                      "${data.minAge} - ${data.maxAge}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Gap(gap),
                                Center(
                                    child: CustomElevatedButton(
                                  onPressed: () => supabase.auth.signOut(),
                                  isLoading: false,
                                  child: const Text('Logout'),
                                )),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
