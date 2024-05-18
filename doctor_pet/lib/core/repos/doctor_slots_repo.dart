import 'package:dartz/dartz.dart';
import '../data/request/doctor_get_slots_request.dart';
import '../data/request/doctor_slots_request.dart';
import '../data/response/doctor_slots_response.dart';

abstract class DoctorSlotsRepo {
  Future<Either<String, String>> setDoctorSlots({
    required List<DoctorSlotsRequest> doctorSlotsRequests,
  });
  Future<Either<String, List<DoctorSlotsResponse>>> getDoctorSlots({
    required DoctorGetSlotsRequest doctorGetSlotsRequest,
  });
}
