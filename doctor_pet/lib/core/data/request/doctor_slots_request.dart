import 'dart:convert';

class DoctorSlotsRequest {
  final String? doctorId;
  final String? registerDate;
  final List<int>? availabilitySlots;
  DoctorSlotsRequest({
    this.doctorId,
    this.registerDate,
    this.availabilitySlots,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (doctorId != null) {
      result.addAll({'doctorId': doctorId});
    }
    if (registerDate != null) {
      result.addAll({'registerDate': registerDate});
    }
    if (availabilitySlots != null) {
      result.addAll({'availabilitySlots': availabilitySlots});
    }

    return result;
  }

  factory DoctorSlotsRequest.fromMap(Map<String, dynamic> map) {
    return DoctorSlotsRequest(
      doctorId: map['doctorId'],
      registerDate: map['registerDate'],
      availabilitySlots: List<int>.from(map['availabilitySlots']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorSlotsRequest.fromJson(String source) =>
      DoctorSlotsRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'DoctorSlotsRequest(doctorId: $doctorId, registerDate: $registerDate, availabilitySlots: $availabilitySlots)';

  DoctorSlotsRequest copyWith({
    String? doctorId,
    String? registerDate,
    List<int>? availabilitySlots,
  }) {
    return DoctorSlotsRequest(
      doctorId: doctorId ?? this.doctorId,
      registerDate: registerDate ?? this.registerDate,
      availabilitySlots: availabilitySlots ?? this.availabilitySlots,
    );
  }
}
