import 'package:doctor_pet/core/data/request/pet_request.dart';
import 'package:doctor_pet/core/data/response/pet_category_response.dart';
import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../core/data/response/pet_response.dart';
import '../../../core/repos/pet_category_repo.dart';
import '../../../core/repos/pet_repo.dart';
import '../../../utils/app_helper.dart';
import 'widgets/delete_pet_dialog.dart';
import 'widgets/edit_pet_dialog.dart';

class PetController extends GetxController {
  Rx<List<PetResponse>> petList = Rx<List<PetResponse>>([]);
  Rx<List<PetCategoryResponse>> petCategoryList =
      Rx<List<PetCategoryResponse>>([]);
  final LocalAuthRepo localAuthRepo;
  final PetRepo petRepo;
  final PetCategoryRepo petCategoryRepo;
  String? userId;
  final int limit = 10;
  int offset = 0;

  PetController({
    required this.localAuthRepo,
    required this.petRepo,
    required this.petCategoryRepo,
  });

  Future<DateTime?> selectDate(BuildContext context, DateTime date) async {
    return await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
  }

  Future<void> deletePet(String petId) async {
    EasyLoading.show();
    final response = await petRepo.deletePet(petId: petId);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Delete Pet', l),
      (r) async {
        await fetchPets();
        Get.back();
        Get.snackbar(
          'Delete Pet',
          'Delete Pet Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void showDeleteDialog(String petId) {
    Get.dialog(DeletePetDialog(
      deletePet: () => deletePet(petId),
    ));
  }

  void showAddEditDialog(BuildContext context, PetResponse? response) {
    Get.dialog(
      EditPetDialog(
        selectDate: selectDate,
        addEditPet: addEditPet,
        categories: petCategoryList.value,
        pet: response == null ? null : PetRequest.fromResponse(response),
      ),
    );
  }

  void addEditPet(PetRequest pet) {
    if ((pet.petName?.isEmpty ?? true) ||
        (pet.petAge == null) ||
        (pet.petColor?.isEmpty ?? true) ||
        (pet.petGender == null) ||
        (pet.petSpecies?.isEmpty ?? true) ||
        (pet.petTypeId?.isEmpty ?? true)) {
      return;
    }
    if (pet.petId?.isEmpty ?? true) {
      createPet(pet);
    } else {
      updatePet(pet);
    }
    Get.back();
  }

  Future<void> createPet(PetRequest request) async {
    EasyLoading.show();
    final response = await petRepo.createPet(petRequest: request);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Create Pet', l),
      (r) {
        Get.snackbar(
          'Create Pet',
          'Create Pet Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchPets();
      },
    );
  }

  Future<void> updatePet(PetRequest request) async {
    EasyLoading.show();
    final response = await petRepo.editPet(petRequest: request);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Update Pet', l),
      (r) {
        Get.snackbar(
          'Update Pet',
          'Update Pet Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchPets();
      },
    );
  }

  Future<void> fetchPets() async {
    EasyLoading.show();
    final response = await petRepo.getPet();
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Get Pet', l),
      (r) => petList.value = r?.petLists ?? [],
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

  @override
  void onInit() {
    super.onInit();
    userId = localAuthRepo.userId();
    fetchPets();
    fetchPetCategories();
  }
}
