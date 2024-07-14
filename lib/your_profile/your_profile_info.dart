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

class YourProfileInfo extends StatefulWidget {
  const YourProfileInfo({super.key});

  @override
  State<YourProfileInfo> createState() => _YourProfileInfoState();
}

class _YourProfileInfoState extends State<YourProfileInfo> {
  TextEditingController dobController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  int? _genderSelectedIndex;
  int? _interestSelectedIndex;
  int? _lookingForIndex;

  final List<String> _selectedHobbies = [];

  double width = 150;
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
          initialDate: selectedDate,
          firstDate: selectedDate,
          lastDate: DateTime(2101));
      setState(() {
        if (pickedDate != null) {
          dobController.text = pickedDate.toString();
        } else {
          dobController.text = selectedDate.toString();
        }
      });
    }

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
                                  onTap: () => selectDate(context)),
                              Gap(gap),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 10,
                                children: [
                                  CustomTextBox(
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
                          separatorBuilder: (context, index) => const Gap(6),
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
                          onTap: () => onTileSelected(idx, 'interestedIn'),
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
                          onTap: () => onMultiTileSelect(hobbiesList[idx]),
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
                  Center(
                      child: ArrowButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, 'yourInterests'),
                  ))
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
