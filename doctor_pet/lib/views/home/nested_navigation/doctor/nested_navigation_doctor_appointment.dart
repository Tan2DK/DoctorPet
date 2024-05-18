import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_routes.dart';
import '../../../doctor/doctor_appointment/doctor_appointment_binding.dart';
import '../../../doctor/doctor_appointment/doctor_appointment_view.dart';

class NestedNavigationDoctorAppointment extends StatelessWidget {
  const NestedNavigationDoctorAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavDoctorAppointment),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: DoctorAppointmentBinding(),
          page: () => const DoctorAppointmentView(),
        );
      },
    );
  }
}
