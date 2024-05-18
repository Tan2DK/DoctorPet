import 'package:doctor_pet/views/staff/staff_appointment/staff_appointment_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_routes.dart';
import '../../../staff/staff_appointment/staff_appointment_view.dart';

class NestedNavigationStaffAppointment extends StatelessWidget {
  const NestedNavigationStaffAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavStaffAppointment),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: StaffAppointmentBinding(),
          page: () => const StaffAppointmentView(),
        );
      },
    );
  }
}
