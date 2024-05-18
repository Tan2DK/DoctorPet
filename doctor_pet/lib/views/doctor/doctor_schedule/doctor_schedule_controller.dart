import 'package:doctor_pet/core/data/request/doctor_get_slots_request.dart';
import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:doctor_pet/utils/app_constant.dart';
import 'package:doctor_pet/utils/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/request/doctor_slots_request.dart';
import 'package:doctor_pet/core/data/slot_in_day_model.dart';
import 'package:doctor_pet/core/repos/doctor_slots_repo.dart';
import 'package:doctor_pet/utils/app_extension.dart';

import '../../../core/data/response/doctor_slots_response.dart';
import '../../../utils/app_enum.dart';

class DoctorScheduleController extends GetxController {
  RxInt count = RxInt(0);
  Rx<DateTime> now = Rx<DateTime>(DateTime.now().dateOnly);
  void increase() => count.value++;
  Rx<List<List<SlotInDayModel>>> doctorSlots =
      Rx<List<List<SlotInDayModel>>>([]);
  Future<bool>? call;
  DoctorSlotsRepo doctorSlotsRepo;
  LocalAuthRepo localAuthRepo;
  DoctorScheduleController({
    required this.doctorSlotsRepo,
    required this.localAuthRepo,
  });

  void mapSlots(List<DoctorSlotsResponse> slotsFetched) {
    if (slotsFetched.length == IntConstant.maxDay + 1) {
      doctorSlots.value = slotsFetched.map((slots) {
        List<SlotInDayModel> slotsInDay;
        slotsInDay = mapSlotsInDay(slots);
        return slotsInDay;
      }).toList();
    } else {
      doctorSlots.value = List.generate(IntConstant.maxDay + 1, (index) {
        List<SlotInDayModel> slotsInDay;
        final slots = slotsFetched.firstWhereOrNull(
          (element) =>
              element.date?.substring(0, 10) ==
              (now.value
                  .add(Duration(days: index))
                  .formatDateTime('yyyy-MM-dd')),
        );
        if (slots == null) {
          slotsInDay = FixedSlot.values
              .map(
                (e) => SlotInDayModel(
                  fixedSlot: e,
                  isAvailable: false,
                  nextDay: index,
                ),
              )
              .toList();
        } else {
          slotsInDay = mapSlotsInDay(slots);
        }
        return slotsInDay;
      });
    }
    doctorSlots.refresh();
  }

  List<SlotInDayModel> mapSlotsInDay(DoctorSlotsResponse? response) {
    List<SlotInDayModel> slotsInDay;
    final int nextDay = (response?.date ?? '')
        .parseDateTime('yyyy-MM-dd')
        .difference(now.value)
        .inDays;
    slotsInDay = List.generate(
      response?.slots?.length ?? 0,
      (i) => SlotInDayModel(
        fixedSlot: FixedSlot.values[response?.slots?[i] ?? 0],
        isAvailable: true,
        nextDay: nextDay,
      ),
    );
    for (var fixedSlot in FixedSlot.values) {
      if (slotsInDay.firstWhereOrNull((slot) => slot.fixedSlot == fixedSlot) ==
          null) {
        slotsInDay.add(
          SlotInDayModel(
              fixedSlot: fixedSlot, isAvailable: false, nextDay: nextDay),
        );
      }
    }
    slotsInDay.sort((a, b) => a.fixedSlot.index.compareTo(b.fixedSlot.index));
    return slotsInDay;
  }

  void onSelectedDoctorSlots(List<List<SlotInDayModel>>? slots) {
    doctorSlots.value = slots ?? [];
    doctorSlots.refresh();
  }

  void onUpdateDoctorSlots() {
    List<DoctorSlotsRequest> requests = doctorSlots.value
        .asMap()
        .map(
          (key, slots) {
            List<int> slotNum = [];
            for (var slot in slots) {
              if (slot.isAvailable ?? false) {
                slotNum.add(slot.fixedSlot.index);
              }
            }
            final doctorSlotsRequest = DoctorSlotsRequest(
              availabilitySlots: slotNum,
              doctorId: localAuthRepo.userId(),
              registerDate: now.value
                  .add(Duration(days: key))
                  .formatDateTime('yyyy-MM-dd'),
            );
            return MapEntry(key, doctorSlotsRequest);
          },
        )
        .values
        .toList();
    setDoctorSlots(requests);
  }

  Future<void> setDoctorSlots(List<DoctorSlotsRequest> requests) async {
    final response =
        await doctorSlotsRepo.setDoctorSlots(doctorSlotsRequests: requests);
    response.fold(
      (l) => AppHelper.showErrorMessage('Update Slots', l),
      (r) => Get.dialog(
        AlertDialog(
          content: Text(r),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            FilledButton(
              onPressed: Get.back,
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> fetchDoctorSlots() async {
    EasyLoading.show();
    final response = await doctorSlotsRepo.getDoctorSlots(
      doctorGetSlotsRequest: DoctorGetSlotsRequest(
        startDate: now.value.formatDateTime('yyyy-MM-dd'),
        endDate: now.value
            .add(
              const Duration(days: IntConstant.maxDay),
            )
            .formatDateTime('yyyy-MM-dd'),
      ),
    );
    EasyLoading.dismiss();
    return response.fold((l) {
      AppHelper.showErrorMessage('Doctor Slots', l);
      return false;
    }, (r) {
      r.sort(
        (a, b) => (a.date == null || b.date == null)
            ? 0
            : a.date!.parseDateTime('yyyy-MM-dd').compareTo(
                  b.date!.parseDateTime('yyyy-MM-dd'),
                ),
      );
      mapSlots(r);
      return true;
    });
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    call = fetchDoctorSlots();
  }
}
