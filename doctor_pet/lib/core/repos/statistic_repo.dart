import 'package:dartz/dartz.dart';
import '../data/response/get_appointment_statistics_response.dart';


abstract class StatisticRepo {
  Future<Either<String, GetAppointmentStatisticsResponse?>> appointmentStatistics({
    required String startDate,
    required String endDate,
    required String? clinicId,
  });

  Future<Either<String, String>> moneyStatistics({
    required String startDate,
    required String endDate,
    required String? clinicId,
  });
  
}