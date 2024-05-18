import 'dart:convert';

class DoctorSlotsResponse {
  final String? doctorId;
  final String? date;
  final List<int>? slots;
  const DoctorSlotsResponse({
    this.doctorId,
    this.date,
    this.slots,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (doctorId != null) {
      result.addAll({'doctorId': doctorId});
    }
    if (date != null) {
      result.addAll({'date': date});
    }
    if (slots != null) {
      result.addAll({'slots': slots});
    }

    return result;
  }

  factory DoctorSlotsResponse.fromMap(Map<String, dynamic> map) {
    final response = DoctorSlotsResponse(
      doctorId: map['doctorId'],
      date: map['registerDate'],
      slots: List<int>.from(map['availabilitySlots']),
    );
    return response;
  }

  String toJson() => json.encode(toMap());

  factory DoctorSlotsResponse.fromJson(String source) =>
      DoctorSlotsResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'DoctorSlotsResponse(doctorId: $doctorId, date: $date, slots: $slots)';

  DoctorSlotsResponse copyWith({
    String? doctorId,
    String? date,
    List<int>? slots,
  }) {
    return DoctorSlotsResponse(
      doctorId: doctorId ?? this.doctorId,
      date: date ?? this.date,
      slots: slots ?? this.slots,
    );
  }
}
