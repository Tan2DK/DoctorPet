import 'dart:convert';

import 'prescription_medicine_request.dart';

class CreateBillingRequest {
  final String? appointmentId;
  final String? diagnose;
  final String? reason;
  final List<PrescriptionMedicineRequest>? prescriptionMedicines;
  CreateBillingRequest({
    this.appointmentId,
    this.diagnose,
    this.reason,
    this.prescriptionMedicines,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    final total = <String, dynamic>{};
    if (appointmentId != null) {
      result.addAll({'appointmentId': appointmentId});
    }
    if (diagnose != null) {
      result.addAll({'diagnose': diagnose});
    }
    if (reason != null) {
      result.addAll({'reason': reason});
    }
    total.addAll({'createDTO': result});
    if (prescriptionMedicines != null) {
      total.addAll({
        'prescriptionMedicines':
            prescriptionMedicines!.map((x) => x.toMap()).toList()
      });
    }
    return total;
  }

  factory CreateBillingRequest.fromMap(Map<String, dynamic> map) {
    return CreateBillingRequest(
      appointmentId: map['appointmentId'],
      diagnose: map['diagnose'],
      reason: map['reason'],
      prescriptionMedicines: map['prescriptionMedicines'] != null
          ? List<PrescriptionMedicineRequest>.from(map['prescriptionMedicines']
              ?.map((x) => PrescriptionMedicineRequest.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateBillingRequest.fromJson(String source) =>
      CreateBillingRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateBillingRequest(appointmentId: $appointmentId, diagnose: $diagnose, reason: $reason, prescriptionMedicines: $prescriptionMedicines)';
  }

  CreateBillingRequest copyWith({
    String? appointmentId,
    String? diagnose,
    String? reason,
    List<PrescriptionMedicineRequest>? prescriptionMedicines,
  }) {
    return CreateBillingRequest(
      appointmentId: appointmentId ?? this.appointmentId,
      diagnose: diagnose ?? this.diagnose,
      reason: reason ?? this.reason,
      prescriptionMedicines:
          prescriptionMedicines ?? this.prescriptionMedicines,
    );
  }
}
