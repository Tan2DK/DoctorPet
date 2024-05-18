import 'dart:convert';

class MedicineResponse {
  final String? medicineId;
  final String? medicineName;
  final String? medicineUnit;
  final int? prices;
  final int? inventory;
  final String? specifications;
  final String? medicineCateId;
  final String? medicineCateName;
  MedicineResponse({
    this.medicineId,
    this.medicineName,
    this.medicineUnit,
    this.prices,
    this.inventory,
    this.specifications,
    this.medicineCateId,
    this.medicineCateName,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(medicineId != null){
      result.addAll({'medicineId': medicineId});
    }
    if(medicineName != null){
      result.addAll({'medicineName': medicineName});
    }
    if(medicineUnit != null){
      result.addAll({'medicineUnit': medicineUnit});
    }
    if(prices != null){
      result.addAll({'prices': prices});
    }
    if(inventory != null){
      result.addAll({'inventory': inventory});
    }
    if(specifications != null){
      result.addAll({'specifications': specifications});
    }
    if(medicineCateId != null){
      result.addAll({'medicineCateId': medicineCateId});
    }
    if(medicineCateName != null){
      result.addAll({'medicineCateName': medicineCateName});
    }
  
    return result;
  }

  factory MedicineResponse.fromMap(Map<String, dynamic> map) {
    return MedicineResponse(
      medicineId: map['medicineId'],
      medicineName: map['medicineName'],
      medicineUnit: map['medicineUnit'],
      prices: map['prices'],
      inventory: map['inventory'],
      specifications: map['specifications'],
      medicineCateId: map['medicineCateId'],
      medicineCateName: map['medicineCateName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicineResponse.fromJson(String source) => MedicineResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MedicineRequest(medicineId: $medicineId, medicineName: $medicineName, medicineUnit: $medicineUnit, prices: $prices, inventory: $inventory, specifications: $specifications, medicineCateId: $medicineCateId, medicineCateName: $medicineCateName)';
  }
}
