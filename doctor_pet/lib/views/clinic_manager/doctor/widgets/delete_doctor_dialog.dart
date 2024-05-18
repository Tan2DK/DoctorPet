import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widget/custom_text/custom_text_widget.dart';

class DeleteDoctorDialog extends StatelessWidget {
  const DeleteDoctorDialog({
    Key? key,
    required this.deleteDoctor,
  }) : super(key: key);
  final Function()? deleteDoctor;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const CustomTextWidget(
        text: 'Delete Doctor',
        fontWeight: FontWeight.bold,
      ),
      content: const Text('Do you want to DELETE this Doctor?'),
      actions: <Widget>[
        TextButton(
          onPressed: deleteDoctor,
          child: const CustomTextWidget(
            text: 'Delete',
            txtColor: Colors.red,
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
