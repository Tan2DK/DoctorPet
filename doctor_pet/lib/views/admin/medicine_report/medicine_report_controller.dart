import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/repos/report_repo.dart';
import 'package:doctor_pet/utils/app_extension.dart';

import '../../../core/data/clinic_model.dart';
import '../../../core/data/response/medicine_report_response.dart';
import '../../../core/repos/clinic_repo.dart';
import '../../../utils/app_helper.dart';

class MedicineReportController extends GetxController {
  Rx<List<MedicineReportResponse>> medicineReportList =
      Rx<List<MedicineReportResponse>>([]);
  Rx<List<ClinicModel>> clinicList = Rx<List<ClinicModel>>([]);
  Rxn<ClinicModel> selectedClinic = Rxn();
  Rx<DateTime> startDate = Rx<DateTime>(DateTime.now().dateOnly);
  Rx<DateTime> endDate = Rx<DateTime>(DateTime.now().dateOnly);
  RxDouble total = RxDouble(0);
  final ReportRepo reportRepo;
  final ClinicRepo clinicRepo;

  MedicineReportController({
    required this.reportRepo,
    required this.clinicRepo,
  });
  @override
  Future<void> onInit() async {
    super.onInit();
    fetchClinic();
    await fetchMedicineReport();
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
  
  void onClinicSelected(ClinicModel? clinic) {
    selectedClinic.value = clinic;
    fetchMedicineReport();
  }

  Future<void> fetchMedicineReport() async {
    EasyLoading.show();
    final response = await reportRepo.getMedicineReportByClinic(
      startDate: startDate.value.formatDateTime('yyyy-MM-dd'),
      endDate: endDate.value.formatDateTime('yyyy-MM-dd'),
      clinicId: selectedClinic.value?.id,
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

  Future<void> fetchClinic() async {
    EasyLoading.show();
    final res = await clinicRepo.getClinic();
    EasyLoading.dismiss();
    res.fold((l) => AppHelper.showErrorMessage('Get Clinic', l), (r) {
      clinicList.value = r;
    });
  }


}
