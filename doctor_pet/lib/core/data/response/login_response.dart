import 'dart:convert';

import 'package:doctor_pet/core/data/response/user_login_response.dart';

class LoginResponse {
  final UserLoginResponse? user;
  final String? accessToken;
  LoginResponse({
    this.user,
    this.accessToken,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (user != null) {
      result.addAll({'user': user!.toMap()});
    }
    if (accessToken != null) {
      result.addAll({'accessToken': accessToken});
    }

    return result;
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      user: map['user'] != null ? UserLoginResponse.fromMap(map['user']) : null,
      accessToken: map['accessToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source));

  @override
  String toString() => 'LoginResponse(user: $user, accessToken: $accessToken)';
}
