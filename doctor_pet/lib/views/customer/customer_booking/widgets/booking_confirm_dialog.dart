import 'package:doctor_pet/utils/app_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/booking_pet_model.dart';
import 'package:doctor_pet/core/data/clinic_model.dart';
import 'package:doctor_pet/core/data/slot_in_day_model.dart';
import 'package:doctor_pet/utils/app_extension.dart';

import '../../../../core/data/response/pet_response.dart';

class BookingConfirmDialog extends StatelessWidget {
  const BookingConfirmDialog({
    Key? key,
    required this.branch,
    required this.slotInDay,
    this.bookingPet,
    this.pet,
    this.onConfirm,
  }) : super(key: key);

  final ClinicModel? branch;
  final SlotInDayModel slotInDay;
  final BookingPetModel? bookingPet;
  final PetResponse? pet;
  final Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now().dateOnly;
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 300,
          maxHeight: 300,
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Clinic Branch: '),
                      Text('Reservation Date: '),
                      Text('Reservation Time: '),
                      Text('Pet Name: '),
                      Text('Pet Species: '),
                      Text('Pet Age: '),
                      Text('Pet Color: '),
                      Text('Reason: '),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(branch?.name ?? ''),
                      Text(now
                          .add(Duration(days: slotInDay.nextDay))
                          .formatDateTime('dd MMMM yyyy')),
                      Text(slotInDay.fixedSlot.getName),
                      if (bookingPet?.pet != null) ...[
                        Text(bookingPet?.pet?.name ?? ''),
                        Text(bookingPet?.pet?.species ?? ''),
                        Text(
                          bookingPet?.pet?.age == null
                              ? ''
                              : bookingPet!.pet!.age!.toString(),
                        ),
                        Text(bookingPet?.pet?.gender.getGenderName ?? ''),
                      ],
                      if (pet != null) ...[
                        Text(pet?.petName ?? ''),
                        Text(pet?.petSpecies ?? ''),
                        Text(
                          pet?.petAge == null ? '' : pet!.petAge!.toString(),
                        ),
                        Text(
                          pet?.petGender == null
                              ? ''
                              : pet!.petGender!
                                  ? Gender.male.genderName
                                  : Gender.female.genderName,
                        ),
                      ],
                      Text(bookingPet?.reason ?? ''),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: Get.back, child: const Text('Cancel')),
            const SizedBox(height: 16),
            FilledButton(onPressed: onConfirm, child: const Text('Confirm')),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
