import 'package:dartz/dartz.dart';

import '../data/request/medicine_request.dart';
import '../data/response/get_medicines_response.dart';

abstract class MedicineRepo {
  Future<Either<String, String>> createMedicine({
    required MedicineRequest medicineRequest,
  });
  Future<Either<String, GetMedicinesResponse?>> getMedicine({
    required int limit,
    required int offset,
  });

  Future<Either<String, GetMedicinesResponse?>> searchMedicine({
    required int limit,
    required int offset,
    required String clinicId,
    required String medicineCategoryId,
    required String keyword,
  });
  Future<Either<String, String>> editMedicine(
      {required MedicineRequest medicineRequest});
  Future<Either<String, String>> deleteMedicine({
    required String medicineId,
  });
}
