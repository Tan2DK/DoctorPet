import 'package:doctor_pet/views/clinic_manager/doctor/clinic_doctor_binding.dart';
import 'package:doctor_pet/views/clinic_manager/doctor/clinic_doctor_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_routes.dart';

class NestedNavigationClinicDoctor extends StatelessWidget {
  const NestedNavigationClinicDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavClinicDoctor),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: ClinicDoctorBinding(),
          page: () => const ClinicDoctorView(),
        );
      },
    );
  }
}
