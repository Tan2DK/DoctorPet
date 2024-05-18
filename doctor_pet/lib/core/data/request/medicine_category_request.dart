import 'dart:convert';

import 'package:doctor_pet/core/data/response/medicine_category_response.dart';

class MedicineCategoryRequest {
  final String? id;
  final String? name;
  MedicineCategoryRequest({
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'medicineCateId': id});
    }
    if (name != null) {
      result.addAll({'categoryName': name});
    }

    return result;
  }

  factory MedicineCategoryRequest.fromMap(Map<String, dynamic> map) {
    return MedicineCategoryRequest(
      id: map['medicineCateId'],
      name: map['categoryName'],
    );
  }
  factory MedicineCategoryRequest.fromResponse(
          MedicineCategoryResponse response) =>
      MedicineCategoryRequest(id: response.id, name: response.name);

  String toJson() => json.encode(toMap());

  factory MedicineCategoryRequest.fromJson(String source) =>
      MedicineCategoryRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'MedicineCategoryRequest(medicineCateId: $id, categoryName: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MedicineCategoryRequest &&
        other.id == id &&
        other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  MedicineCategoryRequest copyWith({
    String? id,
    String? name,
  }) {
    return MedicineCategoryRequest(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
