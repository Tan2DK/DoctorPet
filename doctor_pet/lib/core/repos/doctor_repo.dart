import 'package:dartz/dartz.dart';
import 'package:doctor_pet/core/data/response/get_doctors_response.dart';
import '../data/request/doctor_request.dart';
import '../data/response/doctor_response.dart';

abstract class DoctorRepo {
  Future<Either<String, List<DoctorResponse>?>> getAvailableDoctors({
    required String appointmentId,
  });
  Future<Either<String, String>> createDoctor({
    required DoctorRequest doctorRequest,
  });
  Future<Either<String, GetDoctorsResponse?>> getDoctors({
    required int limit,
    required int offset,
  });
  Future<Either<String, String>> editDoctor({
    required DoctorRequest doctorRequest,
  });
  Future<Either<String, String>> deleteDoctor({
    required String doctorId,
  });
  Future<Either<String, GetDoctorsResponse?>> getDashboardDoctors({
    required int limit,
    required int offset,
    String? clinicId,
  });
}
