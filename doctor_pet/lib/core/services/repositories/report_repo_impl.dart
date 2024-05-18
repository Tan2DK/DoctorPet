import 'dart:developer';
import 'package:doctor_pet/core/data/response/get_medicine_report_response.dart';
import 'package:doctor_pet/utils/app_config.dart';
import 'package:doctor_pet/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import '../../../utils/api_endpoint.dart';
import '../../../utils/app_routes.dart';
import '../../repos/local_auth_repo.dart';
import '../../repos/report_repo.dart';

class ReportRepoImpl implements ReportRepo {
  final String apiBaseUrl = Get.find<AppEnvironment>().apiBaseUrl;
  final localAuthRepo = Get.find<LocalAuthRepo>();

  @override
  Future<Either<String, GetMedicineReportResponse?>> getMedicineReport({
    String? startDate,
    String? endDate,
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
          '$apiBaseUrl${ApiEndpointConstant.medicineReport}?startDate=$startDate&endDate=$endDate',
        ),
      );
      switch (response.statusCode) {
        case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          final getMedicineReports =
              GetMedicineReportResponse.fromJson(response.body);
          return Right(getMedicineReports);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, GetMedicineReportResponse?>> getMedicineReportByClinic({
    String? startDate,
    String? endDate,
    String? clinicId,
  }) async {
    try {
      final parameter =
          (clinicId?.isEmpty ?? true) ? '' : '&clinicId=$clinicId';
      var headers = AppHeaderApiConstant.baseHeader;
      final tokenHeader = await localAuthRepo.getAuthorHeader();
      if ((tokenHeader) != null) {
        headers.addAll(tokenHeader);
      }
      final response = await http.get(
        headers: headers,
        Uri.parse(
          '$apiBaseUrl${ApiEndpointConstant.medicineReportByClinic}?startDate=$startDate&endDate=$endDate$parameter',
        ),
      );
      switch (response.statusCode) {
        case ResponseStatusCode.unauthorized:
          Get.offAllNamed(RoutesName.login);
          await localAuthRepo.handleUnAuthorized();
          return Left(response.body);
        case ResponseStatusCode.ok:
          final getMedicineReports =
              GetMedicineReportResponse.fromJson(response.body);
          return Right(getMedicineReports);
        default:
          return Left(response.body);
      }
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }
}
