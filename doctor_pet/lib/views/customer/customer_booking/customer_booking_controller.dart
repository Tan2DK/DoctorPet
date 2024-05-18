import 'dart:developer';

import 'package:doctor_pet/utils/app_constant.dart';
import 'package:doctor_pet/utils/app_helper.dart';
import 'package:doctor_pet/views/customer/customer_booking/widgets/delete_pet_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/booking_pet_model.dart';
import 'package:doctor_pet/core/data/clinic_model.dart';
import 'package:doctor_pet/core/data/request/create_booking_request.dart';
import 'package:doctor_pet/core/data/task_model.dart';
import 'package:doctor_pet/core/repos/customer_booking_repo.dart';
import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:doctor_pet/utils/app_enum.dart';
import 'package:doctor_pet/utils/app_extension.dart';
import 'package:doctor_pet/views/customer/customer_booking/widgets/booking_confirm_dialog.dart';
import 'package:doctor_pet/views/customer/customer_booking/widgets/register_pet_form_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/data/response/pet_category_response.dart';
import '../../../core/data/response/pet_response.dart';
import '../../../core/data/response/slots_in_day_response.dart';
import '../../../core/data/slot_in_day_model.dart';
import '../../../core/repos/clinic_repo.dart';
import '../../../core/repos/pet_category_repo.dart';
import '../../../core/repos/pet_repo.dart';

class CustomerBookingController extends GetxController {
  Rx<List<ClinicModel>> branchList = Rx([]);
  Rx<List<PetCategoryResponse>> petCategoryList =
      Rx<List<PetCategoryResponse>>([]);
  Rx<List<PetResponse>> petList = Rx<List<PetResponse>>([]);
  Rxn<PetResponse> selectedPet = Rxn<PetResponse>();
  final DateTime now = DateTime.now().dateOnly;
  final Rxn<ClinicModel> selectedBranch = Rxn<ClinicModel>();
  Rxn<SlotInDayModel> selectedSlot = Rxn<SlotInDayModel>();
  Rx<List<List<SlotInDayModel>>> doctorSlot =
      Rx<List<List<SlotInDayModel>>>([]);
  Rxn<BookingPetModel> bookingPet = Rxn();
  RxInt index = RxInt(0);
  bool isInit = false;
  Future<bool>? call;
  RxList<TaskModel> taskList = RxList<TaskModel>(TaskListModel.taskData);
  Position? myPos;

  TextEditingController dropdownController = TextEditingController();

  final CustomerBookingRepo customerBookingRepo;
  final ClinicRepo clinicRepo;
  final LocalAuthRepo localAuthRepo;
  final PetCategoryRepo petCategoryRepo;
  final PetRepo petRepo;

  CustomerBookingController({
    required this.customerBookingRepo,
    required this.clinicRepo,
    required this.localAuthRepo,
    required this.petCategoryRepo,
    required this.petRepo,
  });

  Future<void> onChanged(ClinicModel? clinic) async {
    if (selectedBranch.value == clinic) return;
    if (bookingPet.value != null ||
        selectedPet.value != null ||
        selectedSlot.value != null) {
      Get.dialog(
        DeletePetConfirmDialog(
          title: 'Change Clinic',
          content:
              'Change clinic will remove register pet and time slot. Are you sure to change?',
          onConfirm: () async {
            clearDataWhenChangedClinic(clinic);
          },
        ),
      );
      return;
    }
    selectedBranch.value = clinic;
    await fetchPetCategoriesByClinicId();
    await fetchPet();
    branchList.refresh();
    fetchDoctorSlotByBranch();
  }

  Future<void> clearDataWhenChangedClinic(ClinicModel? clinic) async {
    selectedBranch.value = clinic;
    onSelectedSlot(null);
    await fetchPetCategoriesByClinicId();
    await fetchPet();
    // onMoveCamera?.call(LatLng(branch.lat, branch.lng));
    branchList.refresh();
    fetchDoctorSlotByBranch();
    bookingPet.value = null;
    selectedPet.value = null;
    taskList[1] = taskList[1].copyWith(isComplete: false);
    taskList[2] = taskList[2].copyWith(isComplete: false);
    taskList[3] = taskList[3].copyWith(isComplete: false);
    taskList.refresh();
  }

