import 'dart:convert';

class PrescriptionMedicineRequest {
  final String? medicineId;
  final String? name;
  final int? quantity;
  PrescriptionMedicineRequest({
    this.medicineId,
    this.name,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (medicineId != null) {
      result.addAll({'medicineId': medicineId});
    }
    if (quantity != null) {
      result.addAll({'quantity': quantity});
    }

    return result;
  }

  factory PrescriptionMedicineRequest.fromMap(Map<String, dynamic> map) {
    return PrescriptionMedicineRequest(
      medicineId: map['medicineId'],
      quantity: map['quantity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PrescriptionMedicineRequest.fromJson(String source) =>
      PrescriptionMedicineRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'PrescriptionMedicineRequest(medicineId: $medicineId, quantity: $quantity)';

  PrescriptionMedicineRequest copyWith({
    String? medicineId,
    String? name,
    int? quantity,
  }) {
    return PrescriptionMedicineRequest(
      medicineId: medicineId ?? this.medicineId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }
}
