import 'package:doctor_pet/views/customer/customer_booking/customer_booking_binding.dart';
import 'package:doctor_pet/views/customer/customer_booking/customer_booking_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_routes.dart';

class NestedNavigationCusBooking extends StatelessWidget {
  const NestedNavigationCusBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavCustomerBooking),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: CustomerBookingBinding(),
          page: () => const CustomerBookingView(),
        );
      },
    );
  }
}
