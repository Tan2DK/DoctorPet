import 'dart:convert';

class JWTDecodeModel {
  final String? userName;
  final String? userId;
  final String? userRole;
  final int? exp;
  final String? iss;
  final String? aud;
  JWTDecodeModel({
    this.userName,
    this.userId,
    this.userRole,
    this.exp,
    this.iss,
    this.aud,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (userName != null) {
      result.addAll({'UserName': userName});
    }
    if (userId != null) {
      result.addAll({'userId': userId});
    }
    if (userRole != null) {
      result.addAll({'userRole': userRole});
    }
    if (exp != null) {
      result.addAll({'exp': exp});
    }
    if (iss != null) {
      result.addAll({'iss': iss});
    }
    if (aud != null) {
      result.addAll({'aud': aud});
    }

    return result;
  }

  factory JWTDecodeModel.fromMap(Map<String, dynamic> map) {
    return JWTDecodeModel(
      userName: map['UserName'],
      userId: map['UserID'],
      userRole: map['UserRole'],
      exp: map['exp'],
      iss: map['iss'],
      aud: map['aud'],
    );
  }

  String toJson() => json.encode(toMap());

  factory JWTDecodeModel.fromJson(String source) =>
      JWTDecodeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'JWTDecodeModel(userName: $userName, userId: $userId, userRole: $userRole, exp: $exp, iss: $iss, aud: $aud)';
  }

  JWTDecodeModel copyWith({
    String? userName,
    String? userId,
    String? userRole,
    int? exp,
    String? iss,
    String? aud,
  }) {
    return JWTDecodeModel(
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
      userRole: userRole ?? this.userRole,
      exp: exp ?? this.exp,
      iss: iss ?? this.iss,
      aud: aud ?? this.aud,
    );
  }
}
