import 'dart:convert';

import 'package:doctor_pet/core/data/response/pet_category_response.dart';

class PetCategoryRequest {
  final String? petTypeId;
  final String? petTypeName;

  PetCategoryRequest({
    this.petTypeId,
    this.petTypeName,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (petTypeId != null) {
      result.addAll({'petTypeId': petTypeId});
    }
    if (petTypeName != null) {
      result.addAll({'petTypeName': petTypeName});
    }

    return result;
  }

  factory PetCategoryRequest.fromMap(Map<String, dynamic> map) {
    return PetCategoryRequest(
      petTypeId: map['petTypeId'],
      petTypeName: map['petTypeName'],
    );
  }
  factory PetCategoryRequest.fromResponse(PetCategoryResponse response) {
    return PetCategoryRequest(
      petTypeId: response.petTypeId,
      petTypeName: response.petTypeName,
    );
  }

  String toJson() => json.encode(toMap());

  factory PetCategoryRequest.fromJson(String source) =>
      PetCategoryRequest.fromMap(json.decode(source));

  PetCategoryRequest copyWith({
    String? petTypeId,
    String? petTypeName,
  }) {
    return PetCategoryRequest(
      petTypeId: petTypeId ?? this.petTypeId,
      petTypeName: petTypeName ?? this.petTypeName,
    );
  }

  @override
  String toString() {
    return 'PetCategoryResponse(petTypeId: $petTypeId, petTypeName: $petTypeName)';
  }
}
