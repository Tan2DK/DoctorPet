import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:doctor_pet/views/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        localAuthRepo: Get.find<LocalAuthRepo>(),
      ),
    );
  }
}
