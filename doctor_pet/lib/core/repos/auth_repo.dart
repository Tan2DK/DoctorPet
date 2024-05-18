import 'package:dartz/dartz.dart';
import 'package:doctor_pet/core/data/request/login_request.dart';
import 'package:doctor_pet/core/data/request/register_request.dart';
import 'package:doctor_pet/core/data/response/user_response.dart';

import '../data/request/change_password_request.dart';
import '../data/response/login_response.dart';

abstract class AuthRepo {
  Future<Either<String, LoginResponse>> login({
    required LoginRequest loginRequest,
  });

  Future<Either<String, String>> register({
    required RegisterRequest registerRequest,
  });

  Future<Either<String, UserResponse>> getUserInfor();

  Future<Either<String, String>> editUserInfor({
    required UserResponse user,
  });

  Future<Either<String, String>> forgotPwd({
    required String username,
  });

  Future<Either<String, String>> verifyOtp({
    required String otp,
    required String userId,
  });

  Future<Either<String, String>> resetPwd({
    required String password,
    required String userId,
  });
  Future<Either<String, String>> changePwd({
    required ChangePasswordRequest changePwd,
  });
}
