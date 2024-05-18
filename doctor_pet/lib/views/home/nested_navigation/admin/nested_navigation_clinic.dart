import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_routes.dart';
import '../../../admin/clinic/clinic_binding.dart';
import '../../../admin/clinic/clinic_view.dart';

class NestedNavigationClinic extends StatelessWidget {
  const NestedNavigationClinic({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavClinic),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: ClinicBinding(),
          page: () => const ClinicView(),
        );
      },
    );
  }
}
