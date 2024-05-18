import '../../core/data/response/slots_in_day_response.dart';

class DoctorSlotsResponseData {
  DoctorSlotsResponseData._();
  static const data = [
    SlotsInDayResponse(
      clinicId: '123',
      date: '2024-05-06',
      listSlotType: [1, 2, 3],
    ),
    // DoctorSlotsResponse(
    //   doctorId: '123',
    //   date: '2024-04-14',
    //   slots: [7, 8, 4],
    // ),
    // DoctorSlotsResponse(
    //   doctorId: '123',
    //   date: '2024-04-15',
    //   slots: [4, 5, 2],
    // ),
    SlotsInDayResponse(
      clinicId: '123',
      date: '2024-05-08',
      listSlotType: [1, 5, 3, 8],
    ),
    // DoctorSlotsResponse(
    //   doctorId: '123',
    //   date: '2024-04-17',
    //   slots: [],
    // ),
  ];
}
