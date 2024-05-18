import 'dart:convert';
import 'package:doctor_pet/core/data/response/pet_response.dart';

class GetPetResponse {
  final int? petTotal;
  final List<PetResponse>? petLists;
  GetPetResponse({
    this.petTotal,
    this.petLists,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (petTotal != null) {
      result.addAll({'petTotal': petTotal});
    }
    if (petLists != null) {
      result.addAll({'petLists': petLists!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory GetPetResponse.fromMap(Map<String, dynamic> map) {
    return GetPetResponse(
      petTotal: map['petTotal'],
      petLists: map['petLists'] != null
          ? List<PetResponse>.from(
              map['petLists']
                  ?.map((x) => PetResponse.fromMap(x))
                  .cast<PetResponse>(),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetPetResponse.fromJson(String source) =>
      GetPetResponse.fromMap(json.decode(source));

  GetPetResponse copyWith({
    int? petTotal,
    List<PetResponse>? petLists,
  }) {
    return GetPetResponse(
      petTotal: petTotal ?? this.petTotal,
      petLists: petLists ?? this.petLists,
    );
  }

  @override
  String toString() =>
      'GetClinicsResponse(petTotal: $petTotal, petLists: $petLists)';
}
