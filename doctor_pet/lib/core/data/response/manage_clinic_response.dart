import 'dart:convert';

import 'manage_clinic_staff_response.dart';

class ManageClinicResponse {
  final String? clinicId;
  final String? clinicName;
  final String? address;
  final String? clinicPhoneNumber;
  final String? latitude;
  final String? longitude;
  final ManageClinicStaffResponse? staff;
  ManageClinicResponse({
    this.clinicId,
    this.clinicName,
    this.address,
    this.clinicPhoneNumber,
    this.latitude,
    this.longitude,
    this.staff,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (clinicId != null) {
      result.addAll({'clinicId': clinicId});
    }
    if (clinicName != null) {
      result.addAll({'clinicName': clinicName});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (clinicPhoneNumber != null) {
      result.addAll({'clinicPhoneNumber': clinicPhoneNumber});
    }
    if (latitude != null) {
      result.addAll({'latitude': latitude});
    }
    if (longitude != null) {
      result.addAll({'longitude': longitude});
    }
    if (staff != null) {
      result.addAll({'staff': staff!.toMap()});
    }

    return result;
  }

  factory ManageClinicResponse.fromMap(Map<String, dynamic> map) {
    return ManageClinicResponse(
      clinicId: map['clinicId'],
      clinicName: map['clinicName'],
      address: map['address'],
      clinicPhoneNumber: map['clinicPhoneNumber'],
      latitude: map['latitude'].toString(),
      longitude: map['longitude'].toString(),
      staff: map['staff'] != null
          ? ManageClinicStaffResponse.fromMap(map['staff'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ManageClinicResponse.fromJson(String source) =>
      ManageClinicResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ManageClinicResponse(clinicId: $clinicId, clinicName: $clinicName, address: $address, clinicPhoneNumber: $clinicPhoneNumber, latitude: $latitude, longitude: $longitude, staff: $staff)';
  }

  ManageClinicResponse copyWith({
    String? clinicId,
    String? clinicName,
    String? address,
    String? clinicPhoneNumber,
    String? latitude,
    String? longitude,
    ManageClinicStaffResponse? staff,
  }) {
    return ManageClinicResponse(
      clinicId: clinicId ?? this.clinicId,
      clinicName: clinicName ?? this.clinicName,
      address: address ?? this.address,
      clinicPhoneNumber: clinicPhoneNumber ?? this.clinicPhoneNumber,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      staff: staff ?? this.staff,
    );
  }
}
