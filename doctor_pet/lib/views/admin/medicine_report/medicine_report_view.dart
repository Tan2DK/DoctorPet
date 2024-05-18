import 'package:doctor_pet/common_widget/custom_text/custom_text_widget.dart';
import 'package:doctor_pet/common_widget/select_clinic_widget.dart';
import 'package:doctor_pet/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:doctor_pet/common_widget/data_title_widget.dart';
import 'package:get/get.dart';

import '../../../core/data/data_title_model.dart';
import 'medicine_report_controller.dart';

class MedicineReportView extends GetView<MedicineReportController> {
  const MedicineReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Medicine Report',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ).paddingOnly(left: 16, right: 16, top: 16),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Obx(
                  () => SelectClinicWidget(
                    clinic: controller.selectedClinic.value,
                    clinicList: controller.clinicList.value,
                    onClinicSelected: controller.onClinicSelected,
                  ),
                ),
              ),
              const SizedBox(width: 32),
              const CustomTextWidget(
                text: 'Start Day:',
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(width: 8),
              Obx(
                () => FilledButton.tonalIcon(
                  onPressed: () async {
                    final date = await controller.selectDate(
                      context,
                      controller.startDate.value,
                      false,
                    );
                    if (date == null) return;
                    controller.startDate.value = date;
                    controller.fetchMedicineReport();
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                  label: Text(
                    controller.startDate.value.formatDateTime('dd-MM-yyyy'),
                  ),
                ),
              ),
              const SizedBox(width: 32),
              const CustomTextWidget(
                text: 'End Day:',
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(width: 16),
              Obx(
                () => FilledButton.tonalIcon(
                  onPressed: () async {
                    final date = await controller.selectDate(
                      context,
                      controller.endDate.value,
                      true,
                    );
                    if (date == null) return;
                    controller.endDate.value = date;
                    controller.fetchMedicineReport();
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                  label: Text(
                    controller.endDate.value.formatDateTime('dd-MM-yyyy'),
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16),
          const SizedBox(height: 10),
          DataTitleWidget(
            leftSpacing: 16,
            verticalPadding: 8,
            titles: [
              DataTitleModel(name: 'Medicine Name', flex: 4),
              DataTitleModel(name: 'Unit', flex: 3),
              DataTitleModel(name: 'Quantity', flex: 3),
              DataTitleModel(name: 'Price', flex: 2),
              DataTitleModel(name: 'Total Price', flex: 2),
            ],
          ),
          const Divider(thickness: 3, height: 0),
          Obx(
            () => Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(height: 0),
                itemBuilder: (context, index) => DataTitleWidget(
                  leftSpacing: 16,
                  verticalPadding: 8,
                  titles: [
                    DataTitleModel(
                        name: controller
                                .medicineReportList.value[index].medicineName ??
                            '',
                        flex: 4),
                    DataTitleModel(
                        name: controller.medicineReportList.value[index].unit ==
                                null
                            ? ''
                            : controller.medicineReportList.value[index].unit
                                .toString(),
                        flex: 3),
                    DataTitleModel(
                        name: controller
                                    .medicineReportList.value[index].quantity ==
                                null
                            ? ''
                            : controller
                                .medicineReportList.value[index].quantity
                                .toString(),
                        flex: 3),
                    DataTitleModel(
                        name: controller
                                    .medicineReportList.value[index].price ==
                                null
                            ? ''
                            : controller.medicineReportList.value[index].price
                                .toString(),
                        flex: 2),
                    DataTitleModel(
                        name: controller.medicineReportList.value[index]
                                    .totalPrice ==
                                null
                            ? ''
                            : controller
                                .medicineReportList.value[index].totalPrice
                                .toString(),
                        flex: 2),
                  ],
                ),
                itemCount: controller.medicineReportList.value.length,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: Obx(
              () => CustomTextWidget(
                text: 'Total due price: ${controller.total.value}',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ).paddingSymmetric(horizontal: 16),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}
