import 'package:doctor_pet/views/clinic_manager/medicine/clinic_medicine_binding.dart';
import 'package:doctor_pet/views/clinic_manager/medicine/clinic_medicine_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_routes.dart';

class NestedNavigationClinicMedicine extends StatelessWidget {
  const NestedNavigationClinicMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavClinicMedicine),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: ClinicMedicineBinding(),
          page: () => const ClinicMedicineView(),
        );
      },
    );
  }
}
