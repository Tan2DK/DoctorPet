import 'package:doctor_pet/core/repos/clinic_repo.dart';
import 'package:doctor_pet/core/repos/report_repo.dart';
import 'package:get/get.dart';

import 'medicine_report_controller.dart';

class MedicineReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicineReportController>(
      () => MedicineReportController(
        clinicRepo: Get.find<ClinicRepo>(),
        reportRepo: Get.find<ReportRepo>(),
      ),
    );
  }
}
