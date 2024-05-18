import 'package:doctor_pet/views/admin/dashboard/dashboard_binding.dart';
import 'package:doctor_pet/views/admin/dashboard/dashboard_view.dart';

import '../views/opt/otp_binding.dart';
import '../views/opt/otp_view.dart';
import '../views/change_password/change_password_binding.dart';
import '../views/change_password/change_password_view.dart';
import '../views/customer/customer_home/cus_home_binding.dart';
import '../views/customer/customer_home/cus_home_view.dart';
import '../views/forgot_password/forgot_password_binding.dart';
import '../views/forgot_password/forgot_password_view.dart';
import '../views/login/login_binding.dart';
import '../views/login/login_view.dart';
import 'package:get/get.dart';
import '../views/clinic_manager/invoice_report/invoice_report_binding.dart';
import '../views/clinic_manager/invoice_report/invoice_report_view.dart';
import '../views/home/home_binding.dart';
import '../views/home/home_view.dart';
import '../views/register/register_binding.dart';
import '../views/register/register_view.dart';

class AppRoutes {
  AppRoutes._();

  static final mainRoutes = [
    GetPage(
      name: RoutesName.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RoutesName.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: RoutesName.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RoutesName.customerHome,
      page: () => const CustomerHomeView(),
      binding: CustomerHomeBinding(),
    ),
    GetPage(
      name: RoutesName.invoiceReport,
      page: () => const InvoiceReportView(),
      binding: InvoiceReportBinding(),
    ),
    GetPage(
      name: RoutesName.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: RoutesName.otp,
      page: () => const OtpView(),
      binding: OTPBinding(),
    ),
    GetPage(
      name: RoutesName.changePassword,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: RoutesName.dashboard,
      page: () => const DashBoardView(),
      binding: DashboardBinding(),
    ),
  ];
}

class RoutesName {
  static const String home = '/home';
  static const String register = '/register';
  static const String login = '/login';
  static const String invoiceReport = '/invoice-report';
  static const String customerHome = '/customer-home';
  static const String nestedNavClinic = 'nested_navigation_clinic';
  static const String nestedNavDashboard = 'nested_navigation_dashboard';
  static const String nestedNavAdminMedicineReport =
      'nested_navigation_admin_medicine_report';
  static const String nestedNavAdminMedicineCategory =
      'nested_navigation_admin_medicine_category';
  static const String nestedNavAdminPetCategory =
      'nested_navigation_admin_pet_category';
  static const String nestedNavCustomerBooking =
      'nested_navigation_customer_booking';
  static const String nestedNavCustomerAppointment =
      'nested_navigation_customer_appointment';
  static const String nestedNavCustomerInformation =
      'nested_navigation_customer_information';
  static const String nestedNavCustomerPet = 'nested_navigation_customer_pet';
  static const String nestedNavDoctorAppointment =
      'nested_navigation_doctor_appointment';
  static const String nestedNavDoctorSchedule =
      'nested_navigation_doctor_schedule';
  static const String nestedNavPet = 'nested_navigation_pet';
  static const String nestedNavDoctorMedicine =
      'nested_navigation_doctor_medicine';
  static const String nestedNavDoctorInvoice = 'nested_nav_doctor_invoice';
  static const String nestedNavStaffAppointment =
      'nested_nav_staff_appointment';
  static const String nestedNavClinicDoctor = 'nested_nav_clinic_doctor';
  static const String nestedNavClinicInvoice = 'nested_nav_clinic_invoice';
  static const String nestedNavClinicMedicine = 'nested_nav_clinic_medicine';
  static const String nestedNavClinicMedicineReport =
      'nested_nav_clinic_medicine_report';
  static const String nestedNavClinicPetCategory =
      'nested_nav_clinic_pet_category';
  static const String nestedNavClinicStaff = 'nested_nav_clinic_staff';
  static const String forgotPassword = '/forgot-password';
  static const String otp = '/otp';
  static const String changePassword = '/change-password';
  static const String dashboard = '/dashboard';
}
