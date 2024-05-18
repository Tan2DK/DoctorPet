import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserResponse extends Equatable {
  final String? id;
  final String username;
  final String fullname;
  final String email;
  final String address;
  final String phone;
  final String birthday;
  const UserResponse({
    this.id,
    required this.username,
    required this.fullname,
    required this.email,
    required this.address,
    required this.phone,
    required this.birthday,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'userName': username});
    result.addAll({'fullName': fullname});
    result.addAll({'email': email});
    result.addAll({'address': address});
    result.addAll({'phoneNumber': phone});
    result.addAll({'birthday': birthday});

    return result;
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      id: map['id'],
      username: map['userName'] ?? '',
      fullname: map['fullName'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      phone: map['phoneNumber'] ?? '',
      birthday: map['birthday'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) =>
      UserResponse.fromMap(json.decode(source));

  UserResponse copyWith({
    String? id,
    String? username,
    String? fullname,
    String? email,
    String? address,
    String? phone,
    String? birthday,
  }) {
    return UserResponse(
      id: id ?? this.id,
      username: username ?? this.username,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserResponse &&
        other.username == username &&
        other.fullname == fullname &&
        other.email == email &&
        other.address == address &&
        other.phone == phone &&
        other.birthday == birthday;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        fullname.hashCode ^
        email.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        birthday.hashCode;
  }

  @override
  String toString() {
    return 'UserResponse(id: $id, username: $username, fullname: $fullname, email: $email, address: $address, phone: $phone, birthday: $birthday)';
  }

  @override
  List<Object> get props {
    return [
      id ?? '',
      username,
      fullname,
      email,
      address,
      phone,
      birthday,
    ];
  }
}
