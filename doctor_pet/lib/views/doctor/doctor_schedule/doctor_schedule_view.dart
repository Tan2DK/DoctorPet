import 'package:doctor_pet/core/data/argument/doctor_schedule_argument.dart';
import 'package:doctor_pet/views/schedule/schedule_controller.dart';
import 'package:doctor_pet/views/schedule/schedule_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'doctor_schedule_controller.dart';

class DoctorScheduleView extends GetView<DoctorScheduleController> {
  const DoctorScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: controller.call,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data == true) {
                    return GetBuilder(
                      builder: (controller) => const ScheduleView(),
                      init: ScheduleController(
                        argument: DoctorScheduleArgument(
                          availableSlots: controller.doctorSlots.value,
                          onSelectedSlots: controller.onSelectedDoctorSlots,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                }),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: controller.onUpdateDoctorSlots,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                minimumSize: const Size(120, 56),
              ),
              child: const Text('Submit'),
            ).paddingSymmetric(horizontal: 24, vertical: 24),
          ),
        ],
      ),
    );
  }
}
