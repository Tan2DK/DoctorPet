import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common_widget/custom_textfield_widget.dart';
import '../information_controller.dart';

class PasswordFormWidget extends GetWidget<InformationController> {
  const PasswordFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Update Password',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Obx(() => CustomTextfieldWidget(
                label: 'Old Password',
                errorMessage: controller.errorOldPassword.value,
                onChanged: controller.oldPasswordChanged,
                controller: controller.oldPasswordController,
                isPassword: true,
              )),
          const SizedBox(height: 10),
          Obx(() => CustomTextfieldWidget(
                label: 'New Password',
                errorMessage: controller.errorPassword.value,
                onChanged: controller.passwordChanged,
                controller: controller.passwordController,
                isPassword: true,
              )),
          const SizedBox(height: 10),
          Obx(() => CustomTextfieldWidget(
                label: 'Confirm Password',
                errorMessage: controller.errorCPassword.value,
                onChanged: controller.cPasswordChanged,
                controller: controller.cPasswordController,
                isPassword: true,
              )),
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
                  onPressed: controller.canSubmitPassword.value
                      ? controller.onTapUpdatePassword
                      : null,
                  child: const Text(
                    'Update Password',
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
