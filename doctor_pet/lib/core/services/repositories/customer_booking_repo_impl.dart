import 'dart:convert';
import 'dart:developer';
import 'package:doctor_pet/core/data/request/create_booking_request.dart';
import 'package:doctor_pet/utils/app_config.dart';
import 'package:doctor_pet/utils/app_constant.dart';
import 'package:doctor_pet/utils/app_extension.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:doctor_pet/core/repos/customer_booking_repo.dart';

import '../../../utils/api_endpoint.dart';
import '../../../utils/app_routes.dart';
import '../../data/response/slots_in_day_response.dart';
import '../../repos/local_auth_repo.dart';

class CustomerBookingRepoImpl implements CustomerBookingRepo {
  final String apiBaseUrl = Get.find<AppEnvironment>().apiBaseUrl;
  final localAuthRepo = Get.find<LocalAuthRepo>();

  @override
  Future<Either<String, List<SlotsInDayResponse>>> getDoctorSlotByClinic({
    required String clinicId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    String start = startDate.formatDateTime('yyyy-MM-dd');
    String end = endDate.formatDateTime('yyyy-MM-dd');
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.get(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.getDoctorSlotByClinic}$clinicId?startDate=$start&endDate=$end',
        ),
      );
      switch (response.statusCode) {
        case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          var body = json.decode(response.body);
          final slots = body
              .map((e) => SlotsInDayResponse.fromMap(e))
              .cast<SlotsInDayResponse>()
              .toList();
          return Right(slots);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> booking(
      {required CreateBookingRequest createBookingRequest}) async {
    try {
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.post(
        headers: headers,
        body: createBookingRequest.toJson(),
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.booking}',
        ),
      );
      switch (response.statusCode) {
        case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          return Right(response.body.toString());
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }
}
