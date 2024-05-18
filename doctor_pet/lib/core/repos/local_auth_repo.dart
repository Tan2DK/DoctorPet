import '../../utils/app_enum.dart';

abstract class LocalAuthRepo {
  String? userId();

  String? getAuthToken();

  Future<bool> saveAuthToken(String? authToken);

  Future<bool> handleUnAuthorized();

  Future<bool> checkAuth();

  Future<Map<String, String>?> getAuthorHeader();

  Role? getRole();
}
