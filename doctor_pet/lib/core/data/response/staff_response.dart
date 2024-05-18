import 'dart:convert';

class StaffResponse {
  final String? id;
  final String? name;
  final String? address;
  final String? phone;
  final String? email;
  final String? birthday;
  final bool? status;
  final String? userId;
  final String? clinicId;
  StaffResponse({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.birthday,
    this.status,
    this.userId,
    this.clinicId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'employeeId': id});
    }
    if (name != null) {
      result.addAll({'employeeName': name});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (phone != null) {
      result.addAll({'phoneNumber': phone});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (birthday != null) {
      result.addAll({'birthday': birthday});
    }
    if (status != null) {
      result.addAll({'employeeStatus': status});
    }
    result.addAll({'userId': userId});

    result.addAll({'clinicId': clinicId});

    return result;
  }

  factory StaffResponse.fromMap(Map<String, dynamic> map) {
    return StaffResponse(
      id: map['employeeId'],
      name: map['employeeName'],
      address: map['address'],
      phone: map['phoneNumber'],
      email: map['email'],
      birthday: map['birthday'],
      status: map['employeeStatus'],
      userId: map['userId'],
      clinicId: map['clinicId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StaffResponse.fromJson(String source) =>
      StaffResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StaffResponse(employeeId: $id, employeeName: $name, address: $address, phoneNumber: $phone, email: $email, birthday: $birthday, employeeStatus: $status, userId: $userId, clinicId: $clinicId,)';
  }
}
