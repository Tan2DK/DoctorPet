import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/request/doctor_request.dart';
import 'package:doctor_pet/core/data/response/degree_response.dart';
import 'package:doctor_pet/utils/app_extension.dart';

import '../../../../common_widget/custom_text/custom_text_widget.dart';

class EditDoctorDialog extends StatefulWidget {
  const EditDoctorDialog({
    Key? key,
    this.doctor,
    this.degrees,
    this.addEditDoctor,
    this.selectDate,
  }) : super(key: key);
  final DoctorRequest? doctor;
  final List<DegreeResponse>? degrees;
  final Function(DoctorRequest)? addEditDoctor;
  final Function(BuildContext, DateTime, bool)? selectDate;

  @override
  State<EditDoctorDialog> createState() => _EditDoctorDialogState();
}

class _EditDoctorDialogState extends State<EditDoctorDialog> {
  bool status = true;
  DateTime birthDay = DateTime.now().dateOnly;
  DegreeResponse? selectedDegree;

  final textControllerName = TextEditingController();
  final textControllerAddress = TextEditingController();
  final textControllerPhone = TextEditingController();
  final textControllerEmail = TextEditingController();
  final textControllerSpecialized = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.doctor == null) return;
    textControllerName.text = widget.doctor?.doctorName ?? '';
    textControllerAddress.text = widget.doctor?.address ?? '';
    textControllerPhone.text = widget.doctor?.phoneNumber ?? '';
    selectedDegree = widget.degrees?.firstWhereOrNull(
      (degree) => degree.degreeId == widget.doctor?.degreeId,
    );
    textControllerEmail.text = widget.doctor?.email ?? '';
    textControllerSpecialized.text = widget.doctor?.specialized ?? '';
    status = widget.doctor?.doctorStatus ?? true;
    birthDay = (widget.doctor?.birthday?.isEmpty ?? true)
        ? DateTime.now().dateOnly
        : widget.doctor!.birthday!.parseDateTime('yyyy-MM-dd');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomTextWidget(
        text: '${widget.doctor != null ? 'Edit' : 'Add'} Doctor',
        fontWeight: FontWeight.bold,
      ),
      content: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.text,
              controller: textControllerName,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  labelText: 'Doctor Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.text,
              controller: textControllerAddress,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.text,
              controller: textControllerPhone,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.text,
              controller: textControllerEmail,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<DegreeResponse>(
                items: widget.degrees
                    ?.map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.degreeName ?? ''),
                      ),
                    )
                    .toList(),
                onChanged: (degree) => setState(() {
                  selectedDegree = degree;
                }),
                borderRadius: BorderRadius.circular(10),
                value: selectedDegree,
                itemHeight: 54.5,
                menuMaxHeight: 200,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                isExpanded: true,
                underline: const SizedBox.shrink(),
                hint: const Text('Degree'),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.text,
              controller: textControllerSpecialized,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                  labelText: 'Specialized',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
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
                  const CustomTextWidget(
                    text: 'Birthday: ',
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.calendar_month_outlined,
                        color: Colors.black54),
                    onPressed: () async {
                      final picked = await widget.selectDate?.call(
                        context,
                        birthDay,
                        true,
                      );
                      if (picked == null) return;
                      setState(() {
                        birthDay = picked;
                      });
                    },
                    label: CustomTextWidget(
                      text: birthDay.formatDateTime('dd-MM-yyyy'),
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
                    });
                  },
                ),
                CustomTextWidget(
                  text: status ? 'Active' : 'Inactive',
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => widget.addEditDoctor?.call(
            DoctorRequest(
              doctorName: textControllerName.text,
              address: textControllerAddress.text,
              phoneNumber: textControllerPhone.text,
              doctorStatus: status,
              degreeId: selectedDegree?.degreeId,
              birthday: birthDay.formatDateTime('yyyy-MM-dd'),
              doctorId: widget.doctor?.doctorId ?? '',
              userId: widget.doctor?.userId,
              email: textControllerEmail.text,
              specialized: textControllerSpecialized.text,
            ),
          ),
          child: CustomTextWidget(
            text: widget.doctor != null ? 'Edit' : 'Add',
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
    );
  }
}
