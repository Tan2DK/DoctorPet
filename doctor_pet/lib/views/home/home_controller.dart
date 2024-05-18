import 'package:doctor_pet/views/home/nested_navigation/admin/nested_navigation_admin_medicine_report.dart';
import 'package:doctor_pet/views/home/nested_navigation/doctor/nested_navigation_doctor_appointment.dart';
import 'package:doctor_pet/views/home/nested_navigation/doctor/nested_navigation_doctor_schedule.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/repos/local_auth_repo.dart';
import 'package:doctor_pet/views/home/nested_navigation/admin/nested_navigation_admin_medicine_category.dart';
import 'package:doctor_pet/views/home/nested_navigation/admin/nested_navigation_admin_pet_category.dart';
import 'package:doctor_pet/views/home/nested_navigation/admin/nested_navigation_dashboard.dart';
import 'package:doctor_pet/views/home/nested_navigation/clinic_manager/nested_navigation_clinic_doctor.dart';
import 'package:doctor_pet/views/home/nested_navigation/clinic_manager/nested_navigation_clinic_medicince_report.dart';
import 'package:doctor_pet/views/home/nested_navigation/clinic_manager/nested_navigation_clinic_medicine.dart';
import 'package:doctor_pet/views/home/nested_navigation/clinic_manager/nested_navigation_clinic_pet_category.dart';
import 'package:doctor_pet/views/home/nested_navigation/clinic_manager/nested_navigation_clinic_staff.dart';

import '../../utils/app_enum.dart';
import '../../utils/app_helper.dart';
import '../../utils/app_routes.dart';
import 'nested_navigation/admin/nested_navigation_clinic.dart';
import 'nested_navigation/staff/nested_navigation_staff_appointment.dart';

class HomeController extends GetxController {
  RxInt index = RxInt(0);
  Rx<Role> role = Rx<Role>(Role.admin);
  final LocalAuthRepo localAuthRepo;
  HomeController({
    required this.localAuthRepo,
  });

  final adminTabNameList = [
    'Dashboard',
    'Clinic Management',
    'Pet Category Management',
    'Medicine Category Management',
    'Medicine Report',
  ];
  final clinicTabNameList = [
    'Doctor Management',
    'Staff Management',
    // 'Invoice Management',
    'Medicine Management',
    'Medicine Report',
    'Pet Category Management',
  ];
  final doctorTabNameList = [
    'Schedule Management',
    'Appointment Management',
  ];
  final staffTabNameList = [
    'Appointment Management',
  ];

  final adminViewList = [
    const NestedNavigationDashboard(),
    const NestedNavigationClinic(),
    const NestedNavigationAdminPetCategory(),
    const NestedNavigationAdminMedicineCategory(),
    const NestedNavigationAdminMedicineReport(),
  ];
  final customerTabNameList = [
    'ViewPet',
    'Dashboard',
    'Appointment',
    'Medical history',
    'Ask Doctor',
    'Search Clinic',
  ];

  final clinicManagerViewList = [
    const NestedNavigationClinicDoctor(),
    const NestedNavigationClinicStaff(),
    // const NestedNavigationClinicInvoice(),
    const NestedNavigationClinicMedicine(),
    const NestedNavigationClinicMedicineReport(),
    const NestedNavigationClinicPetCategory(),
  ];

  final doctorViewList = [
    const NestedNavigationDoctorSchedule(),
    const NestedNavigationDoctorAppointment(),
  ];
  final staffViewList = [
    const NestedNavigationStaffAppointment(),
  ];

  void changeTab(int i) => index.value = i;

  List<String> get getTabListByRole => switch (role.value) {
        Role.admin => adminTabNameList,
        Role.clinicManager => clinicTabNameList,
        Role.customer => customerTabNameList,
        Role.doctor => doctorTabNameList,
        Role.staff => staffTabNameList,
      };

  List<Widget> listScreen() {
    return switch (role.value) {
      Role.doctor => doctorViewList,
      Role.clinicManager => clinicManagerViewList,
      Role.admin => adminViewList,
      Role.staff => staffViewList,
      _ => [],
    };
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    final roleAuth = localAuthRepo.getRole();
    if (roleAuth == null || roleAuth == Role.customer) {
      AppHelper.navigateNeedToAuth();
      return;
    }
    role.value = roleAuth;
  }

  Future<void> logout() async {
    await localAuthRepo.handleUnAuthorized();
    Get.offAllNamed(RoutesName.login);
  }
}
