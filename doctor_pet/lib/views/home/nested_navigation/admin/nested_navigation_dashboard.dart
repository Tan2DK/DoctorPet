import 'package:doctor_pet/views/admin/dashboard/dashboard_binding.dart';
import 'package:doctor_pet/views/admin/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_routes.dart';

class NestedNavigationDashboard extends StatelessWidget {
  const NestedNavigationDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavDashboard),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: DashboardBinding(),
          page: () => const DashBoardView(),
        );
      },
    );
  }
}
