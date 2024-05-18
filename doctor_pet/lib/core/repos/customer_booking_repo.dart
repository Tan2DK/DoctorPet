import 'package:dartz/dartz.dart';
import 'package:doctor_pet/core/data/request/create_booking_request.dart';

import '../data/response/slots_in_day_response.dart';

abstract class CustomerBookingRepo {
  Future<Either<String, List<SlotsInDayResponse>>> getDoctorSlotByClinic({
    required String clinicId,
    required DateTime startDate,
    required DateTime endDate,
  });
  Future<Either<String, String>> booking({
    required CreateBookingRequest createBookingRequest,
  });
}
