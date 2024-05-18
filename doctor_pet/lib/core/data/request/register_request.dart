import 'dart:convert';

class RegisterRequest {
  final String username;
  final String password;
  final String fullname;
  final String email;
  final String address;
  final String phone;
  final String birthday;

  RegisterRequest({
    required this.username,
    required this.password,
    required this.fullname,
    required this.email,
    required this.address,
    required this.phone,
    required this.birthday,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'username': username});
    result.addAll({'password': password});
    result.addAll({'fullname': fullname});
    result.addAll({'email': email});
    result.addAll({'address': address});
    result.addAll({'phoneNumber': phone});
    result.addAll({'birthday': birthday});

    return result;
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      username: map['userName'] ?? '',
      password: map['password'] ?? '',
      fullname: map['fullName'] ?? '',
      address: map['address'] ?? '',
      email: map['email'] ?? '',
      phone: map['phoneNumber'] ?? '',
      birthday: map['birthday'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequest.fromJson(String source) =>
      RegisterRequest.fromMap(json.decode(source));
}
