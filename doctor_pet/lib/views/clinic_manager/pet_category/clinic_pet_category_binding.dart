import 'package:doctor_pet/core/repos/pet_category_repo.dart';
import 'package:get/get.dart';

import 'clinic_pet_category_controller.dart';

class ClinicPetCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClinicPetCategoryController>(
      () => ClinicPetCategoryController(
        petCategoryRepo: Get.find<PetCategoryRepo>(),
      ),
    );
  }
}
