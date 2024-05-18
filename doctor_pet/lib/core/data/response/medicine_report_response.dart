import 'dart:convert';

class MedicineReportResponse {
  final String? medicineName;
    final String? unit;
    final double? quantity;
    final double? price;
    final double? totalPrice;
  MedicineReportResponse({
    this.medicineName,
    this.unit,
    this.quantity,
    this.price,
    this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(medicineName != null){
      result.addAll({'medicineName': medicineName});
    }
    if(unit != null){
      result.addAll({'unit': unit});
    }
    if(quantity != null){
      result.addAll({'quantity': quantity});
    }
    if(price != null){
      result.addAll({'price': price});
    }
    if(totalPrice != null){
      result.addAll({'totalPrice': totalPrice});
    }
  
    return result;
  }

  factory MedicineReportResponse.fromMap(Map<String, dynamic> map) {
    return MedicineReportResponse(
      medicineName: map['medicineName'],
      unit: map['unit'],
      quantity: map['quantity'],
      price: map['price'],
      totalPrice: map['totalPrice'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicineReportResponse.fromJson(String source) => MedicineReportResponse.fromMap(json.decode(source));

  MedicineReportResponse copyWith({
    String? medicineName,
    String? unit,
    double? quantity,
    double? price,
    double? totalPrice,
  }) {
    return MedicineReportResponse(
      medicineName: medicineName ?? this.medicineName,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  String toString() {
    return 'MedicineReportResponse(medicineName: $medicineName, unit: $unit, quantity: $quantity, price: $price, totalPrice: $totalPrice)';
  }
}
