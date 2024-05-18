import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:doctor_pet/core/repos/pet_category_repo.dart';
import 'package:get/get.dart';

import '../../../core/repos/pet_repo.dart';
import 'pet_controller.dart';

class PetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetController>(
      () => PetController(
        localAuthRepo: Get.find<LocalAuthRepo>(),
        petCategoryRepo: Get.find<PetCategoryRepo>(),
        petRepo: Get.find<PetRepo>(),
      ),
    );
  }
}
