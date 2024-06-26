import 'package:doctor_pet/core/data/argument/customer_booking_argument.dart';
import 'package:doctor_pet/core/data/argument/doctor_schedule_argument.dart';
import 'package:doctor_pet/utils/app_enum.dart';
import 'package:doctor_pet/utils/app_extension.dart';
import 'package:doctor_pet/views/schedule/widgets/shedule_slot_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/data/slot_in_day_model.dart';
import 'widgets/slot_widget.dart';

class ScheduleController extends GetxController {
  DateTime now = DateTime.now().dateOnly;
  Rx<DateTime> selectedDay = Rx(DateTime.now().dateOnly);
  dynamic argument;
  Function(SlotInDayModel?)? onSelectedSlotInDay;
  Function(List<List<SlotInDayModel>>?)? onDoctorSelectedSlot;
  ScheduleController({this.argument});
  Rxn<CustomerBookingArgument> customerBookingArgument =
      Rxn<CustomerBookingArgument>();
  Rxn<DoctorScheduleArgument> doctorScheduleArgument =
      Rxn<DoctorScheduleArgument>();
  Rx<double> pageWidth = Rx<double>(0);
  Rx<List<List<SlotInDayModel>>> list = Rx([]);

  final PageController pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);

  void onShowScheduleSlot() {
    Get.dialog(
      Dialog(
        child: Obx(
          () => ScheduleSlotWidget(
            slotTime: list.value,
            selectedDay: selectedDay.value,
            onChangedCalendarPage: onChangedCalendarPage,
            pageController: pageController,
            onChangedPage: onPageChange,
            setPageWidth: setPageWidth,
            onChecked: onChecked,
            buildSlotTableWidget: buildSlotTableWidget,
          ),
        ),
      ),
    );
  }

  void onChecked(SlotInDayModel slotInDay) {
    if ((slotInDay.isAvailable == false &&
            list.value.any(
                (slots) => slots.any((slot) => slot.isAvailable == true)) &&
            customerBookingArgument.value != null) ||
        slotInDay.isAvailable == null) {
      return;
    }
    list.value[slotInDay.nextDay][slotInDay.fixedSlot.index] = list
        .value[slotInDay.nextDay][slotInDay.fixedSlot.index]
        .copyWith(isAvailable: !slotInDay.isAvailable!);
    list.refresh();
    onDoctorSelectedSlot?.call(list.value);
    if (list.value[slotInDay.nextDay][slotInDay.fixedSlot.index].isAvailable ==
        false) {
      onSelectedSlotInDay?.call(null);
      return;
    }
    onSelectedSlotInDay
        ?.call(list.value[slotInDay.nextDay][slotInDay.fixedSlot.index]);
  }

  void onPageChange(int page) {
    if (page == 0) {
      selectedDay.value = now;
      return;
    }
    selectedDay.value =
        now.add(Duration(days: (7 * page) - DateTime.now().weekday + 1));
  }

  List<Widget> buildSlotTableWidget() {
    final pageNumber = ((now.weekday + list.value.length - 1) / 7).ceil();
    List<Widget> listWidget = [];
    listWidget = list.value
        .asMap()
        .map((index1, slotsInDay) => MapEntry(
              index1,
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: slotsInDay
                      .asMap()
                      .map((index2, slot) => MapEntry(
                            index2,
                            SlotWidget(
                              doctorSlotInDay: slot,
                              width: pageWidth.value / 7,
                              onChecked: () => onChecked.call(slot),
                            ),
                          ))
                      .values
                      .toList()),
            ))
        .values
        .toList();
    listWidget = [
      ...List.filled(
        now.weekday - 1,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: FixedSlot.values
              .map((_) => SlotWidget(width: pageWidth.value / 7))
              .toList(),
        ),
      ),
      ...listWidget,
    ];
    listWidget = [
      ...listWidget,
      ...List.filled(
        7 * pageNumber - listWidget.length,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: FixedSlot.values
              .map((_) => SlotWidget(width: pageWidth.value / 7))
              .toList(),
        ),
      ),
    ];
    return listWidget;
  }

  void setPageWidth(double pw) => pageWidth.value = pw;

  void onChangedCalendarPage(DateTime focused) {
    selectedDay.value = focused;
    int page = (selectedDay.value.difference(now).inDays / 7).ceil();
    if (pageController.offset % pageWidth.value != 0) return;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    if (argument == null) return;
    switch (argument.runtimeType) {
      case CustomerBookingArgument:
        customerBookingArgument.value = argument as CustomerBookingArgument;
        onSelectedSlotInDay = customerBookingArgument.value?.onSelectedSlot;
        mapSlot(customerBookingArgument.value?.availableSlots ?? []);
        customerBookingArgument.value?.onRefreshDoctorSlot?.call(mapSlot);
        break;
      case DoctorScheduleArgument:
        doctorScheduleArgument.value = argument as DoctorScheduleArgument;
        final doctorAvailableSlot =
            doctorScheduleArgument.value?.availableSlots ?? [];
        onDoctorSelectedSlot = doctorScheduleArgument.value?.onSelectedSlots;
        list.value = doctorAvailableSlot;
        break;
    }
  }

  void mapSlot(List<List<SlotInDayModel>> slots) {
    list.value = slots
        .map((slotsInDay) => slotsInDay
            .map((slot) =>
                (slot.isAvailable == null || slot.isAvailable == false)
                    ? slot.copyWith(isAvailable: null)
                    : slot.copyWith(isAvailable: false))
            .toList())
        .toList();
  }
}
