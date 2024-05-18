import 'package:doctor_pet/views/admin/medicine_category/medicine_category_binding.dart';
import 'package:doctor_pet/views/admin/medicine_category/medicine_category_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_routes.dart';

class NestedNavigationAdminMedicineCategory extends StatelessWidget {
  const NestedNavigationAdminMedicineCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavAdminMedicineCategory),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: MedicineCategoryBinding(),
          page: () => const MedicineCategoryView(),
        );
      },
    );
  }
}
