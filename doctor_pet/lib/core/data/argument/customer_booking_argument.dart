import '../slot_in_day_model.dart';

class CustomerBookingArgument {
  final List<List<SlotInDayModel>> availableSlots;
  final Function(SlotInDayModel?)? onSelectedSlot;
  final Function(Function(List<List<SlotInDayModel>>))? onRefreshDoctorSlot;
  CustomerBookingArgument({
    required this.availableSlots,
    required this.onSelectedSlot,
    this.onRefreshDoctorSlot,
  });
}
