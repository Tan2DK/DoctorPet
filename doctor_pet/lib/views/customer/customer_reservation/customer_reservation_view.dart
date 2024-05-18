import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Condition;
import 'customer_reservation_controller.dart';
import 'widgets/appointment_card_widget.dart';

class CustomerReservationView extends GetView<CustomerReservationController> {
  const CustomerReservationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 80,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              expandedTitleScale: 1.2,
              titlePadding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
              title: Text(
                'Appointment',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: Obx(
              () => SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 350,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 300,
                ),
                itemBuilder: (context, index) {
                  final appointment = controller.appointments[index];
                  if (index < controller.appointments.length) {
                    return AppointmentCardWidget(
                      appointmentResponse: appointment,
                      bgColor:
                          controller.getBgColorByType(appointment.status ?? ''),
                      textColor: const Color(0xFF424242),
                    );
                  } else if (controller.canLoadMore.value) {
                    controller.getAppointmentList();
                    return const SizedBox();
                  }
                  return null;
                },
                itemCount: controller.appointments.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
