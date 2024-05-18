import 'package:doctor_pet/core/repos/pet_category_repo.dart';
import 'package:doctor_pet/views/admin/pet_category/pet_category_controller.dart';
import 'package:get/get.dart';

class PetCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetCategoryController>(
      () => PetCategoryController(
        petCategoryRepo: Get.find<PetCategoryRepo>(),
      ),
    );
  }
}
