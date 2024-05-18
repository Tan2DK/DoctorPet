import 'dart:convert';
import 'doctor_response.dart';

class GetDoctorsResponse {
  final int? totalDoctor;
  final List<DoctorResponse>? doctors;

  GetDoctorsResponse({
    this.totalDoctor,
    this.doctors,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (totalDoctor != null) {
      result.addAll({'totalDoctor': totalDoctor});
    }
    if (doctors != null) {
      result.addAll({'doctors': doctors!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory GetDoctorsResponse.fromMap(Map<String, dynamic> map) {
    return GetDoctorsResponse(
      totalDoctor: map['totalDoctor'],
      doctors: map['doctors'] != null
          ? List<DoctorResponse>.from(
              map['doctors']
                  ?.map((x) => DoctorResponse.fromMap(x))
                  .cast<DoctorResponse>(),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetDoctorsResponse.fromJson(String source) =>
      GetDoctorsResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetDoctorsResponse(totalDoctor: $totalDoctor, doctors: $doctors)';
}
