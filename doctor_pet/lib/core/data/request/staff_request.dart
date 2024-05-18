import 'dart:convert';

import 'package:doctor_pet/core/data/response/staff_response.dart';

class StaffRequest {
  final String? id;
  final String? name;
  final String? address;
  final String? phone;
  final bool? status;
  final String? birthday;
  final String? email;
  final String? userId;
  final String? clinicId;

  StaffRequest({
    required this.name,
    required this.address,
    required this.phone,
    required this.status,
    required this.birthday,
    required this.email,
    required this.id,
    required this.userId,
    this.clinicId,
  });

  StaffRequest copyWith({
    String? id,
    String? name,
    String? address,
    String? phone,
    bool? status,
    String? birthday,
    String? email,
    String? userId,
    String? clinicId,
  }) {
    return StaffRequest(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      birthday: birthday ?? this.birthday,
      email: email ?? this.email,
      userId: userId ?? this.userId,
      clinicId: clinicId ?? this.clinicId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'employeeId': id});
    }
    if (name != null) {
      result.addAll({'employeeName': name});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (phone != null) {
      result.addAll({'phoneNumber': phone});
    }
    if (status != null) {
      result.addAll({'employeeStatus': status});
    }
    if (birthday != null) {
      result.addAll({'birthday': birthday});
    }
    if (email != null) {
      result.addAll({'email': email});
    }

    result.addAll({'userId': userId});

    result.addAll({'clinicId': clinicId});

    return result;
  }

  factory StaffRequest.fromMap(Map<String, dynamic> map) {
    return StaffRequest(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      phone: map['phone'],
      status: map['status'],
      birthday: map['birthday'],
      email: map['email'],
      userId: map['userId'],
      clinicId: map['clinicId'],
    );
  }

  factory StaffRequest.fromResponse(StaffResponse response) {
    return StaffRequest(
      id: response.id,
      name: response.name,
      address: response.address,
      phone: response.phone,
      status: response.status,
      birthday: response.birthday,
      email: response.email,
      userId: response.userId,
      clinicId: response.clinicId,
    );
  }

  String toJson() => json.encode(toMap());

  factory StaffRequest.fromJson(String source) =>
      StaffRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StaffRequest(id: $id, name: $name, address: $address, phone: $phone, status: $status, birthday: $birthday, email: $email, userId: $userId, clinicId: $clinicId)';
  }
}
