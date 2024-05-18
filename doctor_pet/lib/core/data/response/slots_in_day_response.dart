import 'dart:convert';

class SlotsInDayResponse {
  final String? clinicId;
  final String? date;
  final List<int>? listSlotType;
  const SlotsInDayResponse({
    this.clinicId,
    this.date,
    this.listSlotType,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (clinicId != null) {
      result.addAll({'clinicId': clinicId});
    }
    if (date != null) {
      result.addAll({'date': date});
    }
    if (listSlotType != null) {
      result.addAll({'slots': listSlotType});
    }

    return result;
  }

  factory SlotsInDayResponse.fromMap(Map<String, dynamic> map) {
    return SlotsInDayResponse(
      clinicId: map['clinicId'],
      date: map['date'],
      listSlotType: List<int>.from(map['slots']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SlotsInDayResponse.fromJson(String source) =>
      SlotsInDayResponse.fromMap(json.decode(source));
}
