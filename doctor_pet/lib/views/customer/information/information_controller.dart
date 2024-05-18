import 'package:doctor_pet/core/data/request/change_password_request.dart';
import 'package:doctor_pet/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/repos/auth_repo.dart';
import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:doctor_pet/utils/app_extension.dart';
import 'package:doctor_pet/utils/app_helper.dart';
import 'package:doctor_pet/views/customer/information/widgets/information_form_widget.dart';
import 'package:doctor_pet/views/customer/information/widgets/password_form_widget.dart';

import '../../../core/data/response/user_response.dart';

class InformationController extends GetxController {
  final AuthRepo authRepo;
  final LocalAuthRepo localAuthRepo;
  Rxn<String> errorName = Rxn<String>();
  Rxn<String> errorEmail = Rxn<String>();
  Rxn<String> errorAddress = Rxn<String>();
  Rxn<String> errorPhone = Rxn<String>();
  Rxn<String> errorOldPassword = Rxn<String>();
  Rxn<String> errorPassword = Rxn<String>();
  Rxn<String> errorCPassword = Rxn<String>();
  Rx<String> oldPassword = Rx<String>('');
  Rx<String> password = Rx<String>('');
  Rx<String> cPassword = Rx<String>('');
  RxBool canSubmit = RxBool(false);
  RxBool canSubmitPassword = RxBool(false);
  Rxn<UserResponse> oldUser = Rxn();
  Rxn<UserResponse> newUser = Rxn();
  Rxn<TextEditingController> nameController = Rxn();
  Rxn<TextEditingController> emailController = Rxn();
  Rxn<TextEditingController> addressController = Rxn();
  Rxn<TextEditingController> phoneController = Rxn();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();

  RxInt tabIndexed = RxInt(0);

  List<String> tabButton = ['User Information', 'Change Password'];
  List<Widget> pageViews = [
    const InformationFormWidget(),
    const PasswordFormWidget(),
  ];

  InformationController({
    required this.authRepo,
    required this.localAuthRepo,
  });

  void onTapTabButton(int index) {
    tabIndexed.value = index;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    final res = await authRepo.getUserInfor();
    res.fold((l) => Get.back, (r) => oldUser.value = r);
    nameController.value = TextEditingController(text: oldUser.value?.fullname);
    emailController.value = TextEditingController(text: oldUser.value?.email);
    addressController.value =
        TextEditingController(text: oldUser.value?.address);
    phoneController.value = TextEditingController(text: oldUser.value?.phone);
    oldUser.value = oldUser.value?.copyWith(
      birthday: (oldUser.value?.birthday ??
              DateTime.now().dateOnly.formatDateTime('yyyy-MM-dd'))
          .parseDateTime('yyyy-MM-dd')
          .formatDateTime('yyyy-MM-dd'),
    );
    initNewUser();
  }

  void emailChanged(String? value) {
    newUser.value = newUser.value?.copyWith(email: value ?? '');
    if (newUser.value?.email.isEmpty ?? true) {
      errorEmail.value = 'Email is not allowed to blank.';
      checkSubmission();
      return;
    }
    errorEmail.value =
        newUser.value!.email.isEmail ? null : 'Email address is not valid';
    checkSubmission();
  }

  void nameChanged(String? value) {
    newUser.value = newUser.value?.copyWith(fullname: value ?? '');
    if (newUser.value?.fullname.isEmpty ?? true) {
      errorName.value = 'Fullname is not allowed to blank.';
      checkSubmission();
      return;
    }
    errorName.value = null;
    checkSubmission();
  }

  void addressChanged(String? value) {
    newUser.value = newUser.value?.copyWith(address: value ?? '');
    if (newUser.value?.address.isEmpty ?? true) {
      errorAddress.value = 'Address is not allowed to blank.';
      checkSubmission();
      return;
    }
    errorAddress.value = null;
    checkSubmission();
  }

  void phoneChanged(String? value) {
    newUser.value = newUser.value?.copyWith(phone: value ?? '');
    if (newUser.value?.phone.isEmpty ?? true) {
      errorPhone.value = 'Phone is not allowed to blank.';
      checkSubmission();
      return;
    }
    if (!newUser.value!.phone.isPhoneNumber ||
        newUser.value?.phone.length != 10) {
      errorPhone.value = 'Phone Number is invalid.';
      checkSubmission();

      return;
    }
    errorPhone.value = null;
    checkSubmission();
  }

  void checkSubmission() {
    bool isNotEmpty = !isNewUserEmpty;

    bool isValid = errorName.value == null &&
        errorEmail.value == null &&
        errorAddress.value == null &&
        errorPhone.value == null;
    canSubmit.value = newUser.value != oldUser.value && isNotEmpty && isValid;
  }

  void checkSubmissionPassword() {
    bool isValid = errorPassword.value == null &&
        errorOldPassword.value == null &&
        errorCPassword.value == null;
    bool isNotEmpty = password.value.isNotEmpty &&
        oldPassword.value.isNotEmpty &&
        cPassword.value.isNotEmpty;
    canSubmitPassword.value = isValid && isNotEmpty;
  }

