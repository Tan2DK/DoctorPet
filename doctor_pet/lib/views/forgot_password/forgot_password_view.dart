import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../common_widget/custom_textfield_widget.dart';
import '../../common_widget/form_box_widget.dart';
import 'forgot_password_controller.dart';
import '../../common_widget/img_bg_widget.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

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
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextfieldWidget(
                      label: 'Username',
                      onChanged: controller.usernameChanged,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 56,
                      width: 200,
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
                            'Continue',
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
