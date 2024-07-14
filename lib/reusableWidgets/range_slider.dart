import 'package:flutter/material.dart';
import 'package:glint/utils/variables.dart';

class CustomRangeSlider extends StatefulWidget {
  const CustomRangeSlider(
      {super.key, required this.rangeValues, this.onChanged});

  final RangeValues rangeValues;
  final Function(RangeValues)? onChanged;

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      activeColor: lightPink,
      values: widget.rangeValues,
      onChanged: widget.onChanged,
      min: 18,
      max: 60,
      divisions: 60,
      labels: RangeLabels(
        widget.rangeValues.start.round().toString(),
        widget.rangeValues.end.round().toString(),
      ),
    );
  }
}