  Future<void> birthdayChanged(BuildContext context) async {
    final initDate = ((newUser.value?.birthday ?? oldUser.value?.birthday) ??
            DateTime.now().dateOnly.formatDateTime('yyyy-MM-dd'))
        .parseDateTime('yyyy-MM-dd');
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: initDate,
    );
    if (picked == null) return;
    newUser.value =
        newUser.value?.copyWith(birthday: picked.formatDateTime('yyyy-MM-dd'));
    checkSubmission();
  }

  void oldPasswordChanged(String? value) {
    oldPassword.value = value ?? '';
    if (oldPassword.value.isEmpty) {
      errorOldPassword.value = 'Old Password is not allowed to blank.';
      checkSubmissionPassword();
      return;
    }
    if (password.value.isNotEmpty) {
      if (oldPassword.value == password.value) {
        errorPassword.value = 'Password must be not same old password';
        checkSubmissionPassword();
        return;
      } else {
        errorPassword.value = null;
        checkSubmissionPassword();
      }
    }

    errorOldPassword.value = null;
    checkSubmissionPassword();
    return;
  }

  void passwordChanged(String? value) {
    password.value = value ?? '';
    if (password.value.isEmpty) {
      errorPassword.value = 'Password is not allowed to blank.';
      checkSubmissionPassword();
      return;
    }
    if (oldPassword.value == value) {
      errorPassword.value = 'Password must be not same old password';
      checkSubmissionPassword();
      return;
    }
    if (cPassword.value.isNotEmpty) {
      if (password.value != cPassword.value) {
        errorCPassword.value = 'Confirm password and password must be same.';
        checkSubmissionPassword();
      } else {
        errorCPassword.value = null;
        checkSubmissionPassword();
      }
    }
    if (password.value.length < 8 || password.value.length > 16) {
      errorPassword.value = 'Password must be in 8 to 16 characters.';
      checkSubmissionPassword();
      return;
    }
    if (!password.value.contains(RegExp(r'[a-z]'))) {
      errorPassword.value =
          'Password must contain at least 1 lowercase character';
      checkSubmissionPassword();
      return;
    }
    if (!password.value.contains(RegExp(r'[A-Z]'))) {
      errorPassword.value =
          'Password must contain at least 1 Uppercase character';
      checkSubmissionPassword();
      return;
    }
    if (!password.value.contains(RegExp(r'[0-9]'))) {
      errorPassword.value = 'Password must contain at least 1 digit character';
      checkSubmissionPassword();
      return;
    }
    if (!password.value.contains(RegExp(r'[(!@#$%^&*()\-_=+{};:,<.>ー?)]'))) {
      errorPassword.value =
          'Password must contain at least 1 special character';
      checkSubmissionPassword();
      return;
    }
    errorPassword.value = null;
    checkSubmissionPassword();
  }

  void cPasswordChanged(String? value) {
    cPassword.value = value ?? '';
    if (cPassword.value.isEmpty) {
      errorCPassword.value = 'Confirm password is not allowed to blank.';
      checkSubmissionPassword();

      return;
    }
    if (password.value != cPassword.value) {
      errorCPassword.value = 'Confirm password and password must be same.';
      checkSubmissionPassword();
      return;
    }
    errorCPassword.value = null;
    checkSubmissionPassword();
  }

  Future<void> onTapUpdate() async {
    if (newUser.value == null) return;
    EasyLoading.show();
    final res = await authRepo.editUserInfor(
      user: newUser.value!.copyWith(id: localAuthRepo.userId()),
    );
    EasyLoading.dismiss();

    res.fold((l) => AppHelper.showErrorMessage('Update information', l), (r) {
      Get.snackbar(
        'Update information',
        r,
        snackPosition: SnackPosition.BOTTOM,
      );
      oldUser.value = newUser.value;
      checkSubmission();
    });
  }

  Future<void> onTapUpdatePassword() async {
    EasyLoading.show();
    final res = await authRepo.changePwd(
      changePwd: ChangePasswordRequest(
        newPass: password.value,
        oldPass: oldPassword.value,
      ),
    );
    EasyLoading.dismiss();
    res.fold((l) => AppHelper.showErrorMessage('Update password', l), (r) {
      Get.snackbar(
        'Update password',
        r,
        snackPosition: SnackPosition.BOTTOM,
      );
      clearPwdField();
      checkSubmissionPassword();
      logout();
    });
  }

  void clearPwdField() {
    oldPasswordController.clear();
    passwordController.clear();
    cPasswordController.clear();
    errorOldPassword.value = null;
    errorPassword.value = null;
    errorCPassword.value = null;
  }

  void initNewUser() {
    if (newUser.value == null && oldUser.value == null) {
      newUser.value = UserResponse(
        username: '',
        fullname: '',
        email: '',
        address: '',
        phone: '',
        birthday: DateTime.now().dateOnly.formatDateTime('yyyy-MM-dd'),
      );
    }
    newUser.value ??= oldUser.value;
  }

  bool get isNewUserEmpty =>
      (newUser.value?.fullname.isEmpty ?? true) ||
      (newUser.value?.email.isEmpty ?? true) ||
      (newUser.value?.address.isEmpty ?? true) ||
      (newUser.value?.phone.isEmpty ?? true);

  Future<void> logout() async {
    await localAuthRepo.handleUnAuthorized();
    Get.offAllNamed(RoutesName.login);
  }
}
