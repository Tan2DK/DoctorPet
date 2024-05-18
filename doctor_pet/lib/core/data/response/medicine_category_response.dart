import 'dart:convert';

class MedicineCategoryResponse {
  final String? id;
 final String? name;
  MedicineCategoryResponse({
    this.id,
    this.name,
  });
 

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'medicineCateId': id});
    }
    if(name != null){
      result.addAll({'categoryName': name});
    }
  
    return result;
  }

  factory MedicineCategoryResponse.fromMap(Map<String, dynamic> map) {
    return MedicineCategoryResponse(
      id: map['medicineCateId'],
      name: map['categoryName'],
    );
  }
  factory MedicineCategoryResponse.fromRepsponse(Map<String, dynamic> map) {
    return MedicineCategoryResponse(
      id: map['medicineCateId'],
      name: map['categoryName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicineCategoryResponse.fromJson(String source) => MedicineCategoryResponse.fromMap(json.decode(source));

  @override
  String toString() => 'MedicineCategoryRequest(medicineCateId: $id, categoryName: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MedicineCategoryResponse &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  MedicineCategoryResponse copyWith({
    String? id,
    String? name,
  }) {
    return MedicineCategoryResponse(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
