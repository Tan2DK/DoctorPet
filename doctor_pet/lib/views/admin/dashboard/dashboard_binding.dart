import 'package:doctor_pet/core/repos/clinic_repo.dart';
import 'package:doctor_pet/core/repos/doctor_repo.dart';
import 'package:doctor_pet/core/repos/staff_repo.dart';
import 'package:doctor_pet/core/repos/statistic_repo.dart';
import 'package:doctor_pet/views/admin/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(
        clinicRepo: Get.find<ClinicRepo>(),
        doctorRepo: Get.find<DoctorRepo>(),
        staffRepo: Get.find<StaffRepo>(),
        statisticRepo: Get.find<StatisticRepo>(),
      ),
    );
  }
}
