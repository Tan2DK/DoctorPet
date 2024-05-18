import 'package:doctor_pet/core/repos/auth_repo.dart';
import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        authRepo: Get.find<AuthRepo>(),
        localAuthRepo: Get.find<LocalAuthRepo>(),
      ),
    );
  }
}
