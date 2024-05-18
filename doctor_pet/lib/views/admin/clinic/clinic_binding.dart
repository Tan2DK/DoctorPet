import 'package:doctor_pet/core/repos/clinic_repo.dart';
import 'package:doctor_pet/views/admin/clinic/clinic_controller.dart';
import 'package:get/get.dart';

class ClinicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClinicController>(
      () => ClinicController(
        clinicRepo: Get.find<ClinicRepo>(),
      ),
    );
  }
}