  Function(LatLng)? onMoveCamera;
  Function(LatLng)? onDrawLine;
  Function(List<List<SlotInDayModel>>)? refreshDoctorSlot;

  void onSelectedSlot(SlotInDayModel? slotInDay) {
    selectedSlot.value = slotInDay;
    taskList[1] =
        taskList[1].copyWith(isComplete: slotInDay?.isAvailable ?? false);
    taskList.refresh();
  }

  void onSelectedPet(PetResponse? pet, BookingPetModel? bP) {
    selectedPet.value = pet;
    bookingPet.value = bP;
    taskList[2] = taskList[2].copyWith(isComplete: pet != null);
    taskList.refresh();
  }

  Future<void> onSubmit() async {
    if (selectedSlot.value == null) return;
    taskList[taskList.length - 1] =
        taskList[taskList.length - 1].copyWith(isComplete: true);
    taskList.refresh();
    await Get.dialog(
      BookingConfirmDialog(
        branch: selectedBranch.value,
        slotInDay: selectedSlot.value!,
        bookingPet: bookingPet.value,
        pet: selectedPet.value,
        onConfirm: onConfirm,
      ),
    );
    taskList[3] = taskList[3].copyWith(isComplete: false);
    taskList.refresh();
  }

  Future<bool> fetchData() async {
    await getCurrentLocation();
    await fetchClinic();
    await fetchPetCategoriesByClinicId();
    await fetchPet();
    if (selectedBranch.value?.id.isEmpty ?? true) return false;
    return await fetchDoctorSlotByBranch();
  }

  Future<bool> fetchDoctorSlotByBranch() async {
    EasyLoading.show();
    final res = await customerBookingRepo.getDoctorSlotByClinic(
      clinicId: selectedBranch.value!.id,
      startDate: now,
      endDate: now.add(const Duration(days: IntConstant.maxDay)),
    );
    EasyLoading.dismiss();
    return res.fold((l) => false, (r) {
      r.sort(
        (a, b) => (a.date == null || b.date == null)
            ? 0
            : a.date!.parseDateTime('yyyy-MM-dd').compareTo(
                  b.date!.parseDateTime('yyyy-MM-dd'),
                ),
      );
      bool isMapped = mappingSlots(r);
      if (isInit) {
        refreshDoctorSlot?.call(doctorSlot.value);
      }
      isInit = true;
      return isMapped;
    });
  }

  Future<bool> fetchClinic() async {
    EasyLoading.show();
    final res = await clinicRepo.getClinic();
    EasyLoading.dismiss();
    return res.fold((l) => false, (r) {
      return mapClinic(r);
    });
  }

  bool mapClinic(List<ClinicModel> clinics) {
    clinics = clinics
        .map((clinic) =>
            clinic.copyWith(distance: calculateRouteDistance(clinic)))
        .toList();
    clinics.sort((a, b) => (a.distance == null || b.distance == null)
        ? 0
        : a.distance!.compareTo(b.distance!));
    branchList.value = clinics;
    branchList.refresh();
    selectedBranch.value = branchList.value.first;
    final task = taskList[0].copyWith(isComplete: true);
    taskList[0] = task;
    taskList.refresh();
    return true;
  }

  bool mappingSlots(List<SlotsInDayResponse> slots) {
    if (slots.isEmpty) {
      doctorSlot.value = [
        FixedSlot.values
            .map(
              (e) => SlotInDayModel(
                fixedSlot: e,
                isAvailable: false,
                nextDay: 0,
              ),
            )
            .toList()
      ];
      return true;
    }
    doctorSlot.value = slots.map((slots) {
      List<SlotInDayModel> slotsInDay;
      int nextDay =
          slots.date?.parseDateTime('yyyy-MM-dd').difference(now).inDays ?? 0;
      slotsInDay = List.generate(
        slots.listSlotType?.length ?? 0,
        (index) => SlotInDayModel(
          fixedSlot: FixedSlot.values[slots.listSlotType?[index] ?? 0],
          isAvailable: true,
          nextDay: nextDay,
        ),
      );
      for (var fixedSlot in FixedSlot.values) {
        if (slotsInDay
                .firstWhereOrNull((slot) => slot.fixedSlot == fixedSlot) ==
            null) {
          slotsInDay.add(SlotInDayModel(
              fixedSlot: fixedSlot, isAvailable: false, nextDay: nextDay));
        }
      }
      slotsInDay.sort((a, b) => a.fixedSlot.index.compareTo(b.fixedSlot.index));
      return slotsInDay;
    }).toList();
    return true;
  }

