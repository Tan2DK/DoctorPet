import 'dart:convert';

class LoginRequest {
  final String username;
  final String password;
  LoginRequest({
    required this.username,
    required this.password,
  });
  

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'userName': username});
    result.addAll({'password': password});
  
    return result;
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      username: map['userName'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) => LoginRequest.fromMap(json.decode(source));
}
