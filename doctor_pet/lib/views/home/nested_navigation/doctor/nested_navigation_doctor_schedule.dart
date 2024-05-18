import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_routes.dart';
import '../../../doctor/doctor_schedule/doctor_schedule_binding.dart';
import '../../../doctor/doctor_schedule/doctor_schedule_view.dart';

class NestedNavigationDoctorSchedule extends StatelessWidget {
  const NestedNavigationDoctorSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavDoctorSchedule),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: DoctorScheduleBinding(),
          page: () => const DoctorScheduleView(),
        );
      },
    );
  }
}
