import 'dart:convert';

import '../response/manage_clinic_response.dart';
import 'manage_clinic_staff_request.dart';

class ManageClinicRequest {
  final String? clinicId;
  final String? clinicName;
  final String? address;
  final String? clinicPhoneNumber;
  final String? latitude;
  final String? longitude;
  final ManageClinicStaffRequest? staff;
  ManageClinicRequest({
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

  factory ManageClinicRequest.fromMap(Map<String, dynamic> map) {
    return ManageClinicRequest(
      clinicId: map['clinicId'],
      clinicName: map['clinicName'],
      address: map['address'],
      clinicPhoneNumber: map['clinicPhoneNumber'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      staff: map['staff'] != null
          ? ManageClinicStaffRequest.fromMap(map['staff'])
          : null,
    );
  }

  factory ManageClinicRequest.fromResponse(ManageClinicResponse response) {
    return ManageClinicRequest(
      clinicId: response.clinicId,
      clinicName: response.clinicName,
      address: response.address,
      clinicPhoneNumber: response.clinicPhoneNumber,
      latitude: response.latitude,
      longitude: response.longitude,
      staff: response.staff != null
          ? ManageClinicStaffRequest.fromResponse(response.staff!)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ManageClinicRequest.fromJson(String source) =>
      ManageClinicRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateClinicRequest(clinicId: $clinicId, clinicName: $clinicName, address: $address, clinicPhoneNumber: $clinicPhoneNumber, latitude: $latitude, longitude: $longitude, staff: $staff)';
  }

  ManageClinicRequest copyWith({
    String? clinicId,
    String? clinicName,
    String? address,
    String? clinicPhoneNumber,
    String? latitude,
    String? longitude,
    ManageClinicStaffRequest? staff,
  }) {
    return ManageClinicRequest(
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
