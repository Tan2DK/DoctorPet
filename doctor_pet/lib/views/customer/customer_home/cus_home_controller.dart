import 'package:doctor_pet/core/data/cus_tab_model.dart';
import 'package:doctor_pet/views/customer/customer_booking/customer_booking_controller.dart';
import 'package:doctor_pet/views/customer/customer_home/nested_navigation/nested_navigation_cus_appointment.dart';
import 'package:doctor_pet/views/customer/customer_home/nested_navigation/nested_navigation_cus_booking.dart';
import 'package:doctor_pet/views/customer/customer_home/nested_navigation/nested_navigation_cus_infor.dart';
import 'package:doctor_pet/views/customer/customer_home/nested_navigation/nested_navigation_cus_pet.dart';
import 'package:doctor_pet/views/customer/customer_reservation/customer_reservation_controller.dart';
import 'package:doctor_pet/views/customer/information/information_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pet/pet_controller.dart';

class CustomerHomeController extends GetxController {
  RxInt index = RxInt(0);
  final customerTabNameList = <CusTabModel>[
    CusTabModel(title: 'Booking', icon: Icons.book_online_outlined),
    // 'Dashboard',
    CusTabModel(title: 'Appointment', icon: Icons.calendar_today),
    CusTabModel(title: 'My Pets', icon: Icons.pets),
    CusTabModel(title: 'Information', icon: Icons.manage_accounts_outlined),
    // 'Ask Doctor',
  ];

  void changeTab(int i) {
    if (index.value == i) {
      final controller = getNestedController(i);
      if (controller == null) return;
      onRefresh(controller);
    }
    index.value = i;
  }

  List<Widget> listScreen() {
    return [
      const NestedNavigationCusBooking(),
      const NestedNavigationCusAppointment(),
      const NestedNavigationCusPet(),
      const NestedNavigationCusInfor(),
    ];
  }

  GetxController? getNestedController(int index) {
    return switch (index) {
      0 => Get.isRegistered<CustomerBookingController>()
          ? Get.find<CustomerBookingController>()
          : null,
      1 => Get.isRegistered<CustomerReservationController>()
          ? Get.find<CustomerReservationController>()
          : null,
      2 => Get.isRegistered<PetController>() ? Get.find<PetController>() : null,
      3 => Get.isRegistered<InformationController>()
          ? Get.find<InformationController>()
          : null,
      _ => null,
    };
  }

  void onRefresh(GetxController controller) {
    switch (controller.runtimeType) {
      case CustomerBookingController:
        () {};
        break;
      case CustomerReservationController:
        (controller as CustomerReservationController).onRefreshData();
        break;
      default:
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    // AppHelper.navigateNeedToAuth();
  }
}
