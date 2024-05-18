import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:doctor_pet/core/data/request/pet_category_request.dart';
import 'package:doctor_pet/core/data/response/pet_category_response.dart';
import 'package:doctor_pet/views/admin/pet_category/widgets/delete_pet_category_dialog.dart';
import 'package:doctor_pet/views/admin/pet_category/widgets/edit_category_dialog.dart';

import '../../../core/repos/pet_category_repo.dart';
import '../../../utils/app_helper.dart';

class PetCategoryController extends GetxController {
  Rx<List<PetCategoryResponse>> petCategoryList =
      Rx<List<PetCategoryResponse>>([]);
  final PetCategoryRepo petCategoryRepo;
  PetCategoryController({
    required this.petCategoryRepo,
  });

  @override
  void onInit() {
    super.onInit();
    fetchPetCategories();
  }

  Future<void> deleteCategory(String petCategoryId) async {
    EasyLoading.show();
    final response =
        await petCategoryRepo.deletePetCategory(petCategoryId: petCategoryId);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Delete Pet Category', l),
      (r) async {
        await fetchPetCategories();
        Get.back();
        Get.snackbar(
          'Delete Pet Category',
          'Delete Pet Category Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void showDeleteDialog(String petCategoryId) {
    Get.dialog(DeletePetCategoryDialog(
      deletePetCategory: () => deleteCategory(petCategoryId),
    ));
  }

  void showAddEditDialog({PetCategoryResponse? response}) {
    Get.dialog(EditCategoryDialog(
      addEditPetCategory: addEditCategory,
      petCategory:
          response != null ? PetCategoryRequest.fromResponse(response) : null,
    ));
  }

  void addEditCategory(PetCategoryRequest request) {
    if (request.petTypeName?.isEmpty ?? true) {
      return;
    }
    if (request.petTypeId?.isEmpty ?? true) {
      createPetCategory(request);
    } else {
      updatePetCategory(request);
    }
    petCategoryList.refresh();
    Get.back();
  }

  Future<void> createPetCategory(PetCategoryRequest request) async {
    EasyLoading.show();
    final response =
        await petCategoryRepo.createPetCategory(petCategoryRequest: request);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Create Category Pet', l),
      (r) {
        Get.snackbar(
          'Create Pet Category',
          'Create Pet Category Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchPetCategories();
      },
    );
  }

  Future<void> updatePetCategory(PetCategoryRequest request) async {
    EasyLoading.show();
    final response =
        await petCategoryRepo.editPetCategory(petCategoryRequest: request);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Update Pet Category', l),
      (r) {
        Get.snackbar(
          'Update Pet Category',
          'Update Pet Category Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchPetCategories();
      },
    );
  }

  Future<void> fetchPetCategories() async {
    EasyLoading.show();
    final response = await petCategoryRepo.getPetCategory();
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Get Pet Category', l),
      (r) => petCategoryList.value = r ?? [],
    );
  }
}
