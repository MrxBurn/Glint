import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/classes/user.dart';
import 'package:glint/reusableWidgets/error_field.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/multi_select_box.dart';
import 'package:glint/reusableWidgets/scaffold.dart';
import 'package:glint/reusableWidgets/single_select_box.dart';
import 'package:glint/reusableWidgets/text_box.dart';
import 'package:glint/utils/lists.dart';
import 'package:glint/utils/variables.dart';
import 'package:intl/intl.dart';

class EditPreferences extends StatefulWidget {
  const EditPreferences({super.key, required this.user});

  final UserClass user;

  @override
  State<EditPreferences> createState() => _EditPreferencesState();
}

class _EditPreferencesState extends State<EditPreferences> {
  TextEditingController dobController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  RangeValues _ageRangeValues = const RangeValues(0, 0);

  double width = 200;
  double gap = 10;

  int? _genderSelectedIndex;
  int? _interestSelectedIndex;
  int? _lookingForIndex;

  final String _genderValue = '';
  final String _interestValue = '';
  final String _lookingForValue = '';

  final bool _formSubmitted = false;

  List<String> _selectedHobbies = [];

  @override
  void initState() {
    super.initState();
    dobController.text = widget.user.dob;
    heightController.text = widget.user.height.toString();
    _ageRangeValues = RangeValues(
        widget.user.minAge.toDouble(), widget.user.maxAge.toDouble());
  }

//TODO:Finish edit
  @override
  Widget build(BuildContext context) {
    _genderSelectedIndex = genders.indexOf(widget.user.gender);
    _selectedHobbies += List<String>.from(widget.user.hobbies);
    _interestSelectedIndex = genders.indexOf(widget.user.interestIn);
    _lookingForIndex = lookingForListEnums.indexOf(widget.user.lookingFor);

    dobController.text = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(widget.user.dob))
        .toString();
    heightController.text = widget.user.height.toString();

    return CustomScaffold(
      children: Column(
        children: [
          const Header(),
          Padding(
            padding: paddingLRT,
            child: FormContainer(
                child: Column(children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  isSelected: _genderSelectedIndex == idx,
                                );
                              })),
                      Gap(gap),
                      _formSubmitted && _genderValue.isEmpty
                          ? const ErrorField(error: 'Please select a gender')
                          : const SizedBox(),
                      Gap(gap),
                      const Text('Hobbies:'),
                      Gap(gap),
                      SizedBox(
                        width: double.infinity,
                        height: 32,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Gap(6),
                          scrollDirection: Axis.horizontal,
                          itemCount: hobbiesList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, idx) {
                            return MultiSelectBox(
                                hobby: hobbiesList[idx],
                                isSelected:
                                    _selectedHobbies.contains(hobbiesList[idx]),
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
                          separatorBuilder: (context, index) => const Gap(6),
                          scrollDirection: Axis.horizontal,
                          itemCount: genders.length,
                          shrinkWrap: true,
                          itemBuilder: (context, idx) {
                            return SingleSelectBox(
                              color: colourList[idx],
                              imageString: images[idx],
                              gender: genders[idx],
                              onTap: null,
                              isSelected: _interestSelectedIndex == idx,
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
                          separatorBuilder: (context, index) => const Gap(6),
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
                            "${widget.user.minAge} - ${widget.user.maxAge}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Gap(gap),
                    ],
                  ),
                ),
              ),
            ])),
          ),
        ],
      ),
    );
  }
}
