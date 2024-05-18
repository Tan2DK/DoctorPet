import 'dart:convert';

import 'package:equatable/equatable.dart';

class DegreeResponse extends Equatable {
  final String? degreeId;
  final String? degreeName;

  const DegreeResponse({
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

  factory DegreeResponse.fromMap(Map<String, dynamic> map) {
    return DegreeResponse(
      degreeId: map['degreeId'],
      degreeName: map['degreeName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DegreeResponse.fromJson(String source) =>
      DegreeResponse.fromMap(json.decode(source));

  DegreeResponse copyWith({
    String? degreeId,
    String? degreeName,
  }) {
    return DegreeResponse(
      degreeId: degreeId ?? this.degreeId,
      degreeName: degreeName ?? this.degreeName,
    );
  }

  @override
  String toString() {
    return 'DegreeResponse(degreeId: $degreeId, degreeName: $degreeName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DegreeResponse &&
        other.degreeId == degreeId &&
        other.degreeName == degreeName;
  }

  @override
  int get hashCode => degreeId.hashCode ^ degreeName.hashCode;

  @override
  List<Object?> get props => [degreeId, degreeName];
}
