import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common_widget/custom_text/custom_text_widget.dart';

class DeletePetDialog extends StatelessWidget {
  const DeletePetDialog({super.key, required this.deletePet});
  final Function()? deletePet;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const CustomTextWidget(
        text: 'Delete Clinic',
        fontWeight: FontWeight.bold,
      ),
      content: const Text('Do you want to DELETE this Pet?'),
      actions: <Widget>[
        TextButton(
          onPressed: deletePet,
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
