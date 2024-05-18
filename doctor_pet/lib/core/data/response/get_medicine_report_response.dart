import 'dart:convert';
import 'package:doctor_pet/core/data/response/medicine_report_response.dart';

class GetMedicineReportResponse {
  final double? duePrice;
  final List<MedicineReportResponse>? medicineReport;

  GetMedicineReportResponse({
    this.duePrice,
    this.medicineReport,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (duePrice != null) {
      result.addAll({'duePrice': duePrice});
    }
    if (medicineReport != null) {
      result.addAll(
          {'medicineReport': medicineReport!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory GetMedicineReportResponse.fromMap(Map<String, dynamic> map) {
    return GetMedicineReportResponse(
      duePrice: map['duePrice'],
      medicineReport: map['medicineReport'] != null
          ? List<MedicineReportResponse>.from(
              map['medicineReport']
                  ?.map((x) => MedicineReportResponse.fromMap(x))
                  .cast<MedicineReportResponse>(),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetMedicineReportResponse.fromJson(String source) =>
      GetMedicineReportResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetMedicineReportResponse(duePrice: $duePrice, medicineReport: $medicineReport)';
}
