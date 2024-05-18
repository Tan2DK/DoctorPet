import 'package:doctor_pet/utils/app_helper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/utils/app_routes.dart';

import '../../core/repos/auth_repo.dart';

class ChangePasswordController extends GetxController {
  Rx<String> password = Rx<String>('');
  Rx<String> cPassword = Rx<String>('');
  Rxn<String> errorPassword = Rxn<String>();
  Rxn<String> errorCPassword = Rxn<String>();
  String? userId;
  RxBool canSubmit = RxBool(false);
  AuthRepo authRepo;
  ChangePasswordController({
    required this.authRepo,
  });

  void passwordChanged(String? value) {
    password.value = value ?? '';
    if (cPassword.value.isNotEmpty) {
      if (password.value != cPassword.value) {
        errorCPassword.value = 'Confirm password and password must be same.';
        checkSubmission();
      } else {
        errorCPassword.value = null;
        checkSubmission();
      }
    }
    if (password.value.isEmpty) {
      errorPassword.value = 'Password is not allowed to blank.';
      checkSubmission();
      return;
    }
    if (password.value.length < 8 || password.value.length > 16) {
      errorPassword.value = 'Password must be in 8 to 16 characters.';
      checkSubmission();
      return;
    }
    if (!password.value.contains(RegExp(r'[a-z]'))) {
      errorPassword.value =
          'Password must contain at least 1 lowercase character';
      checkSubmission();
      return;
    }
    if (!password.value.contains(RegExp(r'[A-Z]'))) {
      errorPassword.value =
          'Password must contain at least 1 Uppercase character';
      checkSubmission();
      return;
    }
    if (!password.value.contains(RegExp(r'[0-9]'))) {
      errorPassword.value = 'Password must contain at least 1 digit character';
      checkSubmission();
      return;
    }
    if (!password.value.contains(RegExp(r'[(!@#$%^&*()\-_=+{};:,<.>ー?)]'))) {
      errorPassword.value =
          'Password must contain at least 1 special character';
      checkSubmission();
      return;
    }
    errorPassword.value = null;
    checkSubmission();
  }

  void cPasswordChanged(String? value) {
    cPassword.value = value ?? '';
    if (cPassword.value.isEmpty) {
      errorCPassword.value = 'Confirm password is not allowed to blank.';
      checkSubmission();

      return;
    }
    if (password.value != cPassword.value) {
      errorCPassword.value = 'Confirm password and password must be same.';
      checkSubmission();
      return;
    }
    errorCPassword.value = null;
    checkSubmission();
  }

  void checkSubmission() {
    canSubmit.value = cPassword.value.isNotEmpty &&
        password.value.isNotEmpty &&
        errorPassword.value == null &&
        errorCPassword.value == null;
  }

  Future<void> onTapSubmit() async {
    if (userId == null) return;
    EasyLoading.show();
    final response = await authRepo.resetPwd(
      userId: userId!,
      password: password.value,
    );
    EasyLoading.dismiss();
    response.fold(
      (l) => AppHelper.showErrorMessage(
        'Update Password',
        l,
      ),
      (r) {
        Get.offAllNamed(RoutesName.login);
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
    if (Get.arguments is! String) return;
    userId = Get.arguments;
  }
}
