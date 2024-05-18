import 'package:doctor_pet/core/repos/medicine_category_repo.dart';
import 'package:get/get.dart';

import 'medicine_category_controller.dart';

class MedicineCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicineCategoryController>(
      () => MedicineCategoryController(
        medicineCategoryRepo: Get.find<MedicineCategoryRepo>(),
      ),
    );
  }
}
