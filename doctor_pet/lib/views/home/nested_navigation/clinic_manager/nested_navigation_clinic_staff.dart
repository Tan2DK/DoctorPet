import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_routes.dart';
import '../../../clinic_manager/staff/staff_binding.dart';
import '../../../clinic_manager/staff/staff_view.dart';

class NestedNavigationClinicStaff extends StatelessWidget {
  const NestedNavigationClinicStaff({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavClinicStaff),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: StaffBinding(),
          page: () => const StaffView(),
        );
      },
    );
  }
}
