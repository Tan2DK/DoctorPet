import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:doctor_pet/core/data/request/login_request.dart';
import 'package:doctor_pet/core/data/request/register_request.dart';
import 'package:doctor_pet/core/data/response/user_response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/api_endpoint.dart';
import '../../../utils/app_config.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_routes.dart';
import '../../data/request/change_password_request.dart';
import '../../data/response/login_response.dart';
import '../../repos/auth_repo.dart';
import '../../repos/local_auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final String apiBaseUrl = Get.find<AppEnvironment>().apiBaseUrl;
  final localAuthRepo = Get.find<LocalAuthRepo>();

  @override
  Future<Either<String, UserResponse>> getUserInfor() async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.get(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.getUserInfor}',
        ),
      );
      switch (response.statusCode) {
        case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          var body = json.decode(response.body);
          final user = UserResponse.fromMap(body);
          return Right(user);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> editUserInfor(
      {required UserResponse user}) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.put(
        headers: headers,
        body: user.toJson(),
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.editUserInfor}',
        ),
      );

      switch (response.statusCode) {
        case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          return Right(response.body);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, LoginResponse>> login(
      {required LoginRequest loginRequest}) async {
    try {
      final response = await http.post(
        headers: AppHeaderApiConstant.baseHeader,
        body: loginRequest.toJson(),
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.login}',
        ),
      );
      switch (response.statusCode) {
        case ResponseStatusCode.ok:
          final body = response.body;
          return Right(LoginResponse.fromJson(body));
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> register(
      {required RegisterRequest registerRequest}) async {
    try {
      final response = await http.post(
        headers: AppHeaderApiConstant.baseHeader,
        body: registerRequest.toJson(),
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.register}',
        ),
      );

      switch (response.statusCode) {
        case ResponseStatusCode.ok:
          return Right(response.body);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> forgotPwd({required String username}) async {
    try {
      final response = await http.post(
        headers: AppHeaderApiConstant.baseHeader,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.forgot}?userName=$username',
        ),
      );
      switch (response.statusCode) {
        case ResponseStatusCode.ok:
          return Right(response.body);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> resetPwd(
      {required String password, required String userId}) async {
    try {
      final response = await http.post(
        headers: AppHeaderApiConstant.baseHeader,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.reset}?userId=$userId&newPass=$password',
        ),
      );

      switch (response.statusCode) {
        case ResponseStatusCode.ok:
          return Right(response.body);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> verifyOtp(
      {required String otp, required String userId}) async {
    try {
      final response = await http.post(
        headers: AppHeaderApiConstant.baseHeader,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.verify}?userId=$userId&OTP=$otp',
        ),
      );

      switch (response.statusCode) {
        case ResponseStatusCode.ok:
          return Right(response.body);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> changePwd(
      {required ChangePasswordRequest changePwd}) async {
    try {
      final response = await http.post(
        headers: AppHeaderApiConstant.baseHeader,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.changePassword}',
        ),
        body: changePwd.toJson(),
      );

      switch (response.statusCode) {
        case ResponseStatusCode.ok:
          return Right(response.body);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }
}
