import 'dart:convert';

import 'package:doctor_pet/core/data/booking_pet_model.dart';

class CreateBookingRequest {
  final BookingPetModel? bookingPet;
  final String? clinicId;
  final String? petId;
  final String? date;
  final int? slot;
  CreateBookingRequest({
    required this.bookingPet,
    required this.clinicId,
    this.petId,
    this.date,
    this.slot,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (bookingPet?.pet != null) result.addAll({'petDTO': bookingPet?.pet?.toMap()});
    result.addAll({'reason': bookingPet?.reason});
    result.addAll({'clinicId': clinicId});
    if (petId != null) {
      result.addAll({'petId': petId});
    }
    if (date != null) {
      result.addAll({'date': date});
    }
    if (slot != null) {
      result.addAll({'slot': slot});
    }

    return result;
  }

  factory CreateBookingRequest.fromMap(Map<String, dynamic> map) {
    return CreateBookingRequest(
      bookingPet: BookingPetModel.fromMap(map['bookingPet']),
      clinicId: map['clinicId'] ?? '',
      petId: map['petId'],
      date: map['date'],
      slot: map['slot'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateBookingRequest.fromJson(String source) =>
      CreateBookingRequest.fromMap(json.decode(source));
}
