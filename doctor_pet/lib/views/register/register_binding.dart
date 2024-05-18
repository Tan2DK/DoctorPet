import 'package:doctor_pet/core/repos/auth_repo.dart';
import 'package:get/get.dart';

import 'register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        authRepo: Get.find<AuthRepo>(),
      ),
    );
  }
}
