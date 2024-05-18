import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_constant.dart';

abstract class AuthLocalStorage {
  String? getAuthToken();

  void removeAuthToken();

  Future<bool> saveAuthToken(String authToken);

  Future<bool> handleUnAuthorized();
}

// with shared pref
class AuthLocalStorageIpml implements AuthLocalStorage {
  SharedPreferences sharedPref;

  AuthLocalStorageIpml({required this.sharedPref});

  @override
  String? getAuthToken() {
    return sharedPref.getString(AppConstant.sharePrefKeys.authToken);
  }

  @override
  void removeAuthToken() {
    sharedPref.remove(AppConstant.sharePrefKeys.authToken);
  }

  @override
  Future<bool> saveAuthToken(String authToken) async {
    return await sharedPref.setString(
        AppConstant.sharePrefKeys.authToken, authToken);
  }

  @override
  Future<bool> handleUnAuthorized() async {
    return await sharedPref.remove(AppConstant.sharePrefKeys.authToken);
  }
}
