import 'dart:convert';

import 'package:doctor_pet/core/data/pet_model.dart';

class BookingPetModel {
  final PetModel? pet;
  final String? reason;

  BookingPetModel({this.pet, this.reason});

  BookingPetModel copyWith({
    PetModel? pet,
    String? reason,
  }) {
    return BookingPetModel(
      pet: pet ?? this.pet,
      reason: reason ?? this.reason,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(pet != null){
      result.addAll({'pet': pet!.toMap()});
    }
    if(reason != null){
      result.addAll({'reason': reason});
    }
  
    return result;
  }

  factory BookingPetModel.fromMap(Map<String, dynamic> map) {
    return BookingPetModel(
      pet: map['pet'] != null ? PetModel.fromMap(map['pet']) : null,
      reason: map['reason'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingPetModel.fromJson(String source) => BookingPetModel.fromMap(json.decode(source));
}
