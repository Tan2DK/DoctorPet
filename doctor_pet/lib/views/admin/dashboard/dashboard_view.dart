import 'package:doctor_pet/utils/app_extension.dart';
import 'package:doctor_pet/views/admin/dashboard/dashboard_controller.dart';
import 'package:doctor_pet/views/admin/dashboard/widgets/chart_widget.dart';
import 'package:doctor_pet/views/admin/dashboard/widgets/dashboard_report_item.dart';
import 'package:doctor_pet/common_widget/select_clinic_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/doctor_table_widget.dart';
import 'widgets/staff_table_widget.dart';

class DashBoardView extends GetView<DashboardController> {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome Admin!',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Dashboard',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Obx(
                  () => SelectClinicWidget(
                    clinic: controller.selectedClinic.value,
                    clinicList: controller.clinicList.value,
                    onClinicSelected: controller.onClinicSelected,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => DashBoardReportItem(
                        model: 'Doctor',
                        number: controller.totalDoctor.value.toString(),
                        icon: Icons.person,
                        color: Colors.blue,
                        onTabChanged: () => controller.onTabChanged(0),
                      )),
                  Obx(() => DashBoardReportItem(
                        model: 'Staff',
                        number: controller.totalStaff.value.toString(),
                        icon: Icons.person,
                        color: Colors.green,
                        onTabChanged: () => controller.onTabChanged(1),
                      )),
                  Obx(() => DashBoardReportItem(
                        model: 'Appointment',
                        number: controller.appointmentCount.value.toString(),
                        icon: Icons.medical_information_outlined,
                        color: Colors.red,
                        onTabChanged: () => controller.onTabChanged(2),
                      )),
                  Obx(() => DashBoardReportItem(
                        model: 'Revenue',
                        number: controller.revenue.value.toString(),
                        icon: Icons.attach_money_outlined,
                        color: Colors.yellow,
                        onTabChanged: () => controller.onTabChanged(3),
                      )),
                ],
              ),
              const SizedBox(height: 30),
              Obx(
                () => IndexedStack(
                  index: controller.tabIndex.value,
                  children: [
                    DoctorTableWidget(
                      doctorList: controller.doctorList.value,
                    ),
                    StaffTableWidget(
                      staffList: controller.staffList.value,
                    ),
                    Column(
                      children: [
                        dateRangeSelected(context: context),
                        const SizedBox(height: 16),
                        Obx(
                          () => controller.appointmentCount.value != 0
                              ? ChartWidget(
                                  barChartGroupData: controller.chartMapper,
                                  length: controller
                                      .appointmentStatisticList.value.length,
                                  startDate: controller.startDate.value,
                                )
                              : Text(
                                  'No data currently.',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                        ),
                      ],
                    ),
                    dateRangeSelected(context: context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dateRangeSelected({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Start Day:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 8),
        Obx(
          () => FilledButton.tonalIcon(
            onPressed: () async {
              final date = await controller.selectDate(
                context,
                controller.startDate.value,
                false,
              );
              if (date == null) return;
              controller.startDate.value = date;
              controller.fetchAppointmentStatistics();
              controller.fetchMoneyStatistics();
            },
            icon: const Icon(Icons.calendar_month_outlined),
            label: Text(
              controller.startDate.value.formatDateTime('dd-MM-yyyy'),
            ),
          ),
        ),
        const SizedBox(width: 32),
        const Text(
          'End Day:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 16),
        Obx(
          () => FilledButton.tonalIcon(
            onPressed: () async {
              final date = await controller.selectDate(
                context,
                controller.endDate.value,
                true,
              );
              if (date == null) return;
              controller.endDate.value = date;
              controller.fetchAppointmentStatistics();
              controller.fetchMoneyStatistics();
            },
            icon: const Icon(Icons.calendar_month_outlined),
            label: Text(
              controller.endDate.value.formatDateTime('dd-MM-yyyy'),
            ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
