import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:doctor_pet/utils/app_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppHelper {
  AppHelper._();
  static String getAbbrWeekDay(int weekday) {
    return Weekday.values[weekday - 1].getAbbr;
  }

  static String formatMonthNumber(int month) {
    return switch (month) {
      1 => '${month}st',
      2 => '${month}nd',
      3 => '${month}rd',
      _ => '${month}th',
    };
  }

  static Future<void> navigateNeedToAuth() async {
    final localAuthRepo = Get.find<LocalAuthRepo>();
    if (!(await localAuthRepo.checkAuth())) Get.offNamed(RoutesName.login);
  }

  static Future<void> navigateNoNeedToAuth() async {
    final localAuthRepo = Get.find<LocalAuthRepo>();
    final role = localAuthRepo.getRole();
    if (!(await localAuthRepo.checkAuth())) return;
    if (role == Role.customer) {
      Get.offAllNamed(RoutesName.customerHome);
      return;
    }
    Get.offAllNamed(RoutesName.home);
  }

  static void showErrorMessage(String title, String message) async {
    if (Get.isSnackbarOpen) Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM,
      colorText: const Color(0xFFBA1A1A),
      backgroundColor: const Color(0xFFBA1A1A).withOpacity(.2),
    );
  }
}
