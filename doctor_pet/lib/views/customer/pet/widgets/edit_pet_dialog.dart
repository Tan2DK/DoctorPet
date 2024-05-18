import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/common_widget/radio_gender_widget.dart';
import 'package:doctor_pet/core/data/request/pet_request.dart';
import 'package:doctor_pet/utils/app_extension.dart';

import '../../../../../common_widget/custom_text/custom_text_widget.dart';
import '../../../../core/data/response/pet_category_response.dart';
import '../../../../utils/app_enum.dart';

class EditPetDialog extends StatefulWidget {
  const EditPetDialog({
    Key? key,
    this.pet,
    this.addEditPet,
    this.onChangedStatus,
    this.selectDate,
    required this.categories,
  }) : super(key: key);
  final PetRequest? pet;
  final Function(PetRequest)? addEditPet;
  final Function(bool?)? onChangedStatus;
  final Function(BuildContext, DateTime)? selectDate;
  final List<PetCategoryResponse> categories;

  @override
  State<EditPetDialog> createState() => _EditPetDialogState();
}

class _EditPetDialogState extends State<EditPetDialog> {
  final textControllerName = TextEditingController();
  final textControllerColor = TextEditingController();
  final textControllerSpecies = TextEditingController();
  final textControllerAge = TextEditingController();
  final dropdownController = TextEditingController();
  Gender selectedGender = Gender.male;
  DateTime birthday = DateTime.now().dateOnly;
  PetCategoryResponse? selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.pet == null) return;
    textControllerName.text = widget.pet?.petName ?? '';
    textControllerColor.text = widget.pet?.petColor ?? '';
    textControllerSpecies.text = widget.pet?.petSpecies ?? '';
    textControllerAge.text =
        widget.pet?.petAge != null ? widget.pet!.petAge.toString() : '';
    selectedGender =
        (widget.pet?.petGender ?? true) ? Gender.male : Gender.female;
    dropdownController.text = widget.categories
            .firstWhereOrNull((cate) => cate.petTypeId == widget.pet?.petTypeId)
            ?.petTypeName ??
        '';
    selectedCategory = widget.categories
        .firstWhereOrNull((cate) => cate.petTypeId == widget.pet?.petTypeId);
  }

  void onChangedGender(Gender? gender) {
    if (gender == null) return;
    selectedGender = gender;
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    );
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CustomTextWidget(
                  text: '${widget.pet != null ? 'Edit' : 'Add'} Pet',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              TextField(
                keyboardType: TextInputType.text,
                controller: textControllerName,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Pet Name',
                  border: outlineBorder,
                ),
              ),
              const SizedBox(height: 10),
              DropdownMenu<PetCategoryResponse>(
                inputDecorationTheme: InputDecorationTheme(
                  border: outlineBorder,
                ),
                dropdownMenuEntries: widget.categories.map((category) {
                  return DropdownMenuEntry(
                    label: category.petTypeName ?? '',
                    value: category,
                  );
                }).toList(),
                controller: dropdownController,
                onSelected: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                enableSearch: true,
                menuHeight: 200,
                expandedInsets: EdgeInsets.zero,
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.text,
                controller: textControllerColor,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Color',
                  border: outlineBorder,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.text,
                controller: textControllerSpecies,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Species',
                  border: outlineBorder,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: textControllerAge,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: outlineBorder,
                ),
              ),
              const SizedBox(height: 10),
              RadioGenderWidget(
                onChangedGender: onChangedGender,
                gender: selectedGender,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => widget.addEditPet?.call(
                      PetRequest(
                        petId: widget.pet?.petId,
                        petName: textControllerName.text,
                        petAge: int.tryParse(textControllerAge.text),
                        petColor: textControllerColor.text,
                        petGender: selectedGender == Gender.male,
                        petSpecies: textControllerSpecies.text,
                        petTypeId: selectedCategory?.petTypeId,
                        userId: widget.pet == null
                            ? Get.find<LocalAuthRepo>().userId()
                            : widget.pet?.userId,
                      ),
                    ),
                    child: CustomTextWidget(
                      text: widget.pet != null ? 'Edit' : 'Add',
                      txtColor: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: Get.back,
                    child: const CustomTextWidget(
                      text: 'Cancel',
                      txtColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
