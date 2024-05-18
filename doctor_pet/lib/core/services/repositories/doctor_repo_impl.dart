import 'dart:convert';
import 'dart:developer';
import 'package:doctor_pet/core/data/response/doctor_response.dart';
import 'package:doctor_pet/core/data/response/get_doctors_response.dart';
import 'package:doctor_pet/utils/app_config.dart';
import 'package:doctor_pet/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import '../../../utils/api_endpoint.dart';
import '../../../utils/app_routes.dart';
import '../../data/request/doctor_request.dart';
import '../../repos/doctor_repo.dart';
import '../../repos/local_auth_repo.dart';

class DoctorRepoImpl implements DoctorRepo {
  final String apiBaseUrl = Get.find<AppEnvironment>().apiBaseUrl;
  final localAuthRepo = Get.find<LocalAuthRepo>();

  @override
  Future<Either<String, List<DoctorResponse>?>> getAvailableDoctors({
    required String appointmentId,
  }) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.get(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.getAvailableDoctors}$appointmentId',
        ),
      );
      switch (response.statusCode) {
        case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          var body = json.decode(response.body);
          final doctors = body
              .map((e) => DoctorResponse.fromMap(e))
              .cast<DoctorResponse>()
              .toList();
          return Right(doctors);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> createDoctor(
      {required DoctorRequest doctorRequest}) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.post(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.createDoctor}',
        ),
        body: doctorRequest.toJson(),
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
  Future<Either<String, String>> deleteDoctor(
      {required String doctorId}) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.delete(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.deleteDoctor}$doctorId',
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

  @override
  Future<Either<String, String>> editDoctor(
      {required DoctorRequest doctorRequest}) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.put(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.editDoctor}',
        ),
        body: doctorRequest.toJson(),
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
  Future<Either<String, GetDoctorsResponse?>> getDoctors(
      {required int limit, required int offset}) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.get(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.getDoctor}?limit=$limit&offset=$offset',
        ),
      );
      switch (response.statusCode) {
        case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          final getDoctorsResponse = GetDoctorsResponse.fromJson(response.body);
          return Right(getDoctorsResponse);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, GetDoctorsResponse?>> getDashboardDoctors(
      {required int limit, required int offset, String? clinicId}) async {
    try {
      final clinicParam = clinicId != null ? '&clinicId=$clinicId' : '';
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.get(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.getDashboardDoctors}?limit=$limit&offset=$offset$clinicParam',
        ),
      );
      switch (response.statusCode) {
        case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          final getDoctorsResponse = GetDoctorsResponse.fromJson(response.body);
          return Right(getDoctorsResponse);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }
}
