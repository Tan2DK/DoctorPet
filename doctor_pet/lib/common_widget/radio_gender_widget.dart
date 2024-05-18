import 'package:flutter/material.dart';

import '../utils/app_enum.dart';
import 'custom_text/custom_text_widget.dart';

class RadioGenderWidget extends StatefulWidget {
  const RadioGenderWidget({
    Key? key,
    this.onChangedGender,
    this.gender,
  }) : super(key: key);
  final Function(Gender?)? onChangedGender;
  final Gender? gender;

  @override
  State<RadioGenderWidget> createState() => _RadioGenderWidgetState();
}

class _RadioGenderWidgetState extends State<RadioGenderWidget> {
  Gender selectedGender = Gender.male;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.gender??Gender.male;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomTextWidget(
          text: 'Gender: ',
        ),
        Row(
          children: [
            Radio<Gender>(
              value: Gender.male,
              groupValue: selectedGender,
              onChanged: (value) => setState(
                () {
                  selectedGender = value!;
                  widget.onChangedGender?.call(value);
                },
              ),
            ),
            const SizedBox(width: 4),
            Text(Gender.male.genderName),
          ],
        ),
        const SizedBox(width: 8),
        Row(
          children: [
            Radio<Gender>(
              value: Gender.female,
              groupValue: selectedGender,
              onChanged: (value) => setState(
                () {
                  selectedGender = value!;
                  widget.onChangedGender?.call(value);
                },
              ),
            ),
            const SizedBox(width: 4),
            Text(Gender.female.genderName),
          ],
        ),
      ],
    );
  }
}
