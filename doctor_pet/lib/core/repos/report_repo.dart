import 'package:dartz/dartz.dart';
import '../data/response/get_medicine_report_response.dart';

abstract class ReportRepo {
  Future<Either<String, GetMedicineReportResponse?>> getMedicineReport({
    String? startDate,
    String? endDate,
  });
  Future<Either<String, GetMedicineReportResponse?>> getMedicineReportByClinic({
    String? startDate,
    String? endDate,
    String? clinicId,
  });
}
