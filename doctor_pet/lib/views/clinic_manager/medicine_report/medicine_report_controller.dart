import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/repos/report_repo.dart';
import 'package:doctor_pet/utils/app_extension.dart';

import '../../../core/data/response/medicine_report_response.dart';
import '../../../utils/app_helper.dart';

class MedicineReportController extends GetxController {
  Rx<List<MedicineReportResponse>> medicineReportList =
      Rx<List<MedicineReportResponse>>([]);
  Rx<DateTime> startDate = Rx<DateTime>(DateTime.now().dateOnly);
  Rx<DateTime> endDate = Rx<DateTime>(DateTime.now().dateOnly);
  RxDouble total = RxDouble(0);
  final ReportRepo reportRepo;
  MedicineReportController({
    required this.reportRepo,
  });
  @override
  void onInit() {
    super.onInit();
    fetchMedicineReport();
  }

  Future<DateTime?> selectDate(
      BuildContext context, DateTime date, bool isEnd) async {
    return await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: isEnd ? startDate.value : DateTime(1900),
      lastDate: isEnd ? DateTime.now() : endDate.value,
    );
  }

  Future<void> fetchMedicineReport() async {
    EasyLoading.show();
    final response = await reportRepo.getMedicineReport(
      startDate: startDate.value.formatDateTime('yyyy-MM-dd'),
      endDate: endDate.value.formatDateTime('yyyy-MM-dd'),
    );
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Get Medicine Report', l),
      (r) {
        medicineReportList.value = r?.medicineReport ?? [];
        total.value = r?.duePrice ?? 0;
      },
    );
  }
}
