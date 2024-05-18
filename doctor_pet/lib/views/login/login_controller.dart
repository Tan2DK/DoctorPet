import 'package:doctor_pet/utils/app_helper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/request/login_request.dart';
import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:doctor_pet/utils/app_routes.dart';

import '../../core/repos/auth_repo.dart';
import '../../utils/app_enum.dart';

class LoginController extends GetxController {
  Rx<String> username = Rx<String>('');
  Rx<String> password = Rx<String>('');
  RxBool canSubmit = RxBool(false);
  AuthRepo authRepo;
  LocalAuthRepo localAuthRepo;
  LoginController({
    required this.authRepo,
    required this.localAuthRepo,
  });

  void usernameChanged(String? value) {
    username.value = value ?? '';
    checkSubmission();
  }

  void passwordChanged(String? value) {
    password.value = value ?? '';
    checkSubmission();
  }

  void checkSubmission() {
    canSubmit.value = username.value.isNotEmpty && password.value.isNotEmpty;
  }

  Future<void> onTapSubmit() async {
    EasyLoading.show();
    final response = await authRepo.login(
      loginRequest: LoginRequest(
        username: username.value,
        password: password.value,
      ),
    );
    EasyLoading.dismiss();
    response.fold(
      (l) => AppHelper.showErrorMessage(
        'Login',
        'Username or password is incorrect',
      ),
      (r) async {
        if (!(await localAuthRepo.saveAuthToken(r.accessToken))) return;
        final role = localAuthRepo.getRole();
        if (role == null || (await localAuthRepo.getAuthorHeader()) == null) {
          return;
        }
        if (role == Role.customer) {
          Get.offAllNamed(RoutesName.customerHome);
          return;
        }
        Get.offAllNamed(RoutesName.home);
      },
    );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    AppHelper.navigateNoNeedToAuth();
  }
}
