import 'dart:convert';
import 'pet_category_request.dart';

class UpdatePetCategoryByClinicRequest {
  final String? clinicId;
  final List<PetCategoryRequest>? petTypeList;
  UpdatePetCategoryByClinicRequest({
    this.clinicId,
    this.petTypeList,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (clinicId != null) {
      result.addAll({'clinicId': clinicId});
    }
    if (petTypeList != null) {
      result.addAll({'petTypeList': petTypeList!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory UpdatePetCategoryByClinicRequest.fromMap(Map<String, dynamic> map) {
    return UpdatePetCategoryByClinicRequest(
      clinicId: map['clinicId'],
      petTypeList: map['petTypeList'] != null
          ? List<PetCategoryRequest>.from(
              map['petTypeList']
                  ?.map((x) => PetCategoryRequest.fromMap(x))
                  .cast<PetCategoryRequest>(),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdatePetCategoryByClinicRequest.fromJson(String source) =>
      UpdatePetCategoryByClinicRequest.fromMap(json.decode(source));

  UpdatePetCategoryByClinicRequest copyWith({
    String? clinicId,
    List<PetCategoryRequest>? petTypeList,
  }) {
    return UpdatePetCategoryByClinicRequest(
      clinicId: clinicId ?? this.clinicId,
      petTypeList: petTypeList ?? this.petTypeList,
    );
  }

  @override
  String toString() =>
      'UpdatePetCategoryByClinicRequest(clinicId: $clinicId, petTypeList: $petTypeList)';
}
