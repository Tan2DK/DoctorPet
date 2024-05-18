import 'dart:convert';
import 'package:doctor_pet/core/data/response/pet_category_response.dart';

class GetPetCategoryByClinicResponse {
  final String? clinicId;
  final List<PetCategoryResponse>? petTypeList;
  GetPetCategoryByClinicResponse({
    this.clinicId,
    this.petTypeList,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (clinicId != null) {
      result.addAll({'clinicId': clinicId});
    }
    if (petTypeList != null) {
      result
          .addAll({'petTypeList': petTypeList!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory GetPetCategoryByClinicResponse.fromMap(Map<String, dynamic> map) {
    return GetPetCategoryByClinicResponse(
      clinicId: map['clinicId'],
      petTypeList: map['petTypeList'] != null
          ? List<PetCategoryResponse>.from(
              map['petTypeList']
                  ?.map((x) => PetCategoryResponse.fromMap(x))
                  .cast<PetCategoryResponse>(),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetPetCategoryByClinicResponse.fromJson(String source) =>
      GetPetCategoryByClinicResponse.fromMap(json.decode(source));

  GetPetCategoryByClinicResponse copyWith({
    String? clinicId,
    List<PetCategoryResponse>? petTypeList,
  }) {
    return GetPetCategoryByClinicResponse(
      clinicId: clinicId ?? this.clinicId,
      petTypeList: petTypeList ?? this.petTypeList,
    );
  }

  @override
  String toString() =>
      'GetPetCategoryByClinicResponse(clinicId: $clinicId, petTypeList: $petTypeList)';
}
