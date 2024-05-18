import 'package:doctor_pet/core/repos/degree_repo.dart';
import 'package:doctor_pet/core/repos/doctor_repo.dart';
import 'package:get/get.dart';

import '../../../core/repos/appointment_repo.dart';
import 'staff_appointment_controller.dart';

class StaffAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaffAppointmentController>(
      () => StaffAppointmentController(
        appointmentRepo: Get.find<AppointmentRepo>(),
        doctorRepo: Get.find<DoctorRepo>(), 
        degreeRepo: Get.find<DegreeRepo>(),
      ),
    );
  }
}
