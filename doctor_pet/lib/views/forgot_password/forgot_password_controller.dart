import 'package:doctor_pet/core/data/argument/otp_argument.dart';
import 'package:doctor_pet/utils/app_helper.dart';
import 'package:doctor_pet/utils/app_routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../core/repos/auth_repo.dart';

class ForgotPasswordController extends GetxController {
  Rx<String> username = Rx<String>('');
  RxBool canSubmit = RxBool(false);
  AuthRepo authRepo;
  ForgotPasswordController({
    required this.authRepo,
  });

  void usernameChanged(String? value) {
    username.value = value ?? '';
    checkSubmission();
  }

  void checkSubmission() {
    canSubmit.value = username.value.isNotEmpty;
  }

  Future<void> onTapSubmit() async {
    EasyLoading.show();
    final response = await authRepo.forgotPwd(
      username: username.value,
    );
    EasyLoading.dismiss();
    OtpArgument argument = OtpArgument(username: username.value);
    response.fold(
      (l) {},
      (r) {
        argument = argument.copyWith(userId: r);
      },
    );
    if (Get.isSnackbarOpen) Get.closeAllSnackbars();
    Get.snackbar(
      'Forgot Password',
      'An Otp has sent to your email',
      duration: const Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.toNamed(RoutesName.otp, arguments: argument);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    AppHelper.navigateNoNeedToAuth();
  }
}
