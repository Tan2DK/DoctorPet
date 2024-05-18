import 'dart:convert';

class ChangePasswordRequest {
  final String? oldPass;
  final String? newPass;
  ChangePasswordRequest({
    this.oldPass,
    this.newPass,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(oldPass != null){
      result.addAll({'oldPass': oldPass});
    }
    if(newPass != null){
      result.addAll({'newPass': newPass});
    }
  
    return result;
  }

  factory ChangePasswordRequest.fromMap(Map<String, dynamic> map) {
    return ChangePasswordRequest(
      oldPass: map['oldPass'],
      newPass: map['newPass'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordRequest.fromJson(String source) => ChangePasswordRequest.fromMap(json.decode(source));
}
