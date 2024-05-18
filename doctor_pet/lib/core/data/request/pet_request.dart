import 'dart:convert';

import 'package:doctor_pet/core/data/response/pet_response.dart';

class PetRequest {
  final String? petId;
  final String? petName;
  final String? petTypeId;
  final String? petSpecies;
  final int? petAge;
  final bool? petGender;
  final String? petColor;
  final String? userId;
  PetRequest({
    this.petId,
    this.petName,
    this.petTypeId,
    this.petSpecies,
    this.petAge,
    this.petGender,
    this.petColor,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (petId != null) {
      result.addAll({'petId': petId});
    }
    if (petName != null) {
      result.addAll({'petName': petName});
    }
    if (petTypeId != null) {
      result.addAll({'petTypeId': petTypeId});
    }
    if (petSpecies != null) {
      result.addAll({'petSpecies': petSpecies});
    }
    if (petAge != null) {
      result.addAll({'petAge': petAge});
    }
    if (petGender != null) {
      result.addAll({'petGender': petGender});
    }
    if (petColor != null) {
      result.addAll({'petColor': petColor});
    }
    if (userId != null) {
      result.addAll({'userId': userId});
    }

    return result;
  }

  factory PetRequest.fromMap(Map<String, dynamic> map) {
    return PetRequest(
      petId: map['petId'],
      petName: map['petName'],
      petTypeId: map['petTypeId'],
      petSpecies: map['petSpecies'],
      petAge: map['petAge'],
      petGender: map['petGender'],
      petColor: map['petColor'],
      userId: map['userId'],
    );
  }

  factory PetRequest.fromResponse(PetResponse response) {
    return PetRequest(
      petId: response.petId,
      petName: response.petName,
      petTypeId: response.petTypeId,
      petSpecies: response.petSpecies,
      petAge: response.petAge,
      petGender: response.petGender,
      petColor: response.petColor,
      userId: response.userId,
    );
  }

  String toJson() => json.encode(toMap());

  factory PetRequest.fromJson(String source) =>
      PetRequest.fromMap(json.decode(source));

  PetRequest copyWith({
    String? petId,
    String? petName,
    String? petTypeId,
    String? petSpecies,
    int? petAge,
    bool? petGender,
    String? petColor,
    String? userId,
  }) {
    return PetRequest(
      petId: petId ?? this.petId,
      petName: petName ?? this.petName,
      petTypeId: petTypeId ?? this.petTypeId,
      petSpecies: petSpecies ?? this.petSpecies,
      petAge: petAge ?? this.petAge,
      petGender: petGender ?? this.petGender,
      petColor: petColor ?? this.petColor,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'PetRequest(petId: $petId, petName: $petName, petTypeId: $petTypeId, petSpecies: $petSpecies, petAge: $petAge, petGender: $petGender, petColor: $petColor, customerId: $userId)';
  }
}
