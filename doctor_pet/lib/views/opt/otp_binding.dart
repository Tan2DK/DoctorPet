import 'package:doctor_pet/core/repos/auth_repo.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/views/opt/otp_controller.dart';

class OTPBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(
      () => OtpController(
        authRepo: Get.find<AuthRepo>(),
      ),
    );
  }
}
