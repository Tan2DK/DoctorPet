import 'package:doctor_pet/core/repos/auth_repo.dart';
import 'package:get/get.dart';

import 'change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(
        authRepo: Get.find<AuthRepo>(),
      ),
    );
  }
}
