import 'package:collection/collection.dart';
import 'package:doctor_pet/core/data/request/update_pet_category_by_clinic_request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:doctor_pet/core/data/request/pet_category_request.dart';
import 'package:doctor_pet/core/data/response/pet_category_response.dart';

import '../../../core/repos/pet_category_repo.dart';
import '../../../utils/app_helper.dart';

class ClinicPetCategoryController extends GetxController {
  Rx<Map<PetCategoryResponse, bool>> petCategoryList =
      Rx<Map<PetCategoryResponse, bool>>({});
  Rx<List<PetCategoryResponse>> selectedPetCategoryList =
      Rx<List<PetCategoryResponse>>([]);
  RxBool isShowMenu = RxBool(false);
  RxBool isUpdateEnable = RxBool(false);

  final PetCategoryRepo petCategoryRepo;
  ClinicPetCategoryController({
    required this.petCategoryRepo,
  });

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchPetCategories();
    fetchPetCategoriesByClinic();
  }

  void showMenu() {
    isShowMenu.value = !isShowMenu.value;
  }

  void checkButton() {
    bool isAllFalse = true;
    for (var element in petCategoryList.value.entries) {
      if (element.value == true) {
        isAllFalse = false;
        break;
      }
    }
    if (isAllFalse) {
      isUpdateEnable.value = false;
      return;
    }
    List<PetCategoryResponse> sameElementList = [];
    for (var element in petCategoryList.value.entries) {
      if (element.value == true) {
        sameElementList.add(element.key);
      }
    }
    final unOrderedDeepEq = const DeepCollectionEquality.unordered().equals;
    isUpdateEnable.value =
        !unOrderedDeepEq(sameElementList, selectedPetCategoryList.value);
  }

  Future<void> fetchPetCategories() async {
    EasyLoading.show();
    final response = await petCategoryRepo.getPetCategory();
    EasyLoading.dismiss();

    response.fold((l) => AppHelper.showErrorMessage('Get Pet Category', l),
        (r) {
      petCategoryList.value =
          r?.asMap().map((k, v) => MapEntry(v, false)) ?? {};
      petCategoryList.refresh();
    });
  }

  Future<void> fetchPetCategoriesByClinic() async {
    EasyLoading.show();
    final response =
        await petCategoryRepo.getPetCategoryByClinic(clinicId: '1');
    EasyLoading.dismiss();

    response.fold((l) => AppHelper.showErrorMessage('Get Pet Category', l),
        (r) {
      selectedPetCategoryList.value = r?.petTypeList ?? [];
      selectedPetCategoryList.refresh();
      for (var element in selectedPetCategoryList.value) {
        if (petCategoryList.value.keys.contains(element)) {
          petCategoryList.value[element] = true;
        }
      }
      petCategoryList.refresh();
    });
  }

  Future<void> updatePetCategoriesByClinic() async {
    final map = Map.from(petCategoryList.value)
      ..removeWhere((key, value) => value == false);
    EasyLoading.show();
    final response = await petCategoryRepo.updatePetCategoryByClinic(
      updatePetCategoryByClinicRequest: UpdatePetCategoryByClinicRequest(
        petTypeList:
            map.keys.map((e) => PetCategoryRequest.fromResponse(e)).toList(),
      ),
    );
    EasyLoading.dismiss();

    response.fold((l) => AppHelper.showErrorMessage('Update Pet Category', l),
        (r) {
      isUpdateEnable.value = false;
      Get.snackbar(
        'Update Pet Category',
        'Update Pet Category Successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      fetchPetCategoriesByClinic();
    });
  }
}
