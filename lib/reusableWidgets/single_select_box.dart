import 'package:flutter/material.dart';
import 'package:glint/utils/variables.dart';

class SingleSelectBox extends StatelessWidget {
  const SingleSelectBox(
      {super.key,
      required this.color,
      required this.imageString,
      required this.gender,
      this.onTap,
      required this.isSelected});

  final Color color;
  final String imageString;
  final String gender;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? darkGreen : color,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: ListTile(
          dense: true,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          horizontalTitleGap: 5,
          leading: isSelected
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                )
              : Image.asset(
                  imageString,
                  width: 16,
                  height: 16,
                ),
          title: Text(
            gender,
            style: TextStyle(
                fontSize: 12, color: isSelected ? Colors.white : Colors.black),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
