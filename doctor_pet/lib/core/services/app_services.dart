import 'dart:developer';

import 'package:doctor_pet/core/services/local_storages/auth_local_storages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppServices {
  static Future<void> initServices() async {
    log('Starting app services ...', name: 'AppServices');
    log('All app services started! ✅', name: 'AppServices');
    await Get.putAsync<SharedPreferences>(() async {
      return await SharedPreferences.getInstance();
    });
    Get.lazyPut<AuthLocalStorage>(
      () => AuthLocalStorageIpml(
        sharedPref: Get.find<SharedPreferences>(),
      ),
    );
    
  }
}
