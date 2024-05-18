import 'dart:convert';
import 'package:doctor_pet/core/data/response/manage_clinic_response.dart';

class GetClinicsResponse {
  final int? total;
  final List<ManageClinicResponse>? clinics;
  GetClinicsResponse({
    this.total,
    this.clinics,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (total != null) {
      result.addAll({'totalClinic': total});
    }
    if (clinics != null) {
      result.addAll({'clinics': clinics!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory GetClinicsResponse.fromMap(Map<String, dynamic> map) {
    return GetClinicsResponse(
      total: map['totalClinic'],
      clinics: map['clinics'] != null
          ? List<ManageClinicResponse>.from(
              map['clinics']
                  ?.map((x) => ManageClinicResponse.fromMap(x))
                  .cast<ManageClinicResponse>(),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetClinicsResponse.fromJson(String source) =>
      GetClinicsResponse.fromMap(json.decode(source));

  GetClinicsResponse copyWith({
    int? total,
    List<ManageClinicResponse>? clinics,
  }) {
    return GetClinicsResponse(
      total: total ?? this.total,
      clinics: clinics ?? this.clinics,
    );
  }

  @override
  String toString() =>
      'GetClinicsResponse(total: $total, clinics: $clinics)';
}
