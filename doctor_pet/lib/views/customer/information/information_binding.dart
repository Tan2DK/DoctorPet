import 'package:doctor_pet/core/repos/auth_repo.dart';
import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:get/get.dart';

import 'information_controller.dart';

class InformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InformationController>(
      () => InformationController(
        authRepo: Get.find<AuthRepo>(),
        localAuthRepo: Get.find<LocalAuthRepo>(),
      ),
    );
  }
}
