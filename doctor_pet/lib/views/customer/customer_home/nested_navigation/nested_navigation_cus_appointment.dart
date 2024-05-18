import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_routes.dart';
import '../../customer_reservation/customer_reservation_binding.dart';
import '../../customer_reservation/customer_reservation_view.dart';

class NestedNavigationCusAppointment extends StatelessWidget {
  const NestedNavigationCusAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavCustomerAppointment),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: CustomerReservationBinding(),
          page: () => const CustomerReservationView(),
        );
      },
    );
  }
}
