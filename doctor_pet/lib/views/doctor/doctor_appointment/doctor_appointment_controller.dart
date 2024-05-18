import 'package:doctor_pet/core/data/request/create_billing_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/response/appointment_response.dart';
import 'package:doctor_pet/core/data/response/medicine_category_response.dart';
import 'package:doctor_pet/utils/app_extension.dart';

import '../../../core/data/request/prescription_medicine_request.dart';
import '../../../core/repos/appointment_repo.dart';
import '../../../core/repos/medicine_category_repo.dart';
import '../../../core/repos/medicine_repo.dart';
import '../../../utils/app_helper.dart';

class DoctorAppointmentController extends GetxController {
  Rx<List<AppointmentResponse>> appointments =
      Rx<List<AppointmentResponse>>([]);
  Rx<List<MedicineCategoryResponse>> medicineCategories = Rx([]);
  Rx<DateTime> date = Rx(DateTime.now().dateOnly);
  int offset = 0;
  final int limit = 10;
  RxInt total = RxInt(0);
  RxInt firstIndexItem = RxInt(0);
  RxInt lastIndexItem = RxInt(0);
  Rxn<AppointmentResponse> selectedAppointment = Rxn();

  AppointmentRepo appointmentRepo;
  MedicineRepo medicineRepo;
  MedicineCategoryRepo medicineCategoryRepo;
  DoctorAppointmentController({
    required this.appointmentRepo,
    required this.medicineRepo,
    required this.medicineCategoryRepo,
  });
  void selectDate(BuildContext context) async {
    date.value = (await showDatePicker(
          context: context,
          initialDate: date.value,
          firstDate: DateTime(2020),
          lastDate: DateTime.now().dateOnly.add(const Duration(days: 730)),
        )) ??
        date.value;
    resetOffset();
    getAppointmentList();
  }

  Future<void> onConfirm(AppointmentResponse appointment) async {
    // TODO: Recheck
    final response = await appointmentRepo.confirmAppointment(
      appointmentId: appointment.appointmentId ?? '',
    );
    response.fold((l) => AppHelper.showErrorMessage('Confirm Appointment', l),
        (r) {
      Get.back();
      onCurrentPage();
    });
  }

  void showDrawer(BuildContext context, AppointmentResponse? appointment) {
    selectedAppointment.value = appointment;
    Scaffold.of(context).openEndDrawer();
  }

  void increaseDate() {
    if (date.value.compareTo(
          DateTime.now().dateOnly.add(
                const Duration(days: 730),
              ),
        ) ==
        0) {
      return;
    }
    date.value = date.value.add(const Duration(days: 1));
    resetOffset();
    getAppointmentList();
  }

  void decreaseDate() {
    if (date.value.compareTo(DateTime(2020)) == 0) return;
    date.value = date.value.subtract(const Duration(days: 1));
    resetOffset();
    getAppointmentList();
  }

  Future<bool> createBilling(
      AppointmentResponse appointment,
      String dianosis,
      String reason,
      List<PrescriptionMedicineRequest> prescriptionMedicines) async {
    EasyLoading.show();
    final response = await appointmentRepo.createBilling(
      createBillingRequest: CreateBillingRequest(
        appointmentId: appointment.appointmentId,
        diagnose: dianosis,
        reason: reason,
        prescriptionMedicines: prescriptionMedicines,
      ),
    );
    EasyLoading.dismiss();
    Get.back();
    return response.fold(
      (l) {
        AppHelper.showErrorMessage('Create Billing', l);
        return false;
      },
      (r) async {
        Get.back();
        await onCurrentPage();
        Get.snackbar(
          'Create Billing',
          'Create Billing Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      },
    );
  }

  Future<bool> getAppointmentList() async {
    EasyLoading.show();
    final response = await appointmentRepo.getAppointmentsByDoctor(
      date: date.value.formatDateTime('yyyy-MM-dd'),
      offset: offset,
      limit: limit,
    );
    EasyLoading.dismiss();
    return response.fold(
      (l) {
        AppHelper.showErrorMessage('Appointment List', l);
        return false;
      },
      (r) {
        if (r.appointments == null) return false;
        total.value = r.total ?? 0;
        offset += r.appointments!.length;
        appointments.value = r.appointments ?? [];
        appointments.refresh();
        calculatePagination();
        return true;
      },
    );
  }

  void resetOffset() {
    offset = 0;
    total.value = 0;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchMedicineCategories();
    await getAppointmentList();
  }

  Future<void> onNextPage() async {
    await getAppointmentList();
  }

  Future<void> onCurrentPage() async {
    if (offset <= limit) {
      offset = 0;
    } else {
      offset = limit * ((offset / limit).ceil() - 1);
    }
    await getAppointmentList();
  }

  void onPreviousPage() {
    if (offset <= limit) return;
    offset = limit * ((offset / limit).ceil() - 2);
    getAppointmentList();
  }

  void onFirstPage() {
    offset = 0;
    getAppointmentList();
  }

  void onLastPage() {
    if (((total / limit).ceil() - 1) <= ((offset / limit).ceil() - 1)) return;
    offset = limit * ((total / limit).ceil() - 1);
    getAppointmentList();
  }

  void calculatePagination() {
    firstIndexItem.value = limit * ((offset / limit).ceil() - 1);
    lastIndexItem.value = limit * ((offset / limit).ceil() - 1) > total.value
        ? total.value
        : limit * ((offset / limit).ceil() - 1);
  }

  Future<void> fetchMedicineCategories() async {
    EasyLoading.show();
    final response = await medicineCategoryRepo.getMedicineCategory();
    EasyLoading.dismiss();

    response.fold((l) => AppHelper.showErrorMessage('Get Medicine Category', l),
        (r) {
      medicineCategories.value = r ?? [];
      medicineCategories.refresh();
    });
  }
}
