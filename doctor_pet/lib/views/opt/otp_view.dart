import 'package:doctor_pet/common_widget/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../common_widget/form_box_widget.dart';
import 'package:doctor_pet/views/opt/otp_controller.dart';

import '../../common_widget/img_bg_widget.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

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
                      'Enter OTP code',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextfieldWidget(
                      label: 'Code',
                      onChanged: controller.otpChanged,
                      maxLength: 6,
                      textInputFormatter: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
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
                            'Verify',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: controller.resendOtp,
                      child: Text(
                        'Resend Otp',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
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
