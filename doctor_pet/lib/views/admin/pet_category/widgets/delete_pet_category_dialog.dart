import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common_widget/custom_text/custom_text_widget.dart';

class DeletePetCategoryDialog extends StatelessWidget {
  const DeletePetCategoryDialog({
    super.key,
    this.deletePetCategory,
  });

  final Function()? deletePetCategory;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const CustomTextWidget(
        text: 'Delete Category',
        fontWeight: FontWeight.bold,
      ),
      content: const Text('Do you want to DELETE this Pet Category?'),
      actions: <Widget>[
        TextButton(
          onPressed: deletePetCategory,
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
