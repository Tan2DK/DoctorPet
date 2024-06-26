import 'package:doctor_pet/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Condition;
import 'package:responsive_framework/responsive_framework.dart';

import 'package:doctor_pet/utils/app_enum.dart';

import '../../../core/data/slot_in_day_model.dart';
import 'row_calendar_widget.dart';

class ScheduleSlotWidget extends StatelessWidget {
  const ScheduleSlotWidget({
    Key? key,
    this.selectedDay,
    required this.slotTime,
    this.onChangedPage,
    this.setPageWidth,
    this.onChangedCalendarPage,
    this.onChecked,
    this.buildSlotTableWidget,
    this.onSubmit,
    required this.pageController,
  }) : super(key: key);

  final DateTime? selectedDay;
  final List<List<SlotInDayModel>> slotTime;
  final Function(int)? onChangedPage;
  final Function(double)? setPageWidth;
  final Function(DateTime)? onChangedCalendarPage;
  final Function(SlotInDayModel)? onChecked;
  final List<Widget> Function()? buildSlotTableWidget;
  final Function()? onSubmit;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().dateOnly;
    final pageNumber = ((now.weekday + slotTime.length - 1) / 7).ceil();
    int lPadding = leftPadding(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 900,
        minWidth: 250,
        minHeight: 300,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          setPageWidth?.call(constraints.maxWidth - lPadding - 8);
          final heightEachRow = (constraints.maxWidth - lPadding - 8) / 7;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              RowCalendarWidget(
                constraints: constraints,
                lPadding: lPadding,
                slotTime: slotTime,
                onChangedCalendarPage: onChangedCalendarPage,
                selectedDay: selectedDay,
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          width: lPadding.toDouble(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: FixedSlot.values
                                .map(
                                  (e) => SizedBox(
                                    height: heightEachRow,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          slotText(context, e.getName),
                                        ).paddingSymmetric(horizontal: 4),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: heightEachRow * FixedSlot.values.length,
                            child: PageView.builder(
                              itemCount: pageNumber,
                              controller: pageController,
                              onPageChanged: onChangedPage,
                              itemBuilder: (context, index) {
                                List<Widget> list =
                                    buildSlotTableWidget?.call() ?? [];
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      list.sublist(7 * index, 7 * index + 7),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ).paddingSymmetric(horizontal: 4);
        },
      ),
    );
  }

  int leftPadding(BuildContext context) {
    return ResponsiveValue(
      context,
      conditionalValues: [
        const Condition.smallerThan(
          breakpoint: 400,
          value: 50,
        ),
      ],
      defaultValue: 90,
    ).value;
  }

  String slotText(BuildContext context, String text) {
    return ResponsiveValue(
      context,
      conditionalValues: [
        Condition.smallerThan(
          breakpoint: 400,
          value: text.replaceAll(':00', 'h'),
        ),
      ],
      defaultValue: text,
    ).value;
  }

  Size buttonSize(BuildContext context) {
    return ResponsiveValue(
      context,
      conditionalValues: [
        const Condition.equals(
          name: MOBILE,
          value: Size(70, 24),
        ),
        const Condition.equals(
          name: TABLET,
          value: Size(76, 36),
        ),
        const Condition.equals(
          name: DESKTOP,
          value: Size(90, 48),
        ),
      ],
      defaultValue: const Size(92, 52),
    ).value;
  }
}
