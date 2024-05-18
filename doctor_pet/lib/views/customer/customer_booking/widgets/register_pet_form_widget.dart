import 'package:doctor_pet/views/customer/customer_booking/widgets/delete_pet_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/views/customer/customer_booking/widgets/last_pet_register_form.dart';
import 'package:doctor_pet/views/customer/customer_booking/widgets/new_pet_form_widget.dart';

import '../../../../common_widget/custom_text/custom_text_widget.dart';
import '../../../../core/data/booking_pet_model.dart';
import '../../../../core/data/response/pet_category_response.dart';
import '../../../../core/data/response/pet_response.dart';

class RegisterPetDialog extends StatefulWidget {
  const RegisterPetDialog({
    Key? key,
    this.bookingPet,
    this.addEditBookingPet,
    this.onSelectedPet,
    this.clearBookingPet,
    required this.categories,
    required this.pets,
    this.selectedPet,
  }) : super(key: key);
  final BookingPetModel? bookingPet;
  final Function(BookingPetModel)? addEditBookingPet;
  final Function(PetResponse?, BookingPetModel?)? onSelectedPet;
  final Function()? clearBookingPet;
  final List<PetCategoryResponse> categories;
  final List<PetResponse> pets;
  final PetResponse? selectedPet;

  @override
  State<RegisterPetDialog> createState() => _RegisterPetDialogState();
}

class _RegisterPetDialogState extends State<RegisterPetDialog> {
  bool isRegisterButtonEnabled = false;
  bool isClearButtonEnabled = false;
  bool isNewPet = false;
  Function()? clearData;
  Function()? getData;
  PetResponse? selectedPet;
  BookingPetModel? bookingPet;

  @override
  void initState() {
    super.initState();
    selectedPet = widget.selectedPet;
    bookingPet = widget.bookingPet;
    if (selectedPet != null) {
      isNewPet = false;
      return;
    }
    if (bookingPet?.pet != null) {
      isNewPet = true;
      isClearButtonEnabled = true;
    }
  }

  void onChangedNewPet(bool isNew) {
    if (isNewPet == isNew) return;
    setState(() {
      isNewPet = isNew;
    });
    if (!isNew && (bookingPet?.pet != null || isClearButtonEnabled)) {
      setState(() {
        isClearButtonEnabled = false;
        isRegisterButtonEnabled = false;
        widget.clearBookingPet?.call();
        clearData?.call();
      });
    }
    if (isNew && (selectedPet != null || bookingPet != null)) {
      setState(() {
        isClearButtonEnabled = false;
        isRegisterButtonEnabled = false;
        selectedPet = null;
        bookingPet = null;
        widget.onSelectedPet?.call(null, null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const CustomTextWidget(
        text: 'Register Pet',
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(),
            ),
            child: IntrinsicWidth(
              child: Row(
                children: [
                  ColoredBox(
                    color: isNewPet
                        ? Colors.transparent
                        : Theme.of(context).primaryColor,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (bookingPet == null && !isClearButtonEnabled) {
                            onChangedNewPet(false);
                            return;
                          }
                          Get.dialog(DeletePetConfirmDialog(
                            title: 'Change Pet',
                            content:
                                'Change to old pet will remove data of new pet?',
                            onConfirm: () => onChangedNewPet(false),
                          ));
                        },
                        child: Center(
                          child: Text(
                            'Last Pet',
                            style: TextStyle(
                              color: isNewPet
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                            ),
                          ).paddingSymmetric(horizontal: 16, vertical: 8),
                        ),
                      ),
                    ),
                  ),
                  ColoredBox(
                    color: isNewPet
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (bookingPet == null && selectedPet == null) {
                            onChangedNewPet(true);
                            return;
                          }
                          Get.dialog(DeletePetConfirmDialog(
                            title: 'Change Pet',
                            content: 'Change to new pet will remove old pet?',
                            onConfirm: () => onChangedNewPet(true),
                          ));
                        },
                        child: Center(
                          child: Text(
                            'New Pet',
                            style: TextStyle(
                              color: isNewPet
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                          ).paddingSymmetric(horizontal: 16, vertical: 8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(thickness: 2, height: 0),
          const SizedBox(height: 16),
          if (!isNewPet)
            LastPetRegisterForm(
              petList: widget.pets,
              onSelectedPet: (pet) {
                if (pet == null) widget.onSelectedPet?.call(null, bookingPet);
                setState(() {
                  selectedPet = pet;
                  isRegisterButtonEnabled = (selectedPet != null &&
                      (bookingPet?.reason?.isNotEmpty ?? false));
                });
              },
              selectedPet: selectedPet,
              bookingPet: bookingPet?.pet != null ? null : bookingPet,
              onChanged: (bP) {
                setState(() {
                  bookingPet = bP;
                  isRegisterButtonEnabled =
                      ((bookingPet?.reason?.isNotEmpty ?? false) &&
                          selectedPet != null);
                });
              },
            ),
          if (isNewPet)
            NewPetFormWidget(
              categories: widget.categories,
              addEditBookingPet: widget.addEditBookingPet,
              bookingPet: bookingPet,
              clearBookingPet: widget.clearBookingPet,
              checkButton: (value) {
                setState(() {
                  isRegisterButtonEnabled = value;
                });
              },
              checkClearButton: (value) {
                setState(() {
                  isClearButtonEnabled = value;
                });
              },
              clearData: (function) => clearData = function,
              getData: (function) => getData = function,
            ),
        ],
      ),
      actions: [
        if (isNewPet)
          TextButton(
            onPressed: !isClearButtonEnabled
                ? null
                : () {
                    setState(() {
                      clearData?.call();
                      bookingPet = null;
                      isClearButtonEnabled = false;
                    });
                  },
            child: const CustomTextWidget(text: 'Clear'),
          ),
        TextButton(
          onPressed: !isRegisterButtonEnabled
              ? null
              : selectedPet != null
                  ? () {
                      widget.onSelectedPet?.call(selectedPet, bookingPet);
                      Get.back();
                    }
                  : () => getData?.call(),
          child: const CustomTextWidget(text: 'Register'),
        ),
        TextButton(
          onPressed: Get.back,
          child: const CustomTextWidget(text: 'Cancel'),
        ),
      ],
    );
  }
}
