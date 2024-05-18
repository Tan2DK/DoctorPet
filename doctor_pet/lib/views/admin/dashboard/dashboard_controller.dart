import 'package:doctor_pet/core/data/response/appointment_statistic_response.dart';
import 'package:doctor_pet/core/repos/statistic_repo.dart';
import 'package:doctor_pet/utils/app_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/response/doctor_response.dart';
import 'package:doctor_pet/core/repos/clinic_repo.dart';
import 'package:doctor_pet/utils/app_helper.dart';

import '../../../core/data/clinic_model.dart';
import '../../../core/data/response/staff_response.dart';
import '../../../core/repos/doctor_repo.dart';
import '../../../core/repos/staff_repo.dart';
import '../../../utils/app_enum.dart';

class DashboardController extends GetxController {
  Rx<List<ClinicModel>> clinicList = Rx<List<ClinicModel>>([]);
  Rxn<ClinicModel> selectedClinic = Rxn();
  Rx<List<DoctorResponse>> doctorList = Rx<List<DoctorResponse>>([]);
  Rx<List<StaffResponse>> staffList = Rx<List<StaffResponse>>([]);
  Rx<List<AppointmentStatisticResponse>> appointmentStatisticList =
      Rx<List<AppointmentStatisticResponse>>([]);
  Rx<DateTime> startDate = Rx<DateTime>(DateTime.now().dateOnly);
  Rx<DateTime> endDate = Rx<DateTime>(DateTime.now().dateOnly);
  Rx<double> revenue = Rx(0);
  RxInt appointmentCount = RxInt(0);
  Rx<List<BarChartGroupData>> barChartRodData = Rx<List<BarChartGroupData>>([]);

  RxInt tabIndex = RxInt(0);
  RxInt totalDoctor = RxInt(0);
  RxInt totalStaff = RxInt(0);

  final ClinicRepo clinicRepo;
  final DoctorRepo doctorRepo;
  final StaffRepo staffRepo;
  final StatisticRepo statisticRepo;
  DashboardController({
    required this.clinicRepo,
    required this.doctorRepo,
    required this.staffRepo,
    required this.statisticRepo,
  });

  Future<DateTime?> selectDate(
      BuildContext context, DateTime date, bool isEnd) async {
    return await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: isEnd ? startDate.value : DateTime(1900),
      lastDate: isEnd ? DateTime.now() : endDate.value,
    );
  }

  Color getBgColorByType(AppointmentStatus status) {
    return switch (status) {
      AppointmentStatus.pending => const Color(0xFFFFF9C4),
      AppointmentStatus.waiting => const Color(0xFFB3E5FC),
      AppointmentStatus.inprogress => const Color(0xFFC8E6C9),
      AppointmentStatus.done => const Color(0xFFE1BEE7),
    };
  }

  List<BarChartGroupData> chartMapper(
    double barsWidth,
    double barsSpace,
  ) {
    return appointmentStatisticList.value
        .asMap()
        .map(
          (index, value) {
            double sum1 = (value.doneQuantity?.toDouble() ?? 0) +
                (value.inProgressQuantity?.toDouble() ?? 0);
            double sum2 = (value.doneQuantity?.toDouble() ?? 0) +
                (value.inProgressQuantity?.toDouble() ?? 0) +
                (value.waitingQuantity?.toDouble() ?? 0);
            double sum3 = (value.doneQuantity?.toDouble() ?? 0) +
                (value.inProgressQuantity?.toDouble() ?? 0) +
                (value.waitingQuantity?.toDouble() ?? 0) +
                (value.pendingQuantity?.toDouble() ?? 0);
            return MapEntry(
              index,
              BarChartGroupData(
                x: index,
                barsSpace: barsSpace,
                barRods: [
                  BarChartRodData(
                    fromY: 0,
                    toY: sum3 != 0 ? sum3 : 0.1,
                    borderRadius: BorderRadius.circular(0),
                    color: sum3 != 0 ? Colors.transparent : Colors.grey,
                    width: barsWidth,
                    rodStackItems: [
                      BarChartRodStackItem(
                        0,
                        value.doneQuantity?.toDouble() ?? 0,
                        getBgColorByType(AppointmentStatus.done),
                      ),
                      BarChartRodStackItem(
                        value.doneQuantity?.toDouble() ?? 0,
                        sum1,
                        getBgColorByType(AppointmentStatus.inprogress),
                      ),
                      BarChartRodStackItem(
                        sum1,
                        sum2,
                        getBgColorByType(AppointmentStatus.waiting),
                      ),
                      BarChartRodStackItem(
                        sum2,
                        sum3,
                        getBgColorByType(AppointmentStatus.pending),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        )
        .values
        .toList();
  }

  Future<void> fetchClinic() async {
    EasyLoading.show();
    final res = await clinicRepo.getClinic();
    EasyLoading.dismiss();
    res.fold((l) => AppHelper.showErrorMessage('Get Clinic', l), (r) {
      clinicList.value = r;
    });
  }

  void onClinicSelected(ClinicModel? clinic) {
    selectedClinic.value = clinic;
    fetchDataByClinic();
  }

  Future<void> fetchDoctors() async {
    EasyLoading.show();
    final response = await doctorRepo.getDashboardDoctors(
      limit: 10,
      offset: 0,
      clinicId: selectedClinic.value?.id,
    );
    EasyLoading.dismiss();

    response.fold((l) => AppHelper.showErrorMessage('Get Doctor', l), (r) {
      totalDoctor.value = r?.totalDoctor ?? 0;
      doctorList.value = r?.doctors ?? [];
    });
  }

  Future<void> fetchStaffs() async {
    EasyLoading.show();
    final response = await staffRepo.getDashboardStaff(
      limit: 10,
      offset: 0,
      clinicId: selectedClinic.value?.id,
    );
    EasyLoading.dismiss();

    response.fold((l) => AppHelper.showErrorMessage('Get Staff', l), (r) {
      totalStaff.value = r?.totalStaff ?? 0;
      staffList.value = r?.staffs ?? [];
    });
  }

  Future<void> fetchAppointmentStatistics() async {
    EasyLoading.show();
    final response = await statisticRepo.appointmentStatistics(
      startDate: startDate.value.formatDateTime('yyyy-MM-dd'),
      endDate: endDate.value.formatDateTime('yyyy-MM-dd'),
      clinicId: selectedClinic.value?.id,
    );
    EasyLoading.dismiss();

    response.fold(
        (l) => AppHelper.showErrorMessage('Get Appointment Statistics', l),
        (r) {
      appointmentCount.value = r?.totalAppointment ?? 0;
      appointmentStatisticList.value = r?.appointmentStatistics ?? [];
    });
  }

  Future<void> fetchMoneyStatistics() async {
    EasyLoading.show();
    final response = await statisticRepo.moneyStatistics(
      startDate: startDate.value.formatDateTime('yyyy-MM-dd'),
      endDate: endDate.value.formatDateTime('yyyy-MM-dd'),
      clinicId: selectedClinic.value?.id,
    );
    EasyLoading.dismiss();

    response.fold(
        (l) => AppHelper.showErrorMessage('Get Appointment Statistics', l),
        (r) {
      revenue.value = double.tryParse(r) ?? 0;
    });
  }

  void fetchDataByClinic() {
    fetchDoctors();
    fetchStaffs();
    fetchAppointmentStatistics();
    fetchMoneyStatistics();
  }

  void onTabChanged(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchClinic();
    fetchDataByClinic();
  }
}
