import 'dart:convert';

class PetResponse {
  final String? petId;
  final String? petName;
  final String? petTypeId;
  final String? petSpecies;
  final int? petAge;
  final bool? petGender;
  final String? petColor;
  final String? userId;
  PetResponse({
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

  factory PetResponse.fromMap(Map<String, dynamic> map) {
    return PetResponse(
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

  String toJson() => json.encode(toMap());

  factory PetResponse.fromJson(String source) =>
      PetResponse.fromMap(json.decode(source));

  PetResponse copyWith({
    String? petId,
    String? petName,
    String? petTypeId,
    String? petSpecies,
    int? petAge,
    bool? petGender,
    String? petColor,
    String? userId,
  }) {
    return PetResponse(
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
    return 'PetResponse(petId: $petId, petName: $petName, petTypeId: $petTypeId, petSpecies: $petSpecies, petAge: $petAge, petGender: $petGender, petColor: $petColor, customerId: $userId)';
  }
}
