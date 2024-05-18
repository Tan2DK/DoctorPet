import 'dart:developer';
import 'package:doctor_pet/core/data/response/get_appointment_statistics_response.dart';
import 'package:doctor_pet/core/repos/statistic_repo.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import '../../../utils/api_endpoint.dart';
import '../../../utils/app_config.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_routes.dart';
import '../../repos/local_auth_repo.dart';

class StatisticRepoImpl implements StatisticRepo {
  final String apiBaseUrl = Get.find<AppEnvironment>().apiBaseUrl;
  final localAuthRepo = Get.find<LocalAuthRepo>();

  @override
  Future<Either<String, GetAppointmentStatisticsResponse?>>
      appointmentStatistics({
    required String startDate,
    required String endDate,
    required String? clinicId,
  }) async {
    try {
      String parameter =
          (clinicId?.isNotEmpty ?? false) ? '&clinicId=$clinicId' : '';
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.get(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.appointmentStatistics}?start=$startDate&end=$endDate$parameter',
        ),
      );
      switch (response.statusCode) {
        case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          final appointmentStatistics = GetAppointmentStatisticsResponse.fromJson(response.body);
          return Right(appointmentStatistics);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> moneyStatistics({
    required String startDate,
    required String endDate,
    required String? clinicId,
  }) async {
    try {
      String parameter =
          (clinicId?.isNotEmpty ?? false) ? '&clinicId=$clinicId' : '';
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.get(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.moneyStatistic}?start=$startDate&end=$endDate$parameter',
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
