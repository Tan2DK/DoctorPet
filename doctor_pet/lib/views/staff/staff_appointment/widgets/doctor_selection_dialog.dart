import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/common_widget/data_title_widget.dart';
import 'package:doctor_pet/core/data/data_title_model.dart';
import 'package:doctor_pet/core/data/response/degree_response.dart';
import 'package:doctor_pet/core/data/response/doctor_response.dart';

import '../../../../core/data/response/appointment_response.dart';

class DoctorSelectionDialog extends StatefulWidget {
  const DoctorSelectionDialog({
    Key? key,
    this.appointment,
    this.doctors,
    this.degrees,
    this.confirmChanged,
  }) : super(key: key);
  final AppointmentResponse? appointment;
  final List<DoctorResponse>? doctors;
  final List<DegreeResponse>? degrees;
  final Function(DoctorResponse, AppointmentResponse)? confirmChanged;

  @override
  State<DoctorSelectionDialog> createState() => _DoctorSelectionDialogState();
}

class _DoctorSelectionDialogState extends State<DoctorSelectionDialog> {
  List<DropdownMenuEntry<DoctorResponse>> doctorMenuItem = [];
  DoctorResponse? selectedDoctor;
  @override
  void initState() {
    super.initState();
    if (widget.doctors == null) return;
    selectedDoctor = widget.appointment?.doctor;
    doctorMenuItem = widget.doctors!
        .map<DropdownMenuEntry<DoctorResponse>>(
          (e) => DropdownMenuEntry<DoctorResponse>(
            label: e.doctorName ?? '',
            value: e,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width / 4,
          minHeight: 325,
        ),
        child: SizedBox(
          height: size.height * 2 / 5,
          child: Column(
            children: [
              const SizedBox(height: 16),
              DropdownMenu<DoctorResponse>(
                dropdownMenuEntries: doctorMenuItem,
                enableSearch: true,
                enableFilter: true,
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                expandedInsets: EdgeInsets.zero,
                menuHeight: 200,
                hintText: 'Assign new doctor',
                onSelected: (doctor) => setState(() {
                  selectedDoctor = doctor;
                }),
              ).paddingSymmetric(horizontal: 16),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ...(selectedDoctor ?? const DoctorResponse())
                        .toEmptyMapForSelection()
                        .map(
                          (key, value) {
                            String degreeName = '';
                            if (key == 'Degree') {
                              degreeName = widget.degrees
                                      ?.firstWhereOrNull(
                                          (degree) => degree.degreeId == value)
                                      ?.degreeName ??
                                  '';
                            }
                            return MapEntry(
                              key,
                              SizedBox(
                                width: 250,
                                child: DataTitleWidget(
                                  leftSpacing: 0,
                                  verticalPadding: 8,
                                  titles: [
                                    DataTitleModel(name: key, flex: 1),
                                    DataTitleModel(
                                        name: key == 'Degree'
                                            ? degreeName
                                            : value,
                                        flex: 1),
                                  ],
                                ),
                              ).paddingSymmetric(horizontal: 16),
                            );
                          },
                        )
                        .values
                        .toList(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: Get.back, child: const Text('Cancel')),
                  const SizedBox(width: 8),
                  FilledButton(
                      onPressed: selectedDoctor == widget.appointment?.doctor ||
                              selectedDoctor == null
                          ? null
                          : () => widget.confirmChanged
                              ?.call(selectedDoctor!, widget.appointment!),
                      child: const Text('Confirm')),
                ],
              ).paddingOnly(right: 16),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
