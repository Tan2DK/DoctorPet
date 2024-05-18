import 'dart:convert';

class ClinicResponse {
  final String? clinicId;
  final String? clinicName;
  final String? address;
  final String? clinicPhoneNumber;
  final String? email;
  ClinicResponse({
    this.clinicId,
    this.clinicName,
    this.address,
    this.clinicPhoneNumber,
    this.email,
  });

  ClinicResponse copyWith({
    String? clinicId,
    String? clinicName,
    String? address,
    String? clinicPhoneNumber,
    String? email,
  }) {
    return ClinicResponse(
      clinicId: clinicId ?? this.clinicId,
      clinicName: clinicName ?? this.clinicName,
      address: address ?? this.address,
      clinicPhoneNumber: clinicPhoneNumber ?? this.clinicPhoneNumber,
      email: email ?? this.email,
    );
  }

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
    if (email != null) {
      result.addAll({'email': email});
    }

    return result;
  }

  factory ClinicResponse.fromMap(Map<String, dynamic> map) {
    return ClinicResponse(
      clinicId: map['clinicId'],
      clinicName: map['clinicName'],
      address: map['address'],
      clinicPhoneNumber: map['clinicPhoneNumber'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClinicResponse.fromJson(String source) =>
      ClinicResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClinicResponse(clinicId: $clinicId, clinicName: $clinicName, address: $address, clinicPhoneNumber: $clinicPhoneNumber, email: $email)';
  }
}
