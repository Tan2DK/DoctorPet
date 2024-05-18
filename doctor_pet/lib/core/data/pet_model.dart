import 'dart:convert';

import '../../utils/app_enum.dart';

class PetModel {
  final String? id;
  final String? name;
  final String? typeId;
  final String? species;
  final int? age;
  final Gender gender;
  final String? color;

  PetModel({
    this.id,
    this.name,
    this.typeId,
    this.species,
    this.age,
    this.gender = Gender.male,
    this.color,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'petName': name});
    }
    if (typeId != null) {
      result.addAll({'petTypeId': typeId});
    }
    if (species != null) {
      result.addAll({'petSpecies': species});
    }
    if (age != null) {
      result.addAll({'petAge': age});
    }
    result.addAll({'petGender': gender == Gender.male});
    if (color != null) {
      result.addAll({'petColor': color});
    }

    return result;
  }

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      id: map['petId'],
      name: map['petName'],
      typeId: map['petTypeId'],
      species: map['petSpecies'],
      age: map['petAge']?.toInt(),
      gender: map['petGender'] ?? true,
      color: map['petColor'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PetModel.fromJson(String source) =>
      PetModel.fromMap(json.decode(source));
}
