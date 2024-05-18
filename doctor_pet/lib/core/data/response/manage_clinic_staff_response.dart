import 'dart:convert';

import 'package:doctor_pet/utils/app_extension.dart';

class ManageClinicStaffResponse {
  final String? employeeId;
  final String? employeeName;
  final String? address;
  final String? phoneNumber;
  final String? email;
  final String? birthday;
  final bool? employeeStatus;
  final String? userId;
  ManageClinicStaffResponse({
    this.employeeId,
    this.employeeName,
    this.address,
    this.phoneNumber,
    this.email,
    this.birthday,
    this.employeeStatus,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (employeeId != null) {
      result.addAll({'employeeId': employeeId});
    }
    if (employeeName != null) {
      result.addAll({'employeeName': employeeName});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (phoneNumber != null) {
      result.addAll({'phoneNumber': phoneNumber});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (birthday != null) {
      result.addAll({'birthday': birthday});
    }
    if (employeeStatus != null) {
      result.addAll({'employeeStatus': employeeStatus});
    }

    result.addAll({'userId': userId});

    return result;
  }

  factory ManageClinicStaffResponse.fromMap(Map<String, dynamic> map) {
    return ManageClinicStaffResponse(
      employeeId: map['employeeId'],
      employeeName: map['employeeName'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      birthday: map['birthday'],
      employeeStatus: map['employeeStatus'],
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ManageClinicStaffResponse.fromJson(String source) =>
      ManageClinicStaffResponse.fromMap(json.decode(source));

  ManageClinicStaffResponse copyWith({
    String? employeeId,
    String? employeeName,
    String? address,
    String? phoneNumber,
    String? email,
    String? birthday,
    bool? employeeStatus,
    String? userId,
  }) {
    return ManageClinicStaffResponse(
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      employeeStatus: employeeStatus ?? this.employeeStatus,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'MangeClinicStaffResponse(employeeId: $employeeId, employeeName: $employeeName, address: $address, phoneNumber: $phoneNumber, email: $email, birthday: $birthday, employeeStatus: $employeeStatus, userId: $userId)';
  }

  String toDataTable() {
    final day =
        birthday?.parseDateTime('yyyy-MM-dd').formatDateTime('dd-MM-yyyy');
    return 'Name: $employeeName\nAddress: $address\nPhone Number: $phoneNumber\nEmail: $email\nBirthday: $day\nStatus: $employeeStatus';
  }
}
