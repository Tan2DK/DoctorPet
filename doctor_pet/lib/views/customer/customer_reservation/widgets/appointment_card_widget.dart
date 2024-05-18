import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/response/appointment_response.dart';
import 'package:doctor_pet/utils/app_extension.dart';

import '../../../../utils/app_enum.dart';
import 'title_value_widget.dart';

class AppointmentCardWidget extends StatelessWidget {
  const AppointmentCardWidget({
    Key? key,
    this.appointmentResponse,
    this.textColor,
    this.bgColor,
  }) : super(key: key);
  final AppointmentResponse? appointmentResponse;
  final Color? textColor;
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TitleValueWidget(
              title: 'Clinic: ',
              textColor: textColor,
              value: appointmentResponse?.clinic?.clinicName ?? '',
            ),
            const SizedBox(width: 16),
            TitleValueWidget(
              title: 'Address: ',
              textColor: textColor,
              value: appointmentResponse?.clinic?.address ?? '',
            ),
            const SizedBox(width: 16),
            TitleValueWidget(
              title: 'Date: ',
              textColor: textColor,
              value: (appointmentResponse?.appointmentDate ??
                      DateTime.now().dateOnly)
                  .formatDateTime('dd-MM-yyyy'),
            ),
            const SizedBox(width: 16),
            TitleValueWidget(
              title: 'Time: ',
              textColor: textColor,
              value: FixedSlot.values
                  .elementAt(
                    appointmentResponse?.slot ?? 0,
                  )
                  .getName,
            ),
            const SizedBox(width: 16),
            TitleValueWidget(
              title: 'Phone: ',
              textColor: textColor,
              value: appointmentResponse?.clinic?.clinicPhoneNumber ?? '',
            ),
            const SizedBox(width: 16),
            TitleValueWidget(
              title: 'Status: ',
              textColor: textColor,
              value: appointmentResponse?.status ?? '',
            ),
            const SizedBox(width: 16),
            TitleValueWidget(
              title: 'Doctor: ',
              textColor: textColor,
              value: appointmentResponse?.doctor?.doctorName ?? '',
            ),
            const SizedBox(width: 16),
            TitleValueWidget(
              title: 'Pet name: ',
              textColor: textColor,
              value: appointmentResponse?.pet?.petName ?? '',
            ),
            const SizedBox(width: 16),
            TitleValueWidget(
              title: 'Species: ',
              textColor: textColor,
              value: appointmentResponse?.pet?.petSpecies ?? '',
            ),
            const SizedBox(width: 16),
            TitleValueWidget(
              title: 'Reason: ',
              textColor: textColor,
              value: appointmentResponse?.reason ?? '',
            ),
            const SizedBox(width: 16),
          ],
        ).paddingSymmetric(vertical: 24, horizontal: 16),
      ),
    );
  }
}
