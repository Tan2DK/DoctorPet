import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common_widget/custom_text/custom_text_widget.dart';

class DeleteClinicDialog extends StatelessWidget {
  const DeleteClinicDialog({super.key, required this.deleteClinic});
  final Function()? deleteClinic;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const CustomTextWidget(
        text: 'Delete Clinic',
        fontWeight: FontWeight.bold,
      ),
      content: const Text('Do you want to DELETE this Clinic?'),
      actions: <Widget>[
        TextButton(
          onPressed: deleteClinic,
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
