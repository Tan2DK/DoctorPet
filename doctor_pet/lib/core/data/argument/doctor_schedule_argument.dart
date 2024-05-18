import '../slot_in_day_model.dart';

class DoctorScheduleArgument {
  final List<List<SlotInDayModel>> availableSlots;
  final Function(List<List<SlotInDayModel>>?)? onSelectedSlots;
  DoctorScheduleArgument({
    required this.availableSlots,
    this.onSelectedSlots,
  });
}
