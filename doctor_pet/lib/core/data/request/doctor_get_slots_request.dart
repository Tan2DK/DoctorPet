import 'dart:convert';

class DoctorGetSlotsRequest {
  final String startDate;
  final String endDate;
  DoctorGetSlotsRequest({
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'startDate': startDate});
    result.addAll({'endDate': endDate});

    return result;
  }

  factory DoctorGetSlotsRequest.fromMap(Map<String, dynamic> map) {
    return DoctorGetSlotsRequest(
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorGetSlotsRequest.fromJson(String source) =>
      DoctorGetSlotsRequest.fromMap(json.decode(source));

  String toUrlParameter() => '$startDate/$endDate';
}
