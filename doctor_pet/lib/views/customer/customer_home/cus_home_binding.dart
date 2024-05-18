
import 'package:get/get.dart';

import 'cus_home_controller.dart';

class CustomerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerHomeController>(() => CustomerHomeController());
  }
}
