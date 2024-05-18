import 'package:get/get.dart';
import 'package:doctor_pet/core/data/invoice.dart';

class DoctorInvoiceController extends GetxController {
  Rx<List<Invoice>> medicines = Rx<List<Invoice>>([]);
  Rx<List<Map<String, dynamic>>> selectedMedicines =
      Rx<List<Map<String, dynamic>>>([]);
}
