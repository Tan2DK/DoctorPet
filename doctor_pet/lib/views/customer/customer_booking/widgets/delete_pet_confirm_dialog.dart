import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeletePetConfirmDialog extends StatelessWidget {
  const DeletePetConfirmDialog({
    Key? key,
    this.onConfirm,
    this.title = '',
    this.content = '',
  }) : super(key: key);
  final Function()? onConfirm;
  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      insetPadding: const EdgeInsets.all(16),
      content: Text(content!),
      actions: [
        FilledButton(
          onPressed: () {
            Get.back();
            onConfirm?.call();
          },
          child: const Text('Confirm'),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: Get.back,
          child: const Text('Back'),
        ),
      ],
    );
  }
}
