import 'package:doctor_pet/core/data/response/appointment_response.dart';
import 'package:doctor_pet/utils/app_extension.dart';
import 'package:doctor_pet/views/doctor/doctor_appointment/doctor_appointment_controller.dart';
import 'package:doctor_pet/views/doctor/doctor_appointment/widgets/create_billing_dialog.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/app_enum.dart';

class AppointmentDrawer extends StatefulWidget {
  const AppointmentDrawer({super.key});

  @override
  State<AppointmentDrawer> createState() => _AppointmentDrawerState();
}

class _AppointmentDrawerState extends State<AppointmentDrawer> {
  DoctorAppointmentController? controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<DoctorAppointmentController>();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 3,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            if (controller?.selectedAppointment.value != null) ...[
              Text(
                'Appointment Detail Information',
                style: Theme.of(context).textTheme.titleLarge,
              ).paddingSymmetric(horizontal: 16),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pet Information',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          controller?.selectedAppointment.value?.pet?.petName ??
                              '',
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              controller?.selectedAppointment.value?.pet
                                          ?.petAge ==
                                      null
                                  ? ''
                                  : '${controller!.selectedAppointment.value!.pet!.petAge} years old',
                            ),
                            const SizedBox(width: 8),
                            Text(
                              controller?.selectedAppointment.value?.pet
                                          ?.petGender ==
                                      null
                                  ? ''
                                  : controller!.selectedAppointment.value!.pet!
                                          .petGender!
                                      ? Gender.male.genderName
                                      : Gender.female.genderName,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller?.selectedAppointment.value?.pet
                                  ?.petSpecies ??
                              '',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Appointment Time',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Text(controller?.selectedAppointment.value?.slot == null
                            ? ''
                            : FixedSlot
                                .values[controller!
                                    .selectedAppointment.value!.slot!]
                                .getName),
                        const SizedBox(height: 12),
                        Text(controller
                                ?.selectedAppointment.value?.appointmentDate
                                ?.formatDateTime('dd-MM-yyyy') ??
                            ''),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),
              const SizedBox(height: 16),
              const Divider(height: 0),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail Information',
                      style: Theme.of(context).textTheme.titleLarge,
                    ).paddingSymmetric(horizontal: 16),
                    const SizedBox(height: 12),
                    Text(
                      'Reason',
                      style: Theme.of(context).textTheme.titleMedium,
                    ).paddingSymmetric(horizontal: 16),
                    Text(controller?.selectedAppointment.value?.reason ?? '')
                        .paddingSymmetric(horizontal: 16),
                    const SizedBox(height: 12),
                    Text(
                      'Status',
                      style: Theme.of(context).textTheme.titleMedium,
                    ).paddingSymmetric(horizontal: 16),
                    Text(controller?.selectedAppointment.value?.status ?? '')
                        .paddingSymmetric(horizontal: 16),
                    const SizedBox(height: 12),
                    Text(
                      'Diagnosis',
                      style: Theme.of(context).textTheme.titleMedium,
                    ).paddingSymmetric(horizontal: 16),
                    const SizedBox(height: 12),

                    //  Text(controller
                    //                   ?.selectedAppointment.value?. ??
                    //
                    //       ''),
                    const SizedBox(height: 12),
                    Text(
                      'Medicines Information',
                      style: Theme.of(context).textTheme.titleLarge,
                    ).paddingSymmetric(horizontal: 16),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
            const Divider(height: 0),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              padding: const EdgeInsets.all(16),
              child: Wrap(
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 16,
                children: [
                  FilledButton(
                    onPressed: AppointmentStatus.values.byName((controller
                                        ?.selectedAppointment.value?.status ??
                                    '')
                                .toLowerCase()
                                .trim()) ==
                            AppointmentStatus.waiting
                        ? () => controller
                            ?.onConfirm(controller!.selectedAppointment.value!)
                        : null,
                    child: const Text(
                      'Confirm Attendance',
                    ),
                  ),
                  FilledButton(
                    onPressed: AppointmentStatus.values.byName((controller
                                        ?.selectedAppointment.value?.status ??
                                    '')
                                .toLowerCase()
                                .trim()) ==
                            AppointmentStatus.inprogress
                        ? () => Get.dialog(
                              Obx(
                                () => CreateBillingDialog(
                                  appointment:
                                      controller?.selectedAppointment.value ??
                                          AppointmentResponse(),
                                  categories:
                                      controller?.medicineCategories.value ??
                                          [],
                                  medicineRepo: controller?.medicineRepo,
                                  createBilling: controller?.createBilling,
                                ),
                              ),
                            )
                        : null,
                    child: const Text(
                      'Complete Examination',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
