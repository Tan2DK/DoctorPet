import 'package:doctor_pet/views/clinic_manager/invoice_report/invoice_report_binding.dart';
import 'package:doctor_pet/views/clinic_manager/invoice_report/invoice_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_routes.dart';

class NestedNavigationClinicInvoice extends StatelessWidget {
  const NestedNavigationClinicInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(RoutesName.nestedNavClinicInvoice),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        return GetPageRoute(
          settings: settings,
          binding: InvoiceReportBinding(),
          page: () => const InvoiceReportView(),
        );
      },
    );
  }
}
