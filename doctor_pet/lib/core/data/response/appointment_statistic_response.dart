import 'dart:convert';

class AppointmentStatisticResponse {
  final String? date;
  final int? total;
  final int? doneQuantity;
  final int? inProgressQuantity;
  final int? waitingQuantity;
  final int? pendingQuantity;
  AppointmentStatisticResponse({
    this.date,
    this.total,
    this.doneQuantity,
    this.inProgressQuantity,
    this.waitingQuantity,
    this.pendingQuantity,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (date != null) {
      result.addAll({'date': date});
    }
    if (total != null) {
      result.addAll({'total': total});
    }
    if (doneQuantity != null) {
      result.addAll({'doneQuantity': doneQuantity});
    }
    if (inProgressQuantity != null) {
      result.addAll({'inProgressQuantity': inProgressQuantity});
    }
    if (waitingQuantity != null) {
      result.addAll({'waitingQuantity': waitingQuantity});
    }
    if (pendingQuantity != null) {
      result.addAll({'pendingQuantity': pendingQuantity});
    }

    return result;
  }

  String toJson() => json.encode(toMap());

  factory AppointmentStatisticResponse.fromMap(Map<String, dynamic> map) {
    return AppointmentStatisticResponse(
      date: map['date'],
      total: map['total']?.toInt(),
      doneQuantity: map['doneQuantity']?.toInt(),
      inProgressQuantity: map['inProgressQuantity']?.toInt(),
      waitingQuantity: map['waitingQuantity']?.toInt(),
      pendingQuantity: map['pendingQuantity']?.toInt(),
    );
  }

  factory AppointmentStatisticResponse.fromJson(String source) =>
      AppointmentStatisticResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppointmentStatisticResponse(date: $date, total: $total, doneQuantity: $doneQuantity, inProgressQuantity: $inProgressQuantity, waitingQuantity: $waitingQuantity, pendingQuantity: $pendingQuantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppointmentStatisticResponse &&
        other.date == date &&
        other.total == total &&
        other.doneQuantity == doneQuantity &&
        other.inProgressQuantity == inProgressQuantity &&
        other.waitingQuantity == waitingQuantity &&
        other.pendingQuantity == pendingQuantity;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        total.hashCode ^
        doneQuantity.hashCode ^
        inProgressQuantity.hashCode ^
        waitingQuantity.hashCode ^
        pendingQuantity.hashCode;
  }
}
