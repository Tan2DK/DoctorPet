import 'dart:convert';

import 'package:equatable/equatable.dart';

class PetCategoryResponse extends Equatable {
  final String? petTypeId;
  final String? petTypeName;

  const PetCategoryResponse({
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

  factory PetCategoryResponse.fromMap(Map<String, dynamic> map) {
    return PetCategoryResponse(
      petTypeId: map['petTypeId'],
      petTypeName: map['petTypeName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PetCategoryResponse.fromJson(String source) =>
      PetCategoryResponse.fromMap(json.decode(source));

  PetCategoryResponse copyWith({
    String? petTypeId,
    String? petTypeName,
  }) {
    return PetCategoryResponse(
      petTypeId: petTypeId ?? this.petTypeId,
      petTypeName: petTypeName ?? this.petTypeName,
    );
  }

  @override
  String toString() {
    return 'PetCategoryResponse(petTypeId: $petTypeId, petTypeName: $petTypeName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PetCategoryResponse &&
        other.petTypeId == petTypeId &&
        other.petTypeName == petTypeName;
  }

  @override
  int get hashCode => petTypeId.hashCode ^ petTypeName.hashCode;

  @override
  List<Object?> get props => [petTypeId, petTypeName];
}
