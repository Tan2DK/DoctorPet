import 'dart:convert';

import 'package:doctor_pet/core/data/response/manage_clinic_staff_response.dart';

class ManageClinicStaffRequest {
  final String? employeeId;
  final String? employeeName;
  final String? address;
  final String? phoneNumber;
  final String? email;
  final String? birthday;
  final bool? employeeStatus;
  final String? userId;
  ManageClinicStaffRequest({
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

  factory ManageClinicStaffRequest.fromMap(Map<String, dynamic> map) {
    return ManageClinicStaffRequest(
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

  factory ManageClinicStaffRequest.fromResponse(ManageClinicStaffResponse response) {
    return ManageClinicStaffRequest(
      employeeId: response.employeeId,
      employeeName: response.employeeName,
      address: response.address,
      phoneNumber: response.phoneNumber,
      email: response.email,
      birthday: response.birthday,
      employeeStatus: response.employeeStatus,
      userId: response.userId,
    );
  }

  String toJson() => json.encode(toMap());

  factory ManageClinicStaffRequest.fromJson(String source) =>
      ManageClinicStaffRequest.fromMap(json.decode(source));

  ManageClinicStaffRequest copyWith({
    String? employeeId,
    String? employeeName,
    String? address,
    String? phoneNumber,
    String? email,
    String? birthday,
    bool? employeeStatus,
    String? userId,
  }) {
    return ManageClinicStaffRequest(
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
    return 'CreateClinicStaffRequest(employeeId: $employeeId, employeeName: $employeeName, address: $address, phoneNumber: $phoneNumber, email: $email, birthday: $birthday, employeeStatus: $employeeStatus, userId: $userId)';
  }
}
