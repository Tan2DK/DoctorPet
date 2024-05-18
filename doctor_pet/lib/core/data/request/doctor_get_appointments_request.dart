import 'dart:convert';

class DoctorGetAppointmentsRequest {
  final String doctorId;
  final String date;
  DoctorGetAppointmentsRequest({
    required this.doctorId,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'doctorId': doctorId});
    result.addAll({'date': date});

    return result;
  }

  factory DoctorGetAppointmentsRequest.fromMap(Map<String, dynamic> map) {
    return DoctorGetAppointmentsRequest(
      doctorId: map['doctorId'] ?? '',
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorGetAppointmentsRequest.fromJson(String source) =>
      DoctorGetAppointmentsRequest.fromMap(json.decode(source));

  String toUrlParameter() => '&doctorId=$doctorId&date=$date';
}
