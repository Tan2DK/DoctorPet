import 'package:doctor_pet/core/repos/medicine_category_repo.dart';
import 'package:doctor_pet/core/repos/medicine_repo.dart';
import 'package:doctor_pet/views/clinic_manager/medicine/clinic_medicine_controller.dart';
import 'package:get/get.dart';

class ClinicMedicineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClinicMedicineController>(
      () => ClinicMedicineController(
        medicineRepo: Get.find<MedicineRepo>(),
        medicineCategoryRepo: Get.find<MedicineCategoryRepo>(),
      ),
    );
  }
}
