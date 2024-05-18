import 'package:doctor_pet/core/data/request/doctor_request.dart';
import 'package:doctor_pet/core/data/response/doctor_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/repos/doctor_repo.dart';
import 'package:doctor_pet/views/clinic_manager/doctor/widgets/edit_doctor_dialog.dart';

import '../../../core/data/response/degree_response.dart';
import '../../../core/repos/degree_repo.dart';
import '../../../utils/app_helper.dart';
import 'widgets/delete_doctor_dialog.dart';

class ClinicDoctorController extends GetxController {
  Rx<List<DoctorResponse>> doctorList = Rx<List<DoctorResponse>>([]);
  Rx<List<DegreeResponse>> degreeList = Rx<List<DegreeResponse>>([]);

  final int limit = 10;
  int offset = 0;

  final DoctorRepo doctorRepo;
  final DegreeRepo degreeRepo;
  ClinicDoctorController({
    required this.doctorRepo,
    required this.degreeRepo,
  });

  @override
  void onInit() {
    super.onInit();
    fetchDegrees();
    fetchDoctors();
  }

  Future<DateTime?> selectDate(
      BuildContext context, DateTime date, bool isLimit) async {
    return await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1),
      lastDate: isLimit ? DateTime.now() : DateTime(2100),
    );
  }

  void showAddEditDialog({DoctorResponse? response}) {
    Get.dialog(EditDoctorDialog(
      addEditDoctor: addEditDoctor,
      doctor: response == null ? null : DoctorRequest.fromResponse(response),
      degrees: degreeList.value,
      selectDate: selectDate,
    ));
  }

  void addEditDoctor(DoctorRequest doctor) {
    if ((doctor.doctorName?.isEmpty ?? true) ||
        (doctor.phoneNumber?.isEmpty ?? true) ||
        (doctor.address?.isEmpty ?? true) ||
        (doctor.specialized?.isEmpty ?? true) ||
        (doctor.email?.isEmpty ?? true) ||
        (doctor.degreeId?.isEmpty ?? true)) {
      return;
    }
    if (doctor.doctorId?.isEmpty ?? true) {
      createDoctor(doctor);
    } else {
      updateDoctor(doctor);
    }
    Get.back();
  }

  Future<void> deleteDoctor(String doctorId) async {
    EasyLoading.show();
    final response = await doctorRepo.deleteDoctor(doctorId: doctorId);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Delete doctor', l),
      (r) async {
        await fetchDoctors();
        Get.back();
        Get.snackbar(
          'Delete doctor',
          'Delete doctor Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void showDeleteDialog(String doctorId) {
    Get.dialog(
      DeleteDoctorDialog(
        deleteDoctor: () async {
          await deleteDoctor(doctorId);
        },
      ),
    );
  }

  Future<void> createDoctor(DoctorRequest request) async {
    EasyLoading.show();
    final response = await doctorRepo.createDoctor(doctorRequest: request);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Create Doctor', l),
      (r) {
        Get.snackbar(
          'Create Doctor',
          'Create Doctor Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchDoctors();
      },
    );
  }

  Future<void> updateDoctor(DoctorRequest request) async {
    EasyLoading.show();
    final response = await doctorRepo.editDoctor(doctorRequest: request);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Update Doctor', l),
      (r) {
        Get.snackbar(
          'Update Doctor',
          'Update Doctor Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchDoctors();
      },
    );
  }

  Future<void> fetchDoctors() async {
    EasyLoading.show();
    final response = await doctorRepo.getDoctors(limit: limit, offset: offset);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Get Doctor', l),
      (r) => doctorList.value = r?.doctors ?? [],
    );
  }

  Future<void> fetchDegrees() async {
    EasyLoading.show();
    final response = await degreeRepo.getDegree();
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Get Degree', l),
      (r) => degreeList.value = r ?? [],
    );
  }
}
