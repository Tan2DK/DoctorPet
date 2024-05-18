import 'package:doctor_pet/core/data/response/staff_response.dart';
import 'package:doctor_pet/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/request/staff_request.dart';
import 'package:doctor_pet/views/clinic_manager/staff/widgets/delete_staff_dialog.dart';
import 'package:doctor_pet/views/clinic_manager/staff/widgets/edit_staff_dialog.dart';

import '../../../core/repos/staff_repo.dart';

class StaffController extends GetxController {
  Rx<List<StaffResponse>> staffList = Rx<List<StaffResponse>>([]);
  StaffRepo staffRepo;
  StaffController({
    required this.staffRepo,
  });

  final int limit = 10;
  int offset = 0;

  Future<DateTime?> selectDate(
      BuildContext context, DateTime date, bool isLimit) async {
    return await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: isLimit ? DateTime.now() : DateTime(2100),
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchStaffs();
  }

  void showAddEditStaffDialog({StaffResponse? staff}) {
    Get.dialog(EditStaffDialog(
      selectDate: selectDate,
      addEditStaff: addEditStaff,
      staff: staff == null ? null : StaffRequest.fromResponse(staff),
    ));
  }

  void addEditStaff(StaffRequest staff, int? index) {
    if ((staff.name?.isEmpty ?? true) ||
        (staff.phone?.isEmpty ?? true) ||
        (staff.address?.isEmpty ?? true)) {
      return;
    }
    if (staff.id?.isEmpty ?? true) {
      createStaff(staff);
    } else {
      updateStaff(staff);
    }
    Get.back();
  }

  Future<void> fetchStaffs() async {
    EasyLoading.show();
    final response = await staffRepo.getStaff(limit: limit, offset: offset);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Get Staff', l),
      (r) => staffList.value = r?.staffs ?? [],
    );
  }

  Future<void> createStaff(StaffRequest request) async {
    EasyLoading.show();
    final response = await staffRepo.createStaff(staffRequest: request);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Create Staff', l),
      (r) {
        Get.snackbar(
          'Create Staff',
          'Create Staff Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchStaffs();
      },
    );
  }

  Future<void> updateStaff(StaffRequest request) async {
    EasyLoading.show();
    final response = await staffRepo.editStaff(staffRequest: request);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Update Staff', l),
      (r) {
        Get.snackbar(
          'Update Staff',
          'Update Staff Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchStaffs();
      },
    );
  }

  Future<void> deleteStaff(String staffId) async {
    EasyLoading.show();
    final response = await staffRepo.deleteStaff(staffId: staffId);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Delete Staff', l),
      (r) async {
        await fetchStaffs();
        Get.back();
        Get.snackbar(
          'Delete Staff',
          'Delete Staff Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void showDeleteDialog(String staffId) {
    Get.dialog(
      DeleteStaffDialog(
        deleteStaff: () async {
          await deleteStaff(staffId);
        },
      ),
    );
  }
}
