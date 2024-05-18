import 'dart:convert';

import 'package:doctor_pet/core/data/response/staff_response.dart';

class GetStaffsResponse {
  final int? totalStaff;
  final List<StaffResponse>? staffs;

  GetStaffsResponse({
    this.totalStaff,
    this.staffs,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (totalStaff != null) {
      result.addAll({'totalStaff': totalStaff});
    }
    if (staffs != null) {
      result.addAll({'staffs': staffs!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory GetStaffsResponse.fromMap(Map<String, dynamic> map) {
    return GetStaffsResponse(
      totalStaff: map['totalStaff'],
      staffs: map['staffs'] != null
          ? List<StaffResponse>.from(
              map['staffs']
                  ?.map((x) => StaffResponse.fromMap(x))
                  .cast<StaffResponse>(),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetStaffsResponse.fromJson(String source) =>
      GetStaffsResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetStaffsResponse(totalStaff: $totalStaff, staffs: $staffs)';
}
