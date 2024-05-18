import 'package:doctor_pet/views/admin/pet_category/pet_category_binding.dart';
import 'package:doctor_pet/views/admin/pet_category/pet_category_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_routes.dart';

class NestedNavigationAdminPetCategory extends StatelessWidget {
  const NestedNavigationAdminPetCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavAdminPetCategory),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: PetCategoryBinding(),
          page: () => const PetCategoryView(),
        );
      },
    );
  }
}
