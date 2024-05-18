import 'package:doctor_pet/utils/app_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/response/appointment_response.dart';
import 'package:doctor_pet/core/repos/appointment_repo.dart';

import '../../../utils/app_enum.dart';

class CustomerReservationController extends GetxController {
  RxList<AppointmentResponse> appointments = RxList([]);
  AppointmentRepo appointmentRepo;
  final int limit = 10;
  int offset = 0;
  ScrollController? scrollController;
  RxBool canLoadMore = RxBool(true);
  CustomerReservationController({
    required this.appointmentRepo,
  });

  @override
  Future<void> onInit() async {
    super.onInit();
    scrollController = ScrollController()..addListener(scrollListener);
    await getAppointmentList();
  }

  Future<bool> getAppointmentList() async {
    if (canLoadMore.value == false) return false;
    EasyLoading.show();
    final response = await appointmentRepo.getAppointmentsByCustomer(
        offset: offset, limit: limit);
    EasyLoading.dismiss();
    return response.fold(
      (l) {
        AppHelper.showErrorMessage('Appointment List', l);
        return false;
      },
      (r) {
        if (r.appointments?.isEmpty ?? true) return false;
        offset += r.appointments!.length;
        if (offset == r.total) canLoadMore.value = false;
        appointments.addAll(r.appointments!);
        appointments.refresh();
        return true;
      },
    );
  }

  void scrollListener() {
    if (scrollController == null || canLoadMore.isFalse) return;
    if (scrollController!.offset >=
            scrollController!.position.maxScrollExtent &&
        !scrollController!.position.outOfRange) {
      getAppointmentList();
    }
  }

  Color? getBgColorByType(String type) {
    try {
      return switch (AppointmentStatus.values.byName(
        type.toLowerCase().trim(),
      )) {
        AppointmentStatus.pending => const Color(0xFFFFF9C4),
        AppointmentStatus.waiting => const Color(0xFFB3E5FC),
        AppointmentStatus.inprogress => const Color(0xFFC8E6C9),
        AppointmentStatus.done => const Color(0xFFE1BEE7),
      };
    } catch (e) {
      return null;
    }
  }

  Future<void> onRefreshData() async {
    offset = 0;
    canLoadMore.value = true;
    appointments.clear();
    await getAppointmentList();
  }
}
