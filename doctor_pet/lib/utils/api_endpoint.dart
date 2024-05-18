class ApiEndpointConstant {
  // user api
  static const login = '/api/User/login/';
  static const register = '/api/User/register/';
  static const getUserInfor = '/api/User/GetUserInfo/';
  static const editUserInfor = '/api/User/Update/';

  //appointment api
  static const getDoctorSlotByClinic = '/api/appointment/slots/';
  static const booking = '/api/appointment/book/';
  static const getClinic = '/api/appointment/clinics/';
  static const getAppointmentsByCustomerId = '/api/appointment/getList/';

  //staff api
  static const getPendingAppointments = '/api/Staff/getLists';
  static const getAvailableDoctors = '/api/Staff/availableDoctors/';
  static const assignDoctorAppointment = '/api/Staff/assignDoctor/';

  //doctor api
  static const doctorUpdateSlots = '/api/Doctor/SetSlot';
  static const doctorGetSlots = '/api/Doctor/getSlot/';
  static const getAppointmentsByDoctorId = '/api/Doctor/getAppointments/';
  static const doctorConfirmBooking = '/api/Doctor/confirmAppointment/';
  static const searchMedicine = '/api/Doctor/search/';
  static const confirmAppointment = '/api/Doctor/confirmAppointment/';
  static const createBilling = '/api/Doctor/generate/';

  //clinic manager api
  static const createStaff = '/api/Admin/AddStaff/';
  static const getStaff = '/api/Admin/GetAllStaff/';
  static const editStaff = '/api/Admin/UpdateStaff/';
  static const deleteStaff = '/api/Admin/DeleteStaff/';

  static const getDoctor = '/api/Admin/GetAllDoctors/';
  static const createDoctor = '/api/Admin/AddDoctor/';
  static const editDoctor = '/api/Admin/UpdateDoctor/';
  static const deleteDoctor = '/api/Admin/DeleteDoctor/';

  static const getMedicine = '/api/Admin/GetAllMedicine/';
  static const createMedicine = '/api/Admin/AddMedicine/';
  static const editMedicine = '/api/Admin/UpdateMedicine/';
  static const deleteMedicine = '/api/Admin/';

  static const getMedicineCategory = '/api/Admin/GetAllCategories/';
  static const createMedicineCategory = '/api/Admin/AddCategory/';
  static const editMedicineCategory = '/api/Admin/UpdateCategory/';
  static const deleteMedicineCategory = '/api/Admin/DeleteCategory/';

  static const getClinicPagination = '/api/SuperAdmin/GetAllClinics/';
  static const createClinic = '/api/SuperAdmin/AddClinic/';
  static const editClinic = '/api/SuperAdmin/UpdateClinic/';
  static const deleteClinic = '/api/SuperAdmin/DeleteClinic/';

  static const appointmentStatistics = '/api/SuperAdmin/appointmentStatistics/';
  static const moneyStatistic = '/api/SuperAdmin/moneyStatisticByClinic/';
  static const getDashboardDoctors = '/api/SuperAdmin/GetDoctors/';
  static const getDashboardStaffs = '/api/SuperAdmin/GetAllStaff/';

  static const getPet = '/api/User/GetAllPet/';
  static const createPet = '/api/User/AddPet/';
  static const editPet = '/api/User/UpdatePet/';
  static const deletePet = '/api/User/';

  static const getPetCategory = '/api/SuperAdmin/GetAllCategories/';
  static const createPetCategory = '/api/SuperAdmin/AddCategory/';
  static const editPetCategory = '/api/SuperAdmin/UpdateCategory/';
  static const deletePetCategory = '/api/SuperAdmin/DeleteCategory/';

  static const getPetCategoryByClinics = '/api/Admin/GetAllPetCategories/';
  static const updatePetCategoryByClinics = '/api/Admin/UpdatePetCategory/';

  static const getDegree = '/api/Admin/GetAllDegree/';
  static const createDegree = '/api/Admin/AddDegree/';

  static const getPetByUserClinic = '/api/Appointment/pet/';

  static const medicineReport = '/api/Admin/MedicineReport/';
  static const medicineReportByClinic = '/api/SuperAdmin/GenerateReport/';

  static const forgot = '/api/User/forgot/';
  static const verify = '/api/User/verify/';
  static const reset = '/api/User/reset/';
  static const changePassword = '/api/User/changepassword/';
}
