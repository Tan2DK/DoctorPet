import 'package:doctor_pet/core/repos/appointment_repo.dart';
import 'package:get/get.dart';

import 'customer_reservation_controller.dart';

class CustomerReservationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerReservationController>(
      () => CustomerReservationController(
        appointmentRepo: Get.find<AppointmentRepo>(),
      ),
    );
  }
}
