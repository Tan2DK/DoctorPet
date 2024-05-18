import 'package:doctor_pet/core/repos/doctor_slots_repo.dart';
import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:get/get.dart';

import 'doctor_schedule_controller.dart';

class DoctorScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorScheduleController>(
      () => DoctorScheduleController(
        doctorSlotsRepo: Get.find<DoctorSlotsRepo>(),
        localAuthRepo: Get.find<LocalAuthRepo>(),
      ),
    );
  }
}
