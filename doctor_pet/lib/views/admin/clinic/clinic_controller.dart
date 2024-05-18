import 'package:doctor_pet/core/data/request/manage_clinic_request.dart';
import 'package:doctor_pet/core/data/response/manage_clinic_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/repos/clinic_repo.dart';
import 'package:doctor_pet/views/admin/clinic/widgets/delete_clinic_dialog.dart';
import 'package:doctor_pet/views/admin/clinic/widgets/edit_clinic_dialog.dart';

import '../../../utils/app_helper.dart';

class ClinicController extends GetxController {
  Rx<List<ManageClinicResponse>> clinicList =
      Rx<List<ManageClinicResponse>>([]);
  final ClinicRepo clinicRepo;
  final int limit = 10;
  int offset = 0;

  ClinicController({
    required this.clinicRepo,
  });

  Future<DateTime?> selectDate(BuildContext context, DateTime date) async {
    return await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
  }

  Future<void> deleteClinic(String id) async {
    EasyLoading.show();
    final response = await clinicRepo.deleteClinic(id: id);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Delete clinic', l),
      (r) async {
        await fetchClinics();
        Get.back();
        Get.snackbar(
          'Delete clinic',
          'Delete clinic Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void showDeleteDialog(String id) {
    Get.dialog(DeleteClinicDialog(
      deleteClinic: () => deleteClinic(id),
    ));
  }

  void showAddEditDialog(BuildContext context, ManageClinicResponse? response) {
    Get.dialog(
      EditClinicDialog(
        selectDate: selectDate,
        addEditClinic: addEditClinic,
        clinic: response == null
            ? null
            : ManageClinicRequest.fromResponse(response),
      ),
    );
  }

  void addEditClinic(ManageClinicRequest clinic) {
    if ((clinic.clinicName?.isEmpty ?? true) ||
        (clinic.address?.isEmpty ?? true) ||
        (clinic.clinicPhoneNumber?.isEmpty ?? true) ||
        (clinic.latitude?.isEmpty ?? true) ||
        (clinic.longitude?.isEmpty ?? true) ||
        (clinic.staff?.address?.isEmpty ?? true) ||
        (clinic.staff?.employeeName?.isEmpty ?? true) ||
        (clinic.staff?.birthday?.isEmpty ?? true) ||
        (clinic.staff?.phoneNumber?.isEmpty ?? true)) {
      return;
    }
    if (clinic.clinicId?.isEmpty ?? true) {
      createClinic(clinic);
    } else {
      updateClinic(clinic);
    }
    Get.back();
  }

  Future<void> createClinic(ManageClinicRequest request) async {
    EasyLoading.show();
    final response =
        await clinicRepo.createClinic(manageClinicRequest: request);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Create Clinic', l),
      (r) {
        Get.snackbar(
          'Create Clinic',
          'Create Clinic Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchClinics();
      },
    );
  }

  Future<void> updateClinic(ManageClinicRequest request) async {
    EasyLoading.show();
    final response = await clinicRepo.editClinic(manageClinicRequest: request);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Update Clinic', l),
      (r) {
        Get.snackbar(
          'Update Clinic',
          'Update Clinic Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchClinics();
      },
    );
  }

  Future<void> fetchClinics() async {
    EasyLoading.show();
    final response = await clinicRepo.getClinicPagination(
      limit: limit,
      offset: offset,
    );
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Get Clinic', l),
      (r) => clinicList.value = r?.clinics ?? [],
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchClinics();
  }
}
