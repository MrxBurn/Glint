import 'package:flutter/material.dart';
import 'package:glint/utils/variables.dart';

class MultiSelectBox extends StatelessWidget {
  const MultiSelectBox(
      {super.key, required this.hobby, this.onTap, required this.isSelected});

  final String hobby;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? darkGreen : Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: ListTile(
          dense: true,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              hobby,
              style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.black),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
