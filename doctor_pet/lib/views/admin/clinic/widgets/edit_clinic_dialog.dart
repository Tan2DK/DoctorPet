import 'package:doctor_pet/core/data/request/manage_clinic_request.dart';
import 'package:doctor_pet/core/data/request/manage_clinic_staff_request.dart';
import 'package:doctor_pet/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../common_widget/custom_text/custom_text_widget.dart';

class EditClinicDialog extends StatefulWidget {
  const EditClinicDialog({
    Key? key,
    this.clinic,
    this.addEditClinic,
    this.onChangedStatus,
    this.selectDate,
  }) : super(key: key);
  final ManageClinicRequest? clinic;
  final Function(ManageClinicRequest)? addEditClinic;
  final Function(bool?)? onChangedStatus;
  final Function(BuildContext, DateTime)? selectDate;

  @override
  State<EditClinicDialog> createState() => _EditClinicDialogState();
}

class _EditClinicDialogState extends State<EditClinicDialog> {
  final textControllerClinicName = TextEditingController();
  final textControllerAddress = TextEditingController();
  final textControllerPhone = TextEditingController();
  final textControllerStaffEmail = TextEditingController();
  final textControllerStaffName = TextEditingController();
  final textControllerStaffPhone = TextEditingController();
  final textControllerStaffAddress = TextEditingController();
  final textControllerLat = TextEditingController();
  final textControllerLng = TextEditingController();
  bool status = true;
  DateTime birthday = DateTime.now().dateOnly;

  @override
  void initState() {
    super.initState();
    if (widget.clinic == null) return;
    textControllerClinicName.text = widget.clinic?.clinicName ?? '';
    textControllerAddress.text = widget.clinic?.address ?? '';
    textControllerPhone.text = widget.clinic?.clinicPhoneNumber ?? '';
    textControllerLat.text = widget.clinic?.latitude ?? '';
    textControllerLng.text = widget.clinic?.longitude ?? '';
    textControllerStaffEmail.text = widget.clinic?.staff?.email ?? '';
    textControllerStaffName.text = widget.clinic?.staff?.employeeName ?? '';
    textControllerStaffPhone.text = widget.clinic?.staff?.phoneNumber ?? '';
    textControllerStaffAddress.text = widget.clinic?.staff?.address ?? '';
    birthday = (widget.clinic?.staff?.birthday?.isEmpty ?? true)
        ? birthday
        : widget.clinic!.staff!.birthday!.parseDateTime('yyyy-MM-dd');
    status = widget.clinic?.staff?.employeeStatus ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    );
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CustomTextWidget(
                  text: '${widget.clinic != null ? 'Edit' : 'Add'} Clinic',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const CustomTextWidget(
                text: 'Clinic Information',
                fontWeight: FontWeight.bold,
                txtColor: Colors.blue,
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.text,
                controller: textControllerClinicName,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Clinic Name',
                  border: outlineBorder,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.text,
                controller: textControllerAddress,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      // mo google map, sau do chon vi tri
                    },
                    icon: const Icon(Icons.maps_home_work_outlined),
                  ),
                  labelText: 'Address',
                  border: outlineBorder,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.text,
                controller: textControllerPhone,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: outlineBorder,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: textControllerLat,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(fontSize: 15),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^\d*\.?\d*)'))
                      ],
                      decoration: InputDecoration(
                        labelText: 'Latitude',
                        border: outlineBorder,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: textControllerLng,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(fontSize: 15),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^\d*\.?\d*)'))
                      ],
                      decoration: InputDecoration(
                        labelText: 'Longitude',
                        border: outlineBorder,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const CustomTextWidget(
                    text: 'Status: ',
                  ),
                  Checkbox(
                    value: status,
                    onChanged: (value) {
                      setState(() {
                        status = value!;
                        widget.onChangedStatus?.call(value);
                      });
                    },
                  ),
                  CustomTextWidget(
                    text: status ? 'Active' : 'Inactive',
                  ),
                ],
              ),
              const Divider(),
              const CustomTextWidget(
                text: 'Manager Information',
                fontWeight: FontWeight.bold,
                txtColor: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: textControllerStaffName,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                          labelText: 'Name', border: outlineBorder),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: textControllerStaffEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: outlineBorder,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: textControllerStaffPhone,
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: outlineBorder,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: textControllerStaffAddress,
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: outlineBorder,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const CustomTextWidget(text: 'Birthday: '),
                    TextButton.icon(
                      icon: const Icon(Icons.calendar_month_outlined,
                          color: Colors.black54),
                      onPressed: () async {
                        final picked = await widget.selectDate?.call(
                          context,
                          birthday,
                        );
                        if (picked == null) return;
                        setState(() {
                          birthday = picked;
                        });
                      },
                      label: CustomTextWidget(
                        text: birthday.formatDateTime('dd-MM-yyyy'),
                        txtColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const CustomTextWidget(
                    text: 'Status: ',
                  ),
                  Checkbox(
                    value: status,
                    onChanged: (value) {
                      setState(() {
                        status = value!;
                        widget.onChangedStatus?.call(value);
                      });
                    },
                  ),
                  CustomTextWidget(
                    text: status ? 'Active' : 'Inactive',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => widget.addEditClinic?.call(
                      ManageClinicRequest(
                        clinicId: widget.clinic?.clinicId,
                        address: textControllerAddress.text,
                        clinicName: textControllerClinicName.text,
                        clinicPhoneNumber: textControllerPhone.text,
                        latitude: textControllerLat.text,
                        longitude: textControllerLng.text,
                        staff: ManageClinicStaffRequest(
                          address: textControllerStaffAddress.text,
                          employeeId: widget.clinic?.staff?.employeeId,
                          birthday: birthday.formatDateTime('yyyy-MM-dd'),
                          email: textControllerStaffEmail.text,
                          employeeName: textControllerStaffName.text,
                          employeeStatus: status,
                          phoneNumber: textControllerStaffPhone.text,
                          userId: widget.clinic?.staff?.userId,
                        ),
                      ),
                    ),
                    child: CustomTextWidget(
                      text: widget.clinic != null ? 'Edit' : 'Add',
                      txtColor: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: Get.back,
                    child: const CustomTextWidget(
                      text: 'Cancel',
                      txtColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
