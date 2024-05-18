import 'package:doctor_pet/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../common_widget/custom_text/custom_text_widget.dart';
import '../../../../common_widget/custom_textfield_widget.dart';
import '../information_controller.dart';

class InformationFormWidget extends GetWidget<InformationController> {
  const InformationFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User Information',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => CustomTextfieldWidget(
              label: 'Fullname',
              errorMessage: controller.errorName.value,
              onChanged: controller.nameChanged,
              controller: controller.nameController.value,
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => CustomTextfieldWidget(
              label: 'Email Address',
              errorMessage: controller.errorEmail.value,
              onChanged: controller.emailChanged,
              controller: controller.emailController.value,
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => CustomTextfieldWidget(
              label: 'Address',
              errorMessage: controller.errorAddress.value,
              onChanged: controller.addressChanged,
              controller: controller.addressController.value,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(
                  () => CustomTextfieldWidget(
                    label: 'Phone Number',
                    errorMessage: controller.errorPhone.value,
                    onChanged: controller.phoneChanged,
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: controller.phoneController.value,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Obx(
                  () => Container(
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.9),
                      ),
                    ),
                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.black54,
                      ),
                      onPressed: () => controller.birthdayChanged(context),
                      label: CustomTextWidget(
                        text: controller.newUser.value?.birthday ??
                            DateTime.now().dateOnly.formatDateTime(
                                  'dd-MM-yyyy',
                                ),
                        txtColor: Colors.black,
                      ),
                      style: ButtonStyle(
                        alignment: Alignment.centerLeft,
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 56,
              width: 200,
              child: Obx(
                () => FilledButton(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: controller.canSubmit.value
                      ? controller.onTapUpdate
                      : null,
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
