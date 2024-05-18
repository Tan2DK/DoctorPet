import 'package:doctor_pet/core/repos/report_repo.dart';
import 'package:doctor_pet/views/clinic_manager/medicine_report/medicine_report_controller.dart';
import 'package:get/get.dart';

class MedicineReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicineReportController>(
      () => MedicineReportController(
        reportRepo: Get.find<ReportRepo>(),
      ),
    );
  }
}
