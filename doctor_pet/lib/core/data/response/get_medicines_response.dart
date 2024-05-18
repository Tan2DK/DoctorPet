import 'dart:convert';

import 'medicine_response.dart';

class GetMedicinesResponse {
  final int? totalMedicine;
  final List<MedicineResponse>? medicines;

  GetMedicinesResponse({
    this.totalMedicine,
    this.medicines,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (totalMedicine != null) {
      result.addAll({'totalMedicine': totalMedicine});
    }
    if (medicines != null) {
      result.addAll({'medicines': medicines!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory GetMedicinesResponse.fromMap(Map<String, dynamic> map) {
    return GetMedicinesResponse(
      totalMedicine: map['totalMedicine'],
      medicines: map['medicines'] != null
          ? List<MedicineResponse>.from(
              map['medicines']
                  ?.map((x) => MedicineResponse.fromMap(x))
                  .cast<MedicineResponse>(),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetMedicinesResponse.fromJson(String source) =>
      GetMedicinesResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetMedicinesResponse(totalMedicine: $totalMedicine, medicines: $medicines)';
}
