import 'package:doctor_pet/core/repos/doctor_repo.dart';
import 'package:doctor_pet/views/clinic_manager/doctor/clinic_doctor_controller.dart';

import 'package:get/get.dart';

import '../../../core/repos/degree_repo.dart';

class ClinicDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClinicDoctorController>(
      () => ClinicDoctorController(
        doctorRepo: Get.find<DoctorRepo>(),
        degreeRepo: Get.find<DegreeRepo>(),
      ),
    );
  }
}
