import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common_widget/custom_textfield_widget.dart';
import '../../../../common_widget/radio_gender_widget.dart';
import '../../../../core/data/booking_pet_model.dart';
import '../../../../core/data/pet_model.dart';
import '../../../../core/data/response/pet_category_response.dart';
import '../../../../utils/app_enum.dart';

class NewPetFormWidget extends StatefulWidget {
  const NewPetFormWidget({
    Key? key,
    this.bookingPet,
    this.addEditBookingPet,
    this.clearBookingPet,
    required this.categories,
    this.checkClearButton,
    this.checkButton,
    this.clearData,
    this.getData,
  }) : super(key: key);
  final BookingPetModel? bookingPet;
  final Function(BookingPetModel)? addEditBookingPet;
  final Function()? clearBookingPet;
  final List<PetCategoryResponse> categories;
  final Function(bool)? checkClearButton;
  final Function(bool)? checkButton;
  final Function(Function()?)? clearData;
  final Function(Function()?)? getData;
  @override
  State<NewPetFormWidget> createState() => _NewPetFormWidgetState();
}

class _NewPetFormWidgetState extends State<NewPetFormWidget> {
  Gender selectedGender = Gender.male;
  bool isRegisterButtonEnabled = false;
  bool isClearButtonEnabled = false;
  final textControllerPetName = TextEditingController();
  final textControllerPetSpecies = TextEditingController();
  final textControllerPetAge = TextEditingController();
  final textControllerPetColor = TextEditingController();
  final textControllerReason = TextEditingController();
  final dropdownController = TextEditingController();
  PetCategoryResponse? selectedCategory;

  @override
  void initState() {
    super.initState();
    widget.clearData?.call(clearForm);
    widget.getData?.call(getForm);
    if (widget.bookingPet?.pet == null) return;
    textControllerPetName.text = widget.bookingPet?.pet!.name ?? '';
    textControllerPetSpecies.text = widget.bookingPet?.pet!.species ?? '';
    textControllerPetAge.text = (widget.bookingPet?.pet!.age ?? 0).toString();
    textControllerPetColor.text = widget.bookingPet?.pet!.color ?? '';
    textControllerReason.text = widget.bookingPet?.reason ?? '';
    selectedGender = widget.bookingPet?.pet?.gender ?? Gender.male;
    dropdownController.text = widget.categories
            .firstWhereOrNull(
                (cate) => cate.petTypeId == widget.bookingPet?.pet?.typeId)
            ?.petTypeName ??
        '';
    selectedCategory = widget.categories.firstWhereOrNull(
        (cate) => cate.petTypeId == widget.bookingPet?.pet?.typeId);
  }

  void clearForm() {
    textControllerPetName.text = '';
    textControllerPetSpecies.text = '';
    textControllerPetAge.text = '';
    textControllerPetColor.text = '';
    textControllerReason.text = '';
    selectedCategory = null;
    dropdownController.text = '';
    widget.clearBookingPet?.call();
    isClearButtonEnabled = false;
  }

  void getForm() {
    widget.addEditBookingPet?.call(
      BookingPetModel(
        pet: PetModel(
          name: textControllerPetName.text,
          species: textControllerPetSpecies.text,
          age: int.tryParse(textControllerPetAge.text),
          gender: selectedGender,
          typeId: selectedCategory?.petTypeId,
          color: textControllerPetColor.text,
        ),
        reason: textControllerReason.text,
      ),
    );
  }

  void checkClearButton() {
    setState(() {
      isClearButtonEnabled = (textControllerPetName.text.isNotEmpty ||
              textControllerPetSpecies.text.isNotEmpty ||
              textControllerPetAge.text.isNotEmpty ||
              textControllerPetColor.text.isNotEmpty ||
              textControllerReason.text.isNotEmpty) ||
          widget.bookingPet != null;
      widget.checkClearButton?.call(isClearButtonEnabled);
    });
  }

  void checkButton() {
    setState(
      () {
        isRegisterButtonEnabled = !(textControllerPetName.text.isEmpty ||
            textControllerPetSpecies.text.isEmpty ||
            textControllerPetAge.text.isEmpty ||
            textControllerPetColor.text.isEmpty ||
            textControllerReason.text.isEmpty ||
            selectedCategory == null);
        widget.checkButton?.call(isRegisterButtonEnabled);
        isClearButtonEnabled = (textControllerPetName.text.isNotEmpty ||
                textControllerPetSpecies.text.isNotEmpty ||
                textControllerPetAge.text.isNotEmpty ||
                textControllerPetColor.text.isNotEmpty ||
                textControllerReason.text.isNotEmpty ||
                dropdownController.text.isNotEmpty ||
                selectedCategory != null) ||
            widget.bookingPet != null;
        widget.checkClearButton?.call(isClearButtonEnabled);
      },
    );
  }

  void onChangedGender(Gender? gender) {
    if (gender == null) return;
    selectedGender = gender;
    checkButton();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextfieldWidget(
          controller: textControllerPetName,
          label: 'Pet Name',
          onChanged: (_) => checkButton(),
        ),
        const SizedBox(height: 10),
        DropdownMenu<PetCategoryResponse>(
          label: const Text('Pet Category'),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.9),
              ),
            ),
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
        CustomTextfieldWidget(
          controller: textControllerPetSpecies,
          label: 'Pet Species',
          onChanged: (_) => checkButton(),
        ),
        const SizedBox(height: 10),
        CustomTextfieldWidget(
          maxLength: 3,
          controller: textControllerPetAge,
          label: 'Pet Age',
          textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (_) => checkButton(),
        ),
        const SizedBox(height: 10),
        CustomTextfieldWidget(
          controller: textControllerPetColor,
          label: 'Pet Color',
          onChanged: (_) => checkButton(),
        ),
        const SizedBox(height: 10),
        CustomTextfieldWidget(
          controller: textControllerReason,
          label: 'Reason',
          onChanged: (_) => checkButton(),
        ),
        const SizedBox(height: 10),
        RadioGenderWidget(
          onChangedGender: onChangedGender,
          gender: selectedGender,
        ),
      ],
    );
  }
}
