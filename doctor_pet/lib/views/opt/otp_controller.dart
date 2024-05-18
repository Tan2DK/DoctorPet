import 'package:doctor_pet/core/data/argument/otp_argument.dart';
import 'package:doctor_pet/utils/app_helper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:doctor_pet/utils/app_routes.dart';

import '../../core/repos/auth_repo.dart';

class OtpController extends GetxController {
  Rx<String> otp = Rx<String>('');
  RxBool canSubmit = RxBool(false);
  AuthRepo authRepo;
  OtpArgument? argument;
  OtpController({
    required this.authRepo,
  });

  void otpChanged(String? value) {
    otp.value = value ?? '';
    checkSubmission();
  }

  void checkSubmission() {
    canSubmit.value = otp.value.isNotEmpty;
  }

  Future<void> resendOtp() async {
    if (argument?.username?.isEmpty ?? true) return;
    EasyLoading.show();
    await authRepo.forgotPwd(
      username: argument!.username!,
    );
    EasyLoading.dismiss();
    if (Get.isSnackbarOpen) Get.closeAllSnackbars();
    Get.snackbar(
      'Resend Otp',
      'An Otp has sent to your email',
      duration: const Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.toNamed(RoutesName.otp, arguments: argument);
  }

  Future<void> onTapSubmit() async {
    if ((argument?.username?.isEmpty ?? true) ||
        (argument?.userId?.isEmpty ?? true)) return;
    EasyLoading.show();
    final response = await authRepo.verifyOtp(
      otp: otp.value,
      userId: argument!.userId!,
    );
    EasyLoading.dismiss();
    response.fold(
      (l) => AppHelper.showErrorMessage(
        'Verify',
        l,
      ),
      (r) {
        Get.offNamed(RoutesName.changePassword, arguments: argument!.userId!);
      },
    );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    AppHelper.navigateNoNeedToAuth();
  }

  @override
  void onReady() {
    super.onReady();
    if (Get.arguments is! OtpArgument) return;
    argument = Get.arguments;
  }
}
