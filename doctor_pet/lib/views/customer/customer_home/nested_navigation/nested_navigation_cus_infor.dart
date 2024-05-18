import 'package:doctor_pet/views/customer/information/information_binding.dart';
import 'package:doctor_pet/views/customer/information/information_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_routes.dart';

class NestedNavigationCusInfor extends StatelessWidget {
  const NestedNavigationCusInfor({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavCustomerInformation),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: InformationBinding(),
          page: () => const InformationView(),
        );
      },
    );
  }
}
