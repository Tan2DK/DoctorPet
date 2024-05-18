import 'package:dartz/dartz.dart';
import 'package:doctor_pet/core/data/request/update_pet_category_by_clinic_request.dart';

import '../data/request/pet_category_request.dart';
import '../data/response/get_pet_category_by_clinic_response.dart';
import '../data/response/pet_category_response.dart';

abstract class PetCategoryRepo {
  Future<Either<String, String>> createPetCategory({
    required PetCategoryRequest petCategoryRequest,
  });
  Future<Either<String, List<PetCategoryResponse>?>> getPetCategory();
  Future<Either<String, GetPetCategoryByClinicResponse?>>
      getPetCategoryByClinic({
    String? clinicId,
  });
  Future<Either<String, String?>> updatePetCategoryByClinic({
    required UpdatePetCategoryByClinicRequest updatePetCategoryByClinicRequest,
  });
  Future<Either<String, String>> editPetCategory({
    required PetCategoryRequest petCategoryRequest,
  });
  Future<Either<String, String>> deletePetCategory({
    required String petCategoryId,
  });
}
