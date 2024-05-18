import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_routes.dart';
import '../../../admin/medicine_report/medicine_report_binding.dart';
import '../../../admin/medicine_report/medicine_report_view.dart';

class NestedNavigationAdminMedicineReport extends StatelessWidget {
  const NestedNavigationAdminMedicineReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavAdminMedicineReport),
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
