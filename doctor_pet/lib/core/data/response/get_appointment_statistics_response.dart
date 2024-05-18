import 'dart:convert';

import 'appointment_statistic_response.dart';

class GetAppointmentStatisticsResponse {
  final int? totalAppointment;
  final List<AppointmentStatisticResponse>? appointmentStatistics;
  GetAppointmentStatisticsResponse({
    this.totalAppointment,
    this.appointmentStatistics,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (totalAppointment != null) {
      result.addAll({'totalAppointment': totalAppointment});
    }
    if (appointmentStatistics != null) {
      result.addAll({
        'appointmentStatistics':
            appointmentStatistics!.map((x) => x.toMap()).toList()
      });
    }

    return result;
  }

  factory GetAppointmentStatisticsResponse.fromMap(Map<String, dynamic> map) {
    return GetAppointmentStatisticsResponse(
      totalAppointment: map['totalAppointment'],
      appointmentStatistics: map['appointmentStatistics'] != null
          ? List<AppointmentStatisticResponse>.from(
              map['appointmentStatistics']
                  ?.map((x) => AppointmentStatisticResponse.fromMap(x))
                  .cast<AppointmentStatisticResponse>(),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAppointmentStatisticsResponse.fromJson(String source) =>
      GetAppointmentStatisticsResponse.fromMap(json.decode(source));

  GetAppointmentStatisticsResponse copyWith({
    int? totalAppointment,
    List<AppointmentStatisticResponse>? appointmentStatistics,
  }) {
    return GetAppointmentStatisticsResponse(
      totalAppointment: totalAppointment ?? this.totalAppointment,
      appointmentStatistics:
          appointmentStatistics ?? this.appointmentStatistics,
    );
  }

  @override
  String toString() =>
      'GetAppointmentStatisticsResponse(appointmentStatistics: $appointmentStatistics)';
}
