import 'package:flutter/material.dart';

import 'package:doctor_pet/common_widget/custom_text/custom_text_widget.dart';

import '../core/data/clinic_model.dart';

class SelectClinicWidget extends StatefulWidget {
  const SelectClinicWidget({
    Key? key,
    required this.clinicList,
    this.clinic,
    this.onClinicSelected,
  }) : super(key: key);

  final List<ClinicModel> clinicList;
  final ClinicModel? clinic;
  final Function(ClinicModel?)? onClinicSelected;

  @override
  State<SelectClinicWidget> createState() => _SelectClinicWidgetState();
}

class _SelectClinicWidgetState extends State<SelectClinicWidget> {
  ClinicModel? selectedClinic;
  final TextEditingController dropdownController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedClinic = widget.clinic;
    dropdownController.text = selectedClinic?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomTextWidget(
          text: 'Select Clinic: ',
        ),
        const SizedBox(width: 8),
        Expanded(
          child: DropdownMenu<ClinicModel>(
            dropdownMenuEntries: widget.clinicList.map((clinic) {
              return DropdownMenuEntry(
                label: clinic.name,
                value: clinic,
              );
            }).toList()
              ..insert(0,
                  DropdownMenuEntry(value: ClinicModel.empty(), label: '...')),
            controller: dropdownController,
            onSelected: (value) {
              setState(() {
                widget.onClinicSelected
                    ?.call(value == ClinicModel.empty() ? null : value);
              });
            },
            menuHeight: 200,
            width: MediaQuery.of(context).size.width / 4,
          ),
        ),
      ],
    );
  }
}
