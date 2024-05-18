import 'package:dartz/dartz.dart';
import 'package:doctor_pet/core/data/request/assign_doctor_appointment_request.dart';
import '../data/request/create_billing_request.dart';
import '../data/response/get_appointments_response.dart';

abstract class AppointmentRepo {
  Future<Either<String, GetAppointmentsResponse>> getAppointmentsByCustomer({
    required int? offset,
    required int? limit,
  });
  Future<Either<String, GetAppointmentsResponse>> getAppointmentsByDoctor({
    required int? offset,
    required int? limit,
    required String date,
  });
  Future<Either<String, GetAppointmentsResponse>> getPendingAppointments({
    required String date,
    required int? offset,
    required int? limit,
  });
  Future<Either<String, String>> assignDoctorAppointment({
    required AssignDoctorAppointmentRequest? assignDoctorAppointmentRequest,
  });
  Future<Either<String, String>> confirmAppointment({
    required String appointmentId,
  });
  Future<Either<String, String>> createBilling({
    required CreateBillingRequest? createBillingRequest,
  });
}
