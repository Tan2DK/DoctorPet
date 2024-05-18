import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_routes.dart';
import '../../../clinic_manager/pet_category/clinic_pet_category_binding.dart';
import '../../../clinic_manager/pet_category/clinic_pet_category_view.dart';

class NestedNavigationClinicPetCategory extends StatelessWidget {
  const NestedNavigationClinicPetCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavClinicPetCategory),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: ClinicPetCategoryBinding(),
          page: () => const ClinicPetCategoryView(),
        );
      },
    );
  }
}
