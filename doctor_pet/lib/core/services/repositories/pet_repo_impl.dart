import 'dart:convert';
import 'dart:developer';
import 'package:doctor_pet/core/data/response/pet_response.dart';
import 'package:doctor_pet/utils/app_config.dart';
import 'package:doctor_pet/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import '../../../utils/api_endpoint.dart';

import '../../../utils/app_routes.dart';
import '../../data/request/pet_request.dart';
import '../../data/response/get_pet_response.dart';
import '../../repos/local_auth_repo.dart';
import '../../repos/pet_repo.dart';

class PetRepoImpl implements PetRepo {
  final String apiBaseUrl = Get.find<AppEnvironment>().apiBaseUrl;
  final localAuthRepo = Get.find<LocalAuthRepo>();

  @override
  Future<Either<String, String>> createPet(
      {required PetRequest petRequest}) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.post(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.createPet}',
        ),
        body: petRequest.toJson(),
      );
      switch (response.statusCode) {
         case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          return Right(response.body);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, GetPetResponse?>> getPet() async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.get(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.getPet}',
        ),
      );
      switch (response.statusCode) {
         case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          final getPetResponse = GetPetResponse.fromJson(response.body);
          return Right(getPetResponse);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<PetResponse>?>> getPetByClinic(
      {String? clinicId}) async {
    try {
      String parameter = (clinicId?.isEmpty ?? true) ? '' : '$clinicId';
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.get(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.getPetByUserClinic}$parameter',
        ),
      );
      switch (response.statusCode) {
         case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          final pets = json
              .decode(response.body)
              .map((e) => PetResponse.fromMap(e))
              .cast<PetResponse>()
              .toList();
          return Right(pets);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> editPet(
      {required PetRequest petRequest}) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.put(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.editPet}',
        ),
        body: petRequest.toJson(),
      );
      switch (response.statusCode) {
         case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          return Right(response.body);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deletePet({required String petId}) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.delete(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.deletePet}$petId',
        ),
      );
      switch (response.statusCode) {
         case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          return Right(response.body);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }
}
