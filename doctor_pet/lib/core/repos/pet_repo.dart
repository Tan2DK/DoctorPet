import 'package:dartz/dartz.dart';

import '../data/request/pet_request.dart';
import '../data/response/get_pet_response.dart';
import '../data/response/pet_response.dart';

abstract class PetRepo {
  Future<Either<String, String>> createPet({
    required PetRequest petRequest,
  });
  Future<Either<String, GetPetResponse?>> getPet();
  Future<Either<String, String>> editPet({
    required PetRequest petRequest,
  });
  Future<Either<String, String>> deletePet({
    required String petId,
  });
  Future<Either<String, List<PetResponse>?>> getPetByClinic({String? clinicId});
}
