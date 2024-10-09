import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint/reusableWidgets/arrow_button.dart';
import 'package:glint/reusableWidgets/form_container.dart';
import 'package:glint/reusableWidgets/header.dart';
import 'package:glint/reusableWidgets/multi_select_box.dart';
import 'package:glint/reusableWidgets/scaffold.dart';
import 'package:glint/reusableWidgets/single_select_box.dart';
import 'package:glint/reusableWidgets/text_box.dart';
import 'package:glint/utils/lists.dart';
import 'package:glint/utils/variables.dart';
import 'package:intl/intl.dart';

class YourProfileInfo extends StatefulWidget {
  const YourProfileInfo({super.key});

  @override
  State<YourProfileInfo> createState() => _YourProfileInfoState();
}

class _YourProfileInfoState extends State<YourProfileInfo> {
  TextEditingController dobController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int? _genderSelectedIndex;
  int? _interestSelectedIndex;
  int? _lookingForIndex;

  final List<String> _selectedHobbies = [];

  double width = 200;
  double gap = 10;

  void onTileSelected(int index, String? type) => {
        setState(() {
          if (type == 'gender') {
            if (_genderSelectedIndex == index) {
              _genderSelectedIndex = null;
            } else {
              _genderSelectedIndex = index;
            }
          } else if (type == 'interestedIn') {
            if (_interestSelectedIndex == index) {
              _interestSelectedIndex = null;
            } else {
              _interestSelectedIndex = index;
            }
          } else {
            if (_lookingForIndex == index) {
              _lookingForIndex = null;
            } else {
              _lookingForIndex = index;
            }
          }
        })
      };

  void onMultiTileSelect(String value) {
    setState(() {
      if (_selectedHobbies.contains(value)) {
        _selectedHobbies.remove(value);
      } else {
        _selectedHobbies.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate(BuildContext context) async {
      DateTime selectedDate = DateTime.now();
      DateTime? pickedDate = await showDatePicker(
          context: context,

          //TODO: Default date to today's date but to go back in time
          initialDate: DateTime(1950),
          firstDate: DateTime(1950),
          lastDate: DateTime(2101));
      setState(() {
        if (pickedDate != null) {
          dobController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
        } else {
          dobController.text = '';
        }
      });
    }

    return CustomScaffold(
        shouldNavigateBack: true,
        children: Column(
          children: [
            const Header(),
            Padding(
              padding: paddingLRT,
              child: FormContainer(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
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
                        Row(
                          children: [
                            const Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Date of birth:'),
                                    Gap(18),
                                    Text('Height:'),
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomTextBox(
                                      readOnly: true,
                                      width: width,
                                      controller: dobController,
                                      onTap: () => selectDate(context),
                                      validator: (text) {
                                        if (dobController.text.isEmpty) {
                                          return 'Please enter your DOB';
                                        }
                                        if (DateTime.now().year -
                                                DateFormat('dd-MM-yyyy')
                                                    .parse(dobController.text)
                                                    .year <
                                            18) {
                                          return 'You must be over 18 years old';
                                        }
                                        return null;
                                      },
                                    ),
                                    Gap(gap),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      spacing: 10,
                                      children: [
                                        CustomTextBox(
                                            validator: (text) {
                                              if (heightController
                                                  .text.isEmpty) {
                                                return 'Please enter your height';
                                              }
                                              return null;
                                            },
                                            width: width,
                                            controller: heightController),
                                        const Text('cm')
                                      ],
                                    )
                                  ],
                                ))
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
                                    onTap: () => onTileSelected(idx, 'gender'),
                                    isSelected: _genderSelectedIndex == idx,
                                  );
                                })),
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
                                onTap: () =>
                                    onTileSelected(idx, 'interestedIn'),
                                isSelected: _interestSelectedIndex == idx,
                              );
                            },
                          ),
                        ),
                        Gap(gap),
                        Row(
                          children: [
                            const Text('Hobbies:'),
                            const Gap(8),
                            _selectedHobbies.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedHobbies.clear();
                                      });
                                    },
                                    child: Text(
                                      'Clear all',
                                      style: TextStyle(
                                          color: darkGreen,
                                          fontSize: 12,
                                          decoration: TextDecoration.underline,
                                          decorationColor: darkGreen),
                                    ))
                                : const SizedBox()
                          ],
                        ),
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
                                onTap: () =>
                                    onMultiTileSelect(hobbiesList[idx]),
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
                            itemCount: lookingForList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, idx) {
                              return MultiSelectBox(
                                hobby: lookingForList[idx],
                                onTap: () => onTileSelected(idx, ''),
                                isSelected: _lookingForIndex == idx,
                              );
                            },
                          ),
                        ),
                        Gap(gap),
                        Center(child: ArrowButton(onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, 'yourInterests');
                          }
                        }))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
