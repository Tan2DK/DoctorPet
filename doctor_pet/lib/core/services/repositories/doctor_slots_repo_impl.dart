import 'dart:convert';
import 'dart:developer';
import '../../../utils/app_routes.dart';
import '../../data/request/doctor_get_slots_request.dart';
import '../../data/request/doctor_slots_request.dart';
import '../../../utils/app_config.dart';
import '../../../utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import '../../../utils/api_endpoint.dart';
import '../../data/response/doctor_slots_response.dart';
import '../../repos/doctor_slots_repo.dart';
import '../../repos/local_auth_repo.dart';

class DoctorSlotsRepoImpl implements DoctorSlotsRepo {
  final String apiBaseUrl = Get.find<AppEnvironment>().apiBaseUrl;
  final localAuthRepo = Get.find<LocalAuthRepo>();

  @override
  Future<Either<String, List<DoctorSlotsResponse>>> getDoctorSlots({
    required DoctorGetSlotsRequest doctorGetSlotsRequest,
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
          '$apiBaseUrl${ApiEndpointConstant.doctorGetSlots}${doctorGetSlotsRequest.toUrlParameter()}',
        ),
      );
      switch (response.statusCode) {
         case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          final body = json.decode(response.body);
          final doctorSlotsResponses = body
              .map<DoctorSlotsResponse>((e) => DoctorSlotsResponse.fromMap(e))
              .cast<DoctorSlotsResponse>()
              .toList();
          return Right(doctorSlotsResponses);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> setDoctorSlots(
      {required List<DoctorSlotsRequest> doctorSlotsRequests}) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.post(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.doctorUpdateSlots}',
        ),
        body: json.encode(doctorSlotsRequests.map((e) => e.toMap()).toList()),
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
