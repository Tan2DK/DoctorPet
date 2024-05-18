import 'dart:convert';

import 'package:doctor_pet/utils/app_extension.dart';

class CustomerResponse {
  final String? id;
  final String? name;
  final String? address;
  final String? phone;
  final String? email;
  final DateTime? birthday;
  CustomerResponse({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.birthday,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'fullName': name});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (birthday != null) {
      result.addAll({'birthday': birthday?.formatDateTime('yyyy-MM-dd')});
    }

    return result;
  }

  factory CustomerResponse.fromMap(Map<String, dynamic> map) {
    return CustomerResponse(
      id: map['userId'],
      name: map['fullName'],
      address: map['address'],
      phone: map['phoneNumber'],
      email: map['email'],
      birthday: map['birthday']?.toString().parseDateTime('yyyy-MM-dd'),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerResponse.fromJson(String source) =>
      CustomerResponse.fromMap(json.decode(source));

  CustomerResponse copyWith({
    String? id,
    String? name,
    String? address,
    String? phone,
    String? email,
    DateTime? birthday,
  }) {
    return CustomerResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
    );
  }

  @override
  String toString() {
    return 'CustomerResponse(id: $id, name: $name, address: $address, phone: $phone, email: $email, birthday: $birthday)';
  }

  String toDataTable() {
    return 'Name: $name\nAddress: $address\nPhone: $phone\nEmail: $email\nBirthday: ${birthday?.formatDateTime('dd-MM-yyyy')}';
  }
}
