import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:doctor_pet/core/data/jwt_decode_model.dart';
import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:doctor_pet/core/services/local_storages/auth_local_storages.dart';

import '../../../utils/app_enum.dart';

class LocalAuthRepoImpl implements LocalAuthRepo {
  AuthLocalStorage authLocalStorage;
  LocalAuthRepoImpl({
    required this.authLocalStorage,
  });

  @override
  String? userId() {
    final authToken = authLocalStorage.getAuthToken();
    if (authToken?.isEmpty ?? true) return null;
    final jWTDecodeModel = decodeJWT(authToken!);
    return jWTDecodeModel?.userId;
  }

  @override
  String? getAuthToken() {
    final authToken = authLocalStorage.getAuthToken();
    if (authToken?.isEmpty ?? true) return authToken;
    decodeJWT(authToken!);
    return authToken;
  }

  JWTDecodeModel? decodeJWT(String token) {
    final decoder = JwtDecoder.decode(token);
    final jWTDecodeModel = JWTDecodeModel.fromMap(decoder);
    return jWTDecodeModel;
  }

  @override
  Future<bool> saveAuthToken(String? authToken) async {
    if (authToken?.isEmpty ?? true) return false;
    decodeJWT(authToken!);
    return await authLocalStorage.saveAuthToken(authToken);
  }

  @override
  Future<bool> handleUnAuthorized() async {
    return authLocalStorage.handleUnAuthorized();
  }

  @override
  Future<bool> checkAuth() async {
    final token = getAuthToken();
    if (token?.isEmpty ?? true) return false;
    return !JwtDecoder.isExpired(token!);
  }

  @override
  Future<Map<String, String>?> getAuthorHeader() async {
    final token = getAuthToken();
    if ((token?.isEmpty ?? true) || !(await checkAuth())) return null;
    return {'Authorization': 'Bearer $token'};
  }

  @override
  Role? getRole() {
    final token = getAuthToken();
    if ((token?.isEmpty ?? true)) return null;
    final jWTDecodeModel = decodeJWT(token!);
    final Map<String, Role> roles = {
      '0': Role.admin,
      '1': Role.customer,
      '2': Role.doctor,
      '3': Role.staff,
      '4': Role.clinicManager,
    };
    return roles[jWTDecodeModel?.userRole];
  }
}
