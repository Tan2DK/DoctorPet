import 'package:doctor_pet/common_widget/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../common_widget/form_box_widget.dart';
import 'change_password_controller.dart';
import '../../common_widget/img_bg_widget.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ImgBgWidget(),
          Align(
            alignment: Alignment(
              ResponsiveBreakpoints.of(context).screenWidth > 800 ? 0.75 : 0,
              0,
            ),
            child: FormBoxWidget(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      // Need move to constant string
                      'Please enter a new password and confirm the password to complete the password change process',
                    ).paddingSymmetric(horizontal: 10),
                    const SizedBox(height: 10),
                    Obx(
                      () => CustomTextfieldWidget(
                        label: 'Password',
                        onChanged: controller.passwordChanged,
                        isPassword: true,
                        errorMessage: controller.errorPassword.value,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => CustomTextfieldWidget(
                        label: 'Confirm Password',
                        onChanged: controller.cPasswordChanged,
                        isPassword: true,
                        errorMessage: controller.errorCPassword.value,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 56,
                      width: 220,
                      child: Obx(
                        () => FilledButton(
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: controller.canSubmit.value
                              ? controller.onTapSubmit
                              : null,
                          child: const Text(
                            'Update Password',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ).paddingSymmetric(
                horizontal: ResponsiveBreakpoints.of(context).screenWidth <= 800
                    ? 32
                    : 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
