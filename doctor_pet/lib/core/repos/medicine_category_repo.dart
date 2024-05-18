import 'package:dartz/dartz.dart';

import '../data/request/medicine_category_request.dart';
import '../data/response/medicine_category_response.dart';

abstract class MedicineCategoryRepo {
  Future<Either<String, String>> createMedicineCategory({
    required MedicineCategoryRequest medicineCategoryRequest,
  });
  Future<Either<String, List<MedicineCategoryResponse>?>> getMedicineCategory();
  Future<Either<String, String>> editMedicineCategory({
    required MedicineCategoryRequest medicineCategoryRequest,
  });
  Future<Either<String, String>> deleteMedicineCategory({
    required String medicineCategoryId,
  });
}
