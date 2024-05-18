import 'dart:convert';

import 'package:equatable/equatable.dart';

class DoctorResponse extends Equatable {
  final String? doctorId;
  final String? doctorName;
  final String? address;
  final String? phoneNumber;
  final String? specialized;
  final bool? doctorStatus;
  final String? degreeId;
  final String? email;
  final String? userId;
  final String? birthday;
  final String? clinicId;
  const DoctorResponse({
    this.doctorId,
    this.doctorName,
    this.address,
    this.phoneNumber,
    this.specialized,
    this.doctorStatus,
    this.email,
    this.degreeId,
    this.birthday,
    this.userId,
    this.clinicId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (doctorId != null) {
      result.addAll({'doctorId': doctorId});
    }
    if (doctorName != null) {
      result.addAll({'doctorName': doctorName});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (phoneNumber != null) {
      result.addAll({'phoneNumber': phoneNumber});
    }
    if (specialized != null) {
      result.addAll({'specialized': specialized});
    }
    if (doctorStatus != null) {
      result.addAll({'doctorStatus': doctorStatus});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (degreeId != null) {
      result.addAll({'degreeId': degreeId});
    }
    if (birthday != null) {
      result.addAll({'birthDate': birthday});
    }
    if (clinicId != null) {
      result.addAll({'clinicId': clinicId});
    }
    result.addAll({'userId': userId});

    return result;
  }

  Map<String, dynamic> toEmptyMapForSelection() {
    final result = <String, dynamic>{};

    result.addAll({'Name:': doctorName ?? ''});

    result.addAll({'Address:': address ?? ''});

    result.addAll({'Phone Number:': phoneNumber ?? ''});

    result.addAll({'Specialized:': specialized ?? ''});

    result.addAll({'Email': email ?? ''});

    result.addAll({'Degree': degreeId ?? ''});

    result.addAll({'Birthday': birthday ?? ''});

    return result;
  }

  factory DoctorResponse.fromMap(Map<String, dynamic> map) {
    return DoctorResponse(
      doctorId: map['doctorId'],
      doctorName: map['doctorName'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
      specialized: map['specialized'],
      doctorStatus: map['doctorStatus'],
      degreeId: map['degreeId'],
      email: map['email'],
      birthday: map['birthDate'],
      userId: map['userId'],
      clinicId: map['clinicId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorResponse.fromJson(String source) =>
      DoctorResponse.fromMap(json.decode(source));

  DoctorResponse copyWith({
    String? doctorId,
    String? doctorName,
    String? address,
    String? phoneNumber,
    String? specialized,
    String? degreeId,
    String? email,
    String? userId,
    String? birthday,
    bool? doctorStatus,
    String? clinicId,
  }) {
    return DoctorResponse(
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      specialized: specialized ?? this.specialized,
      doctorStatus: doctorStatus ?? this.doctorStatus,
      degreeId: degreeId ?? this.degreeId,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      userId: userId ?? this.userId,
      clinicId: clinicId ?? this.clinicId,
    );
  }

  @override
  String toString() {
    return 'DoctorResponse(doctorId: $doctorId, doctorName: $doctorName, address: $address, phoneNumber: $phoneNumber, specialized: $specialized, doctorStatus: $doctorStatus, degreeId: $degreeId, email: $email, userId: $userId, birthday: $birthday, clinicId: $clinicId)';
  }

  String toDataTable() {
    return 'Name: $doctorName\nAddress: $address\nPhone: $phoneNumber\nSpecialized: $specialized';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DoctorResponse &&
        other.doctorId == doctorId &&
        other.doctorName == doctorName &&
        other.address == address &&
        other.phoneNumber == phoneNumber &&
        other.specialized == specialized &&
        other.degreeId == degreeId &&
        other.email == email &&
        other.birthday == birthday &&
        other.userId == userId &&
        other.clinicId == clinicId &&
        other.doctorStatus == doctorStatus;
  }

  @override
  int get hashCode {
    return doctorId.hashCode ^
        doctorName.hashCode ^
        address.hashCode ^
        phoneNumber.hashCode ^
        specialized.hashCode ^
        email.hashCode ^
        degreeId.hashCode ^
        birthday.hashCode ^
        userId.hashCode ^
        clinicId.hashCode ^
        doctorStatus.hashCode;
  }

  @override
  List<Object?> get props => [
        doctorId,
        doctorName,
        address,
        phoneNumber,
        specialized,
        doctorStatus,
        degreeId,
        email,
        birthday,
        userId,
        clinicId,
      ];
}
