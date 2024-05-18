import 'dart:convert';
import 'dart:developer';
import 'package:doctor_pet/core/data/response/medicine_category_response.dart';
import 'package:doctor_pet/utils/app_config.dart';
import 'package:doctor_pet/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import '../../../utils/api_endpoint.dart';
import '../../../utils/app_routes.dart';
import '../../data/request/medicine_category_request.dart';

import '../../repos/local_auth_repo.dart';
import '../../repos/medicine_category_repo.dart';

class MedicineCategoryRepoImpl implements MedicineCategoryRepo {
  final String apiBaseUrl = Get.find<AppEnvironment>().apiBaseUrl;
  final localAuthRepo = Get.find<LocalAuthRepo>();

  @override
  Future<Either<String, String>> createMedicineCategory(
      {required MedicineCategoryRequest medicineCategoryRequest}) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.post(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.createMedicineCategory}',
        ),
        body: medicineCategoryRequest.toJson(),
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
  Future<Either<String, List<MedicineCategoryResponse>?>>
      getMedicineCategory() async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.get(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.getMedicineCategory}',
        ),
      );
      switch (response.statusCode) {
         case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          final medicineCategories = json
              .decode(response.body)
              .map((e) => MedicineCategoryResponse.fromMap(e))
              .cast<MedicineCategoryResponse>()
              .toList();
          return Right(medicineCategories);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> editMedicineCategory(
      {required MedicineCategoryRequest medicineCategoryRequest}) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.put(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.editMedicineCategory}',
        ),
        body: medicineCategoryRequest.toJson(),
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
  Future<Either<String, String>> deleteMedicineCategory(
      {required String medicineCategoryId}) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.delete(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.deleteMedicineCategory}$medicineCategoryId',
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