  Future<void> onRegisterPet() async {
    if (!isInit) return;
    await Get.dialog(
      RegisterPetDialog(
        selectedPet: selectedPet.value,
        pets: petList.value,
        onSelectedPet: onSelectedPet,
        bookingPet: bookingPet.value,
        categories: petCategoryList.value,
        addEditBookingPet: (p) {
          bookingPet.value = p;
          taskList[2] = taskList[2].copyWith(isComplete: true);
          taskList.refresh();
          Get.back();
        },
        clearBookingPet: () {
          bookingPet.value = null;
          taskList[2] = taskList[2].copyWith(isComplete: false);
          taskList.refresh();
        },
      ),
    );
  }

  Future<bool> fetchPet() async {
    EasyLoading.show();
    final res = await petRepo.getPetByClinic(
      clinicId: selectedBranch.value?.id,
    );
    EasyLoading.dismiss();
    return res.fold((l) => false, (r) {
      petList.value = r ?? [];
      return true;
    });
  }

  @override
  void onInit() {
    super.onInit();
    call = fetchData();
  }

  Future<void> fetchPetCategoriesByClinicId() async {
    EasyLoading.show();
    final response = await petCategoryRepo.getPetCategoryByClinic(
        clinicId: selectedBranch.value?.id);
    EasyLoading.dismiss();

    response.fold(
      (l) => AppHelper.showErrorMessage('Get Pet Category', l),
      (r) => petCategoryList.value = r?.petTypeList ?? [],
    );
  }

  Future<void> onConfirm() async {
    final request = CreateBookingRequest(
      bookingPet: bookingPet.value,
      clinicId: selectedBranch.value?.id,
      petId: selectedPet.value?.petId,
      date: now
          .add(Duration(days: selectedSlot.value?.nextDay ?? 0))
          .formatDateTime('yyyy-MM-dd'),
      slot: selectedSlot.value?.fixedSlot.index,
    );
    EasyLoading.show();
    final res =
        await customerBookingRepo.booking(createBookingRequest: request);
    EasyLoading.dismiss();
    Get.back();
    res.fold((l) => AppHelper.showErrorMessage('Booking', l), (r) {
      Get.snackbar(
        'Booking',
        r,
        snackPosition: SnackPosition.BOTTOM,
      );
      selectedPet.value = null;
      selectedSlot.value = null;
      bookingPet.value = null;
      taskList[1] = taskList[1].copyWith(isComplete: false);
      taskList[2] = taskList[2].copyWith(isComplete: false);
      taskList[3] = taskList[3].copyWith(isComplete: false);
      taskList.refresh();
      refreshDoctorSlot?.call(doctorSlot.value);
    });
  }

  void showMap(int i, ClinicModel? branch) {
    index.value = i;
    if (i == 0 || branch?.lat == null || branch?.lng == null) return;
    onMoveCamera?.call(LatLng(branch!.lat, branch.lng));
  }

  void showDrawLine(int i, LatLng latLng) {
    index.value = i;
    onDrawLine?.call(latLng);
  }

  Future<void> getCurrentLocation() async {
    try {
      EasyLoading.show();
      myPos = await Geolocator.getCurrentPosition();
      EasyLoading.dismiss();
    } catch (e) {
      log(e.toString());
    }
  }

  double? calculateRouteDistance(ClinicModel clinic) {
    double? distance;
    if (myPos == null) {
      return distance;
    }
    distance = Geolocator.distanceBetween(
      myPos!.latitude,
      myPos!.longitude,
      clinic.lat,
      clinic.lng,
    );
    return distance;
  }
}
