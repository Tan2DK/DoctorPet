import 'dart:convert';

import 'package:equatable/equatable.dart';

class DegreeRequest extends Equatable {
  final String? degreeId;
  final String? degreeName;

  const DegreeRequest({
    this.degreeId,
    this.degreeName,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (degreeId != null) {
      result.addAll({'degreeId': degreeId});
    }
    if (degreeName != null) {
      result.addAll({'degreeName': degreeName});
    }

    return result;
  }

  factory DegreeRequest.fromMap(Map<String, dynamic> map) {
    return DegreeRequest(
      degreeId: map['degreeId'],
      degreeName: map['degreeName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DegreeRequest.fromJson(String source) =>
      DegreeRequest.fromMap(json.decode(source));

  DegreeRequest copyWith({
    String? degreeId,
    String? degreeName,
  }) {
    return DegreeRequest(
      degreeId: degreeId ?? this.degreeId,
      degreeName: degreeName ?? this.degreeName,
    );
  }

  @override
  String toString() {
    return 'DegreeRequest(degreeId: $degreeId, degreeName: $degreeName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DegreeRequest &&
        other.degreeId == degreeId &&
        other.degreeName == degreeName;
  }

  @override
  int get hashCode => degreeId.hashCode ^ degreeName.hashCode;

  @override
  List<Object?> get props => [degreeId, degreeName];
}
