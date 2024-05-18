import 'dart:convert';

class AssignDoctorAppointmentRequest {
  final String doctorId;
  final String appointmentId;

  AssignDoctorAppointmentRequest({
    required this.doctorId,
    required this.appointmentId,
  });

  String toUrlParameter() => 'appointmentId=$appointmentId&doctorId=$doctorId';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'doctorId': doctorId});
    result.addAll({'appointmentId': appointmentId});

    return result;
  }

  factory AssignDoctorAppointmentRequest.fromMap(Map<String, dynamic> map) {
    return AssignDoctorAppointmentRequest(
      doctorId: map['doctorId'] ?? '',
      appointmentId: map['appointmentId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignDoctorAppointmentRequest.fromJson(String source) =>
      AssignDoctorAppointmentRequest.fromMap(json.decode(source));
}
