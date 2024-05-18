import 'package:doctor_pet/core/repos/auth_repo.dart';
import 'package:get/get.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(
        authRepo: Get.find<AuthRepo>(),
      ),
    );
  }
}
