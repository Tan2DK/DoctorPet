import 'dart:convert';

import 'package:doctor_pet/core/data/response/customer_response.dart';
import 'package:doctor_pet/utils/app_extension.dart';

import 'clinic_response.dart';
import 'doctor_response.dart';
import 'pet_response.dart';

class AppointmentResponse {
  final String? appointmentId;
  final DateTime? appointmentDate;
  final String? reason;
  final PetResponse? pet;
  final DoctorResponse? doctor;
  final ClinicResponse? clinic;
  final CustomerResponse? customer;
  final int? slot;
  final String? status;
  AppointmentResponse({
    this.appointmentId,
    this.appointmentDate,
    this.reason,
    this.pet,
    this.doctor,
    this.clinic,
    this.customer,
    this.slot,
    this.status,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (appointmentId != null) {
      result.addAll({'appointmentId': appointmentId});
    }
    if (appointmentDate != null) {
      result.addAll({'appointmentDate': appointmentDate});
    }
    if (reason != null) {
      result.addAll({'reason': reason});
    }
    if (pet != null) {
      result.addAll({'pet': pet!.toMap()});
    }
    if (doctor != null) {
      result.addAll({'doctor': doctor!.toMap()});
    }
    if (clinic != null) {
      result.addAll({'clinic': clinic!.toMap()});
    }
    if (customer != null) {
      result.addAll({'user': customer!.toMap()});
    }
    if (slot != null) {
      result.addAll({'slotNumber': slot});
    }
    if (status != null) {
      result.addAll({'status': status});
    }

    return result;
  }

  factory AppointmentResponse.fromMap(Map<String, dynamic> map) {
    return AppointmentResponse(
      appointmentId: map['appointmentId'],
      appointmentDate:
          map['appointmentDate'].toString().parseDateTime('yyyy-MM-dd'),
      reason: map['reason'],
      pet: map['pet'] != null ? PetResponse.fromMap(map['pet']) : null,
      doctor:
          map['doctor'] != null ? DoctorResponse.fromMap(map['doctor']) : null,
      clinic:
          map['clinic'] != null ? ClinicResponse.fromMap(map['clinic']) : null,
      customer:
          map['user'] != null ? CustomerResponse.fromMap(map['user']) : null,
      slot: map['slotNumber'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentResponse.fromJson(String source) =>
      AppointmentResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppointmentResponse(appointmentId: $appointmentId, appointmentDate: $appointmentDate, reason: $reason, pet: $pet, doctor: $doctor, clinic: $clinic, user: $customer, slot: $slot, status: $status)';
  }

  AppointmentResponse copyWith({
    String? appointmentId,
    DateTime? appointmentDate,
    String? reason,
    PetResponse? pet,
    DoctorResponse? doctor,
    ClinicResponse? clinic,
    CustomerResponse? customer,
    int? slot,
    String? status,
  }) {
    return AppointmentResponse(
      appointmentId: appointmentId ?? this.appointmentId,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      reason: reason ?? this.reason,
      pet: pet ?? this.pet,
      doctor: doctor ?? this.doctor,
      clinic: clinic ?? this.clinic,
      customer: customer ?? this.customer,
      slot: slot ?? this.slot,
      status: status ?? this.status,
    );
  }
}
