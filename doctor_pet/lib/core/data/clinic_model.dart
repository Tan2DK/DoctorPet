import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClinicModel extends Equatable {
  final String id;
  final String name;
  final String address;
  final String phoneNumber;
  final String email;
  final LatLng? latlng;
  final double? distance;
  const ClinicModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.email,
    this.latlng,
    this.distance,
  });

  double get lat => latlng?.latitude ?? 0;
  double get lng => latlng?.longitude ?? 0;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'address': address});
    result.addAll({'clinicPhoneNumber': phoneNumber});
    result.addAll({'email': email});
    result.addAll({'latitude': latlng?.latitude});
    result.addAll({'longitude': latlng?.longitude});
    result.addAll({'distance': distance});

    return result;
  }

  factory ClinicModel.empty() {
    return const ClinicModel(
      id: '',
      name: '',
      address: '',
      phoneNumber: '',
      email: '',
      latlng: LatLng(0, 0),
    );
  }

  factory ClinicModel.fromMap(Map<String, dynamic> map) {
    return ClinicModel(
      id: map['clinicId'] ?? '',
      name: map['clinicName'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['clinicPhoneNumber'] ?? '',
      email: map['email'] ?? '',
      latlng: LatLng(
        double.tryParse(map['latitude'].toString()) ?? 0,
        double.tryParse(map['longitude'].toString()) ?? 0,
      ),
      distance: map['distance'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClinicModel.fromJson(String source) =>
      ClinicModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClinicModel(id: $id, name: $name, address: $address, phoneNumber: $phoneNumber, email: $email, lat: ${latlng?.latitude}, lng: ${latlng?.longitude}), distance: $distance';
  }

  ClinicModel copyWith({
    String? id,
    String? name,
    String? address,
    String? phoneNumber,
    String? email,
    LatLng? latlng,
    double? distance,
  }) {
    return ClinicModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      latlng: latlng ?? this.latlng,
      distance: distance ?? this.distance,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      address,
      phoneNumber,
      email,
      latlng ?? const LatLng(0, 0),
      distance ?? 0,
    ];
  }
}
