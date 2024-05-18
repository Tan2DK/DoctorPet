import 'dart:developer';
import 'package:doctor_pet/core/repos/pet_category_repo.dart';
import 'package:doctor_pet/core/repos/pet_repo.dart';
import 'package:doctor_pet/core/repos/report_repo.dart';
import 'package:doctor_pet/core/services/repositories/pet_category_repo_impl.dart';
import 'package:doctor_pet/core/services/repositories/pet_repo_impl.dart';
import 'package:get/get.dart';
import '../repos/appointment_repo.dart';
import '../repos/auth_repo.dart';
import '../repos/clinic_repo.dart';
import '../repos/customer_booking_repo.dart';
import '../repos/degree_repo.dart';
import '../repos/doctor_repo.dart';
import '../repos/doctor_slots_repo.dart';
import '../repos/local_auth_repo.dart';
import '../repos/medicine_category_repo.dart';
import '../repos/medicine_repo.dart';
import '../repos/staff_repo.dart';
import '../repos/statistic_repo.dart';
import 'local_storages/auth_local_storages.dart';
import 'repositories/appointment_repo_impl.dart';
import 'repositories/auth_repo_impl.dart';
import 'repositories/clinic_repo_impl.dart';
import 'repositories/customer_booking_repo_impl.dart';
import 'repositories/degree_repo_impl.dart';
import 'repositories/doctor_repo_impl.dart';
import 'repositories/doctor_slots_repo_impl.dart';
import 'repositories/local_auth_repo_impl.dart';
import 'repositories/medicine_category_repo_impl.dart';
import 'repositories/medicine_repo_impl.dart';
import 'repositories/report_repo_impl.dart';
import 'repositories/staff_repo_impl.dart';
import 'repositories/statistic_repo_impl.dart';

class RepoServices {
  static Future<void> initServices() async {
    log('Starting repo services ...', name: 'RepoServices');
    log('All repo services started! ✅', name: 'RepoServices');
    Get.lazyPut<AuthRepo>(() => AuthRepoImpl(), fenix: true);
    Get.lazyPut<ClinicRepo>(() => ClinicRepoImpl(), fenix: true);
    Get.lazyPut<CustomerBookingRepo>(
      () => CustomerBookingRepoImpl(),
      fenix: true,
    );
    Get.lazyPut<LocalAuthRepo>(
      () => LocalAuthRepoImpl(
        authLocalStorage: Get.find<AuthLocalStorage>(),
      ),
      fenix: true,
    );
    Get.lazyPut<AppointmentRepo>(() => AppointmentRepoImpl(), fenix: true);
    Get.lazyPut<DoctorRepo>(() => DoctorRepoImpl(), fenix: true);
    Get.lazyPut<DoctorSlotsRepo>(() => DoctorSlotsRepoImpl(), fenix: true);
    Get.lazyPut<StaffRepo>(() => StaffRepoImpl(), fenix: true);
    Get.lazyPut<MedicineRepo>(() => MedicineRepoImpl(), fenix: true);
    Get.lazyPut<MedicineCategoryRepo>(() => MedicineCategoryRepoImpl(),
        fenix: true);
    Get.lazyPut<PetRepo>(() => PetRepoImpl(), fenix: true);
    Get.lazyPut<PetCategoryRepo>(() => PetCategoryRepoImpl(), fenix: true);
    Get.lazyPut<DegreeRepo>(() => DegreeRepoImpl(), fenix: true);
    Get.lazyPut<ReportRepo>(() => ReportRepoImpl(), fenix: true);
    Get.lazyPut<StatisticRepo>(() => StatisticRepoImpl(), fenix: true);
  }
}
