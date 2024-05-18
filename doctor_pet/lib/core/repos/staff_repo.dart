import 'package:dartz/dartz.dart';
import 'package:doctor_pet/core/data/request/staff_request.dart';

import '../data/response/get_staffs_response.dart';

abstract class StaffRepo {
  Future<Either<String, String>> createStaff({
    required StaffRequest staffRequest,
  });
  Future<Either<String, GetStaffsResponse?>> getStaff({
    required int limit,
    required int offset,
  });
  Future<Either<String, String>> editStaff({
    required StaffRequest staffRequest,
  });
  Future<Either<String, String>> deleteStaff({
    required String staffId,
  });
  Future<Either<String, GetStaffsResponse?>> getDashboardStaff({
    required int limit,
    required int offset,
    String? clinicId,
  });
}
