import 'package:doctor_pet/views/clinic_manager/medicine_report/medicine_report_binding.dart';
import 'package:doctor_pet/views/clinic_manager/medicine_report/medicine_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_routes.dart';

class NestedNavigationClinicMedicineReport extends StatelessWidget {
  const NestedNavigationClinicMedicineReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavClinicMedicineReport),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: MedicineReportBinding(),
          page: () => const MedicineReportView(),
        );
      },
    );
  }
}
