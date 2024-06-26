import 'package:flutter/material.dart';

import '../../../core/data/slot_in_day_model.dart';

class SlotWidget extends StatelessWidget {
  const SlotWidget({
    Key? key,
    this.doctorSlotInDay = const SlotInDayModel(),
    this.onChecked,
    required this.width,
  }) : super(key: key);
  final SlotInDayModel doctorSlotInDay;
  final Function()? onChecked;
  final double width;
  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onChecked == null || doctorSlotInDay.isAvailable == null
          ? null
          : () => onChecked?.call(),
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          border: Border.all(
            width: .5,
            color: colorTheme.outline,
          ),
          color: onChecked != null && doctorSlotInDay.isAvailable != null
              ? colorTheme.primaryContainer
              : colorTheme.errorContainer,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Icon(
            size: 30,
            onChecked != null && doctorSlotInDay.isAvailable != null
                ? doctorSlotInDay.isAvailable!
                    ? Icons.check_circle_outlined
                    : Icons.circle_outlined
                : Icons.close_rounded,
            color: onChecked != null && doctorSlotInDay.isAvailable != null
                ? colorTheme.primary
                : colorTheme.error,
          ),
        ),
      ),
    );
  }
}
