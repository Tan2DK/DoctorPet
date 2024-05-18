import 'package:doctor_pet/utils/app_enum.dart';
import 'package:doctor_pet/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:doctor_pet/common_widget/data_title_widget.dart';
import 'package:get/get.dart';
import '../../../core/data/data_title_model.dart';
import 'doctor_appointment_controller.dart';
import 'widgets/appointment_drawer.dart';

class DoctorAppointmentView extends GetView<DoctorAppointmentController> {
  const DoctorAppointmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const titleTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      height: 1,
    );
    final primary = Theme.of(context).primaryColor;
    return Scaffold(
      endDrawer: const AppointmentDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: controller.decreaseDate,
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: primary,
                ),
              ),
              SizedBox(
                height: 48,
                width: 200,
                child: Obx(
                  () => TextButton.icon(
                    onPressed: () => controller.selectDate(context),
                    icon: const Icon(Icons.calendar_month_rounded),
                    label: Text(
                      controller.date.value.formatDateTime('dd-MM-yyyy'),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: controller.increaseDate,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: primary,
                ),
              ),
            ],
          ).paddingOnly(right: 24),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DataTitleWidget(
                  style: titleTextStyle,
                  leftSpacing: 32,
                  verticalPadding: 12,
                  bgColor: const Color(0xFFEFF0F1),
                  titles: [
                    DataTitleModel(name: 'Time', flex: 2),
                    DataTitleModel(name: 'Pet Information', flex: 4),
                    DataTitleModel(name: 'Customer Information', flex: 4),
                    DataTitleModel(name: 'Reason', flex: 3),
                    DataTitleModel(name: 'Status', flex: 1),
                  ],
                ),
              ),
            ],
          ),
          const Divider(thickness: 2, height: 0),
          Expanded(
            child: Obx(
              () {
                final data = controller.appointments.value;
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0),
                  itemBuilder: (context, index) => Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            Expanded(
                              child: DataTitleWidget(
                                onTap: () =>
                                    controller.showDrawer(context, data[index]),
                                leftSpacing: 32,
                                verticalPadding: 8,
                                titles: [
                                  DataTitleModel(
                                      name: data[index].slot == null
                                          ? ''
                                          : FixedSlot.values
                                              .elementAt(data[index].slot!)
                                              .getName,
                                      flex: 2),
                                  DataTitleModel(
                                      name: data[index].pet?.petName ?? '',
                                      flex: 4),
                                  DataTitleModel(
                                      name: data[index].customer == null
                                          ? ''
                                          : data[index].customer!.toDataTable(),
                                      flex: 4),
                                  DataTitleModel(
                                      name: data[index].reason ?? '', flex: 3),
                                  DataTitleModel(
                                      name: data[index].status ?? '', flex: 1),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  itemCount: data.length,
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFFEFF0F1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 176),
                Text(
                  '${controller.firstIndexItem} - ${controller.lastIndexItem} / ${controller.total}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: controller.onFirstPage,
                      icon: const Icon(
                        Icons.first_page_rounded,
                      ),
                    ),
                    IconButton(
                      onPressed: controller.onPreviousPage,
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: controller.onNextPage,
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: controller.onLastPage,
                      icon: const Icon(
                        Icons.last_page_rounded,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
