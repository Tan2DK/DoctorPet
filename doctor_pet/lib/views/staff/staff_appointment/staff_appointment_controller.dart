import 'package:doctor_pet/core/data/request/assign_doctor_appointment_request.dart';
import 'package:doctor_pet/core/data/response/degree_response.dart';
import 'package:doctor_pet/core/repos/degree_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/response/appointment_response.dart';
import 'package:doctor_pet/core/data/response/doctor_response.dart';
import 'package:doctor_pet/utils/app_extension.dart';

import '../../../core/repos/appointment_repo.dart';
import '../../../core/repos/doctor_repo.dart';
import '../../../utils/app_helper.dart';
import 'widgets/doctor_selection_dialog.dart';

class StaffAppointmentController extends GetxController {
  Rx<List<AppointmentResponse>> appointments =
      Rx<List<AppointmentResponse>>([]);
  Rx<List<DoctorResponse>> doctors =
      Rx<List<DoctorResponse>>([]);
  Rx<List<DegreeResponse>> degrees =
      Rx<List<DegreeResponse>>([]);
  Rx<DateTime> date = Rx(DateTime.now().dateOnly);
  int offset = 0;
  final int limit = 10;
  RxInt total = RxInt(0);
  RxInt firstIndexItem = RxInt(0);
  RxInt lastIndexItem = RxInt(0);

  AppointmentRepo appointmentRepo;
  DoctorRepo doctorRepo;
  DegreeRepo degreeRepo;

  StaffAppointmentController({
    required this.appointmentRepo,
    required this.doctorRepo,
    required this.degreeRepo,
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

  Future<void> showDoctorSelection(AppointmentResponse appointment) async {
    if (!(await getDoctorList(appointment))) return;
    Get.dialog(DoctorSelectionDialog(
      appointment: appointment,
      doctors: doctors.value,
      confirmChanged: onConfirm,
    ));
  }

  Future<void> onConfirm(
      DoctorResponse doctor, AppointmentResponse appointment) async {
    final response = await appointmentRepo.assignDoctorAppointment(
      assignDoctorAppointmentRequest: AssignDoctorAppointmentRequest(
        doctorId: doctor.doctorId ?? '',
        appointmentId: appointment.appointmentId ?? '',
      ),
    );
    response.fold((l) => AppHelper.showErrorMessage('Assign Doctor', l), (r) {
      doctors.value.clear();
      doctors.refresh();
      onCurrentPage();
      Get.back();
    });
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

  Future<bool> getAppointmentList() async {
    EasyLoading.show();
    final response = await appointmentRepo.getPendingAppointments(
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

  Future<bool> getDoctorList(AppointmentResponse appointment) async {
    if (appointment.clinic?.clinicId == null || appointment.slot == null) {
      return false;
    }
    EasyLoading.show();
    final response = await doctorRepo.getAvailableDoctors(
      appointmentId: appointment.appointmentId ?? '',
    );
    EasyLoading.dismiss();
    return response.fold(
      (l) {
        AppHelper.showErrorMessage('Doctor list', l);
        return false;
      },
      (r) {
        if (r?.isEmpty ?? true) return false;
        doctors.value = r ?? [];
        doctors.refresh();
        return true;
      },
    );
  }

  Future<void> fetchDegrees() async {
    EasyLoading.show();
    final response = await degreeRepo.getDegree();
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Get Degree', l),
      (r) => degrees.value = r ?? [],
    );
  }

  void resetOffset() {
    offset = 0;
    total.value = 0;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
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
}
