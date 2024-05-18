import 'package:dartz/dartz.dart';
import 'package:doctor_pet/core/data/clinic_model.dart';
import 'package:doctor_pet/core/data/response/get_clinic_response.dart';

import '../data/request/manage_clinic_request.dart';

abstract class ClinicRepo {
  Future<Either<String, List<ClinicModel>>> getClinic();
  Future<Either<String, GetClinicsResponse?>> getClinicPagination({
    required int limit,
    required int offset,
  });
  Future<Either<String, String>> createClinic({
    required ManageClinicRequest manageClinicRequest,
  });
  Future<Either<String, String>> editClinic({
    required ManageClinicRequest manageClinicRequest,
  });
  Future<Either<String, String>> deleteClinic({required String id});
}
