import 'dart:convert';

class StatisticByClinicRequest {
  final String? startDate;
  final String? endDate;
  final String? clinicId;
  StatisticByClinicRequest({
    this.startDate,
    this.endDate,
    this.clinicId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(startDate != null){
      result.addAll({'startDate': startDate});
    }
    if(endDate != null){
      result.addAll({'endDate': endDate});
    }
    if(clinicId != null){
      result.addAll({'clinicId': clinicId});
    }
  
    return result;
  }

  factory StatisticByClinicRequest.fromMap(Map<String, dynamic> map) {
    return StatisticByClinicRequest(
      startDate: map['startDate'],
      endDate: map['endDate'],
      clinicId: map['clinicId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticByClinicRequest.fromJson(String source) => StatisticByClinicRequest.fromMap(json.decode(source));

  @override
  String toString() => 'StatisticByClinicRequest(startDate: $startDate, endDate: $endDate, clinicId: $clinicId)';
}
