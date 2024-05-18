import 'dart:convert';

import 'package:doctor_pet/utils/app_extension.dart';

class UserLoginResponse {
  final String? userId;
  final String? username;
  final String? password;
  final String? fullname;
  final String? email;
  final String? phone;
  final String? address;
  final DateTime? birthday;
  final int? role;
  UserLoginResponse({
    this.userId,
    this.username,
    this.password,
    this.fullname,
    this.email,
    this.phone,
    this.address,
    this.birthday,
    this.role,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'userName': username});
    result.addAll({'password': password});
    result.addAll({'fullName': fullname});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phone});
    result.addAll({'address': address});
    result.addAll({'birthday': birthday?.formatDateTime('yyyy-MM-dd')});
    result.addAll({'userRole': role});

    return result;
  }

  factory UserLoginResponse.fromMap(Map<String, dynamic> map) {
    return UserLoginResponse(
      userId: map['userId'] ?? '',
      username: map['userName'] ?? '',
      password: map['password'] ?? '',
      fullname: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      birthday: map['birthday'].toString().parseDateTime('yyyy-MM-dd'),
      role: map['userRole'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoginResponse.fromJson(String source) =>
      UserLoginResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserLoginResponse(userId: $userId, username: $username, password: $password, fullname: $fullname, email: $email, phone: $phone, address: $address, birthday: $birthday, role: $role)';
  }
}
