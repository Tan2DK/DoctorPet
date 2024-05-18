import 'package:flutter/material.dart';

import '../../../../common_widget/custom_textfield_widget.dart';
import '../../../../core/data/booking_pet_model.dart';
import '../../../../core/data/response/pet_response.dart';

class LastPetRegisterForm extends StatefulWidget {
  const LastPetRegisterForm({
    Key? key,
    required this.petList,
    required this.onSelectedPet,
    this.onChanged,
    this.selectedPet,
    this.bookingPet,
  }) : super(key: key);

  final List<PetResponse> petList;
  final Function(PetResponse?)? onSelectedPet;
  final Function(BookingPetModel?)? onChanged;
  final PetResponse? selectedPet;
  final BookingPetModel? bookingPet;

  @override
  State<LastPetRegisterForm> createState() => _LastPetRegisterFormState();
}

class _LastPetRegisterFormState extends State<LastPetRegisterForm> {
  PetResponse? selectedPet;
  BookingPetModel? bookingPet;
  final TextEditingController dropdownController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  @override
  void initState() {
    super.initState();
    selectedPet = widget.selectedPet;
    dropdownController.text = selectedPet?.petName ?? '';
    bookingPet = widget.bookingPet;
    reasonController.text = bookingPet?.reason ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return widget.petList.isNotEmpty
        ? Column(
            children: [
              DropdownMenu<PetResponse>(
                dropdownMenuEntries: widget.petList.map((pet) {
                  return DropdownMenuEntry(
                    label: pet.petName ?? '',
                    value: pet,
                  );
                }).toList(),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                label: const Text('My Pet'),
                expandedInsets: const EdgeInsets.symmetric(horizontal: 0),
                controller: dropdownController,
                onSelected: (value) => setState(() {
                  selectedPet = value;
                  widget.onSelectedPet?.call(value);
                }),
                menuHeight: 200,
                trailingIcon: selectedPet != null
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPet = null;
                              dropdownController.clear();
                              widget.onSelectedPet?.call(null);
                            });
                          },
                          child: const Icon(Icons.clear),
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 10),
              CustomTextfieldWidget(
                controller: reasonController,
                label: 'Reason',
                onChanged: (value) => widget.onChanged?.call(
                  (value?.isEmpty ?? true)
                      ? null
                      : BookingPetModel(reason: value),
                ),
              ),
            ],
          )
        : const Center(
            child: Text('No Pet found for this clinic.'),
          );
  }
}
