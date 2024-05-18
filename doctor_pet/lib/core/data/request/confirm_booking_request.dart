import 'dart:convert';

class ConfirmBookingRequest {
  final String doctorId;
  final String appointmentId;
  ConfirmBookingRequest({
    required this.doctorId,
    required this.appointmentId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'doctorId': doctorId});
    result.addAll({'appointmentId': appointmentId});
  
    return result;
  }

  factory ConfirmBookingRequest.fromMap(Map<String, dynamic> map) {
    return ConfirmBookingRequest(
      doctorId: map['doctorId'] ?? '',
      appointmentId: map['appointmentId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfirmBookingRequest.fromJson(String source) => ConfirmBookingRequest.fromMap(json.decode(source));

  @override
  String toString() => 'ConfirmBookingRequest(doctorId: $doctorId, appointmentId: $appointmentId)';
}
