import 'package:doctor_pet/core/repos/medicine_category_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:doctor_pet/core/data/request/medicine_request.dart';
import 'package:doctor_pet/core/data/response/medicine_response.dart';
import 'package:doctor_pet/core/repos/medicine_repo.dart';
import 'package:doctor_pet/views/clinic_manager/medicine/widgets/delete_medicine_dialog.dart';
import 'package:doctor_pet/views/clinic_manager/medicine/widgets/edit_medicine_dialog.dart';

import '../../../core/data/response/medicine_category_response.dart';
import '../../../utils/app_helper.dart';

class ClinicMedicineController extends GetxController {
  Rx<List<MedicineResponse>> medicineList = Rx<List<MedicineResponse>>([]);
  Rx<List<MedicineCategoryResponse>> medicineCategoryList =
      Rx<List<MedicineCategoryResponse>>([]);
  final int limit = 10;
  int offset = 0;
  final MedicineRepo medicineRepo;
  final MedicineCategoryRepo medicineCategoryRepo;
  ClinicMedicineController({
    required this.medicineRepo,
    required this.medicineCategoryRepo,
  });

  @override
  void onInit() {
    super.onInit();
    fetchMedicines();
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

  void onAddEditMedicine(MedicineRequest medicine) {
    if ((medicine.medicineName?.isEmpty ?? true) ||
        (medicine.medicineUnit?.isEmpty ?? true) ||
        (medicine.inventory == null) ||
        (medicine.prices == null) ||
        (medicine.medicineCateId == null) ||
        (medicine.specifications?.isEmpty ?? true)) return;
    if (medicine.medicineId?.isEmpty ?? true) {
      createMedicine(medicine);
    } else {
      updateMedicine(medicine);
    }
    Get.back();
  }

  Future<void> onDeleteMedicine(String medicineId) async {
    EasyLoading.show();
    final response = await medicineRepo.deleteMedicine(medicineId: medicineId);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Delete Medicine', l),
      (r) async {
        await fetchMedicines();
        Get.back();
        Get.snackbar(
          'Delete Medicine',
          'Delete Medicine Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void showAddEditMedicineDialog({MedicineResponse? medicine}) {
    Get.dialog(EditMedicineDialog(
      selectDate: selectDate,
      medicine:
          medicine == null ? null : MedicineRequest.fromResponse(medicine),
      medicineCategories: medicineCategoryList.value,
      onAddEditMedicine: onAddEditMedicine,
    ));
  }

  void showDeleteMedicineDialog(String medicineId) {
    Get.dialog(
      DeleteMedicineDialog(
        onDeleteMedicine: () async {
          await onDeleteMedicine(medicineId);
        },
      ),
    );
  }

  Future<void> createMedicine(MedicineRequest request) async {
    EasyLoading.show();
    final response = await medicineRepo.createMedicine(
      medicineRequest: request,
    );
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Create Medicine', l),
      (r) {
        Get.snackbar(
          'Create Medicine',
          'Create Medicine Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchMedicines();
      },
    );
  }

  Future<void> updateMedicine(MedicineRequest request) async {
    EasyLoading.show();
    final response = await medicineRepo.editMedicine(medicineRequest: request);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Update Medicine', l),
      (r) {
        Get.snackbar(
          'Update Medicine',
          'Update Medicine Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchMedicines();
      },
    );
  }

  Future<void> fetchMedicines() async {
    EasyLoading.show();
    final response = await medicineRepo.getMedicine(
      limit: limit,
      offset: offset,
    );
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Get Medicine', l),
      (r) => medicineList.value = r?.medicines ?? [],
    );
  }

  Future<void> fetchMedicineCategories() async {
    EasyLoading.show();
    final response = await medicineCategoryRepo.getMedicineCategory();
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Get Medicine Category', l),
      (r) => medicineCategoryList.value = r ?? [],
    );
  }
}
