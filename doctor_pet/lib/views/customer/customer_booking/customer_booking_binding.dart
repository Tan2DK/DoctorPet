import 'package:doctor_pet/core/repos/clinic_repo.dart';
import 'package:doctor_pet/core/repos/customer_booking_repo.dart';
import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:doctor_pet/core/repos/pet_category_repo.dart';
import 'package:get/get.dart';

import '../../../core/repos/pet_repo.dart';
import 'customer_booking_controller.dart';

class CustomerBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerBookingController>(
      () => CustomerBookingController(
        customerBookingRepo: Get.find<CustomerBookingRepo>(),
        clinicRepo: Get.find<ClinicRepo>(),
        petCategoryRepo: Get.find<PetCategoryRepo>(),
        petRepo: Get.find<PetRepo>(),
        localAuthRepo: Get.find<LocalAuthRepo>(),
      ),
    );
  }
}
