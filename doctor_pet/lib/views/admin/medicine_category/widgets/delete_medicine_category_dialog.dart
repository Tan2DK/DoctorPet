import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widget/custom_text/custom_text_widget.dart';

class DeleteMedicineCategoryDialog extends StatelessWidget {
  const DeleteMedicineCategoryDialog({
    Key? key,
    this.onDeleteMedicineCategory,
  }) : super(key: key);

  final Function()? onDeleteMedicineCategory;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const CustomTextWidget(
        text: 'Delete Medicine Category',
        fontWeight: FontWeight.bold,
      ),
      content: const Text('Do you want to DELETE this medicine category?'),
      actions: <Widget>[
        TextButton(
          onPressed: onDeleteMedicineCategory,
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
