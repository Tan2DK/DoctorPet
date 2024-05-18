import 'package:doctor_pet/core/repos/medicine_category_repo.dart';
import 'package:doctor_pet/core/repos/medicine_repo.dart';
import 'package:get/get.dart';

import '../../../core/repos/appointment_repo.dart';
import 'doctor_appointment_controller.dart';

class DoctorAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorAppointmentController>(
      () => DoctorAppointmentController(
        appointmentRepo: Get.find<AppointmentRepo>(),
        medicineCategoryRepo: Get.find<MedicineCategoryRepo>(),
        medicineRepo: Get.find<MedicineRepo>(),
      ),
    );
  }
}
