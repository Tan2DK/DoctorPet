import 'package:doctor_pet/views/admin/medicine_category/widgets/delete_medicine_category_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../core/data/request/medicine_category_request.dart';
import '../../../core/data/response/medicine_category_response.dart';
import '../../../core/repos/medicine_category_repo.dart';
import '../../../utils/app_helper.dart';
import 'widgets/edit_medicine_category_dialog.dart';

class MedicineCategoryController extends GetxController {
  Rx<List<MedicineCategoryResponse>> medicineCategoryList =
      Rx<List<MedicineCategoryResponse>>([]);
  final int limit = 10;
  int offset = 0;
  final MedicineCategoryRepo medicineCategoryRepo;
  MedicineCategoryController({
    required this.medicineCategoryRepo,
  });

  @override
  void onInit() {
    super.onInit();
    fetchMedicineCategories();
  }

  Future<DateTime?> selectDate(
      BuildContext context, DateTime date, bool isLimit) async {
    return await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: isLimit ? DateTime.now() : DateTime(2100),
    );
  }

  void onAddEditMedicineCategory(MedicineCategoryRequest medicineCategory) {
    if (medicineCategory.name?.isEmpty ?? true) return;
    if (medicineCategory.id?.isEmpty ?? true) {
      createMedicineCategory(medicineCategory);
    } else {
      updateMedicineCategory(medicineCategory);
    }
    Get.back();
  }

  Future<void> onDeleteMedicineCategory(String medicineCategoryId) async {
    EasyLoading.show();
    final response = await medicineCategoryRepo.deleteMedicineCategory(
        medicineCategoryId: medicineCategoryId);
    EasyLoading.dismiss();
    Get.back();
    response.fold(
      (l) => AppHelper.showErrorMessage('Delete Medicine Category', l),
      (r) async {
        await fetchMedicineCategories();
        Get.snackbar(
          'Delete Medicine Category',
          'Delete Medicine Category Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void showAddEditMedicineCategoryDialog(
      {MedicineCategoryResponse? medicineCategory}) {
    Get.dialog(EditMedicineCategoryDialog(
      selectDate: selectDate,
      medicineCategory: medicineCategory == null
          ? null
          : MedicineCategoryRequest.fromResponse(medicineCategory),
      onAddEditMedicineCategory: onAddEditMedicineCategory,
    ),);
  }

  void showDeleteMedicineCategoryDialog(String medicineCategoryId) {
    Get.dialog(
      DeleteMedicineCategoryDialog(
        onDeleteMedicineCategory: () async {
          await onDeleteMedicineCategory(medicineCategoryId);
        },
      ),
    );
  }

  Future<void> createMedicineCategory(MedicineCategoryRequest request) async {
    EasyLoading.show();
    final response = await medicineCategoryRepo.createMedicineCategory(
        medicineCategoryRequest: request);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Create Medicine Category', l),
      (r) {
        Get.snackbar(
          'Create Medicine Category',
          'Create Medicine Category Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchMedicineCategories();
      },
    );
  }

  Future<void> updateMedicineCategory(MedicineCategoryRequest request) async {
    EasyLoading.show();
    final response = await medicineCategoryRepo.editMedicineCategory(
        medicineCategoryRequest: request);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Update Medicine Category', l),
      (r) {
        Get.snackbar(
          'Update Medicine Category',
          'Update Medicine Category Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchMedicineCategories();
      },
    );
  }

  Future<void> fetchMedicineCategories() async {
    EasyLoading.show();
    final response = await medicineCategoryRepo.getMedicineCategory();
    EasyLoading.dismiss();

    response.fold((l) => AppHelper.showErrorMessage('Get Medicine Category', l),
        (r) {
      medicineCategoryList.value = r ?? [];
      medicineCategoryList.refresh();
    });
  }
}
