import 'dart:convert';

import 'package:doctor_pet/core/data/response/appointment_response.dart';

class GetAppointmentsResponse {
  final int? total;
  final List<AppointmentResponse>? appointments;
  GetAppointmentsResponse({
    this.total,
    this.appointments,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (total != null) {
      result.addAll({'total': total});
    }
    if (appointments != null) {
      result.addAll(
          {'appointments': appointments!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory GetAppointmentsResponse.fromMap(Map<String, dynamic> map) {
    return GetAppointmentsResponse(
      total: map['total'],
      appointments: map['appointmentDTOs'] != null
          ? List<AppointmentResponse>.from(
              map['appointmentDTOs']
                  ?.map((x) => AppointmentResponse.fromMap(x))
                  .cast<AppointmentResponse>(),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAppointmentsResponse.fromJson(String source) =>
      GetAppointmentsResponse.fromMap(json.decode(source));

  GetAppointmentsResponse copyWith({
    int? total,
    List<AppointmentResponse>? appointments,
  }) {
    return GetAppointmentsResponse(
      total: total ?? this.total,
      appointments: appointments ?? this.appointments,
    );
  }

  @override
  String toString() =>
      'GetAppointmentsResponse(total: $total, appointments: $appointments)';
}
