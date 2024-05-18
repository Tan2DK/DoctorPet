import 'dart:math';

import '../../core/data/slot_in_day_model.dart';
import '../../utils/app_enum.dart';

class DoctorSlotInDayData {
  DoctorSlotInDayData._();
  static List<List<SlotInDayModel>> data = List.generate(
    3,
    (index1) => FixedSlot.values
        .asMap()
        .map(
          (index2, value) => MapEntry(
            index2,
            SlotInDayModel(
              fixedSlot: value,
              nextDay: index1,
              isAvailable: Random().nextBool(),
            ),
          ),
        )
        .values
        .toList(),
  );
}
