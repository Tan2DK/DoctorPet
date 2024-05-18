import 'package:doctor_pet/views/customer/information/widgets/information_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'information_controller.dart';

class InformationView extends GetView<InformationController> {
  const InformationView({super.key});

  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
      color: Colors.white.withOpacity(.7),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 2),
          blurRadius: 2,
          spreadRadius: 2,
          color: Colors.black.withOpacity(.1),
        )
      ],
    );
    return Scaffold(
      backgroundColor: const Color(0xFFFEEAEA),
      body: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: boxDecoration,
              child: Column(
                children: [
                  SizedBox(
                    child: Icon(
                      Icons.account_circle,
                      size: 150,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Obx(
                      () => InformationTabWidget(
                        tabButton: controller.tabButton,
                        tabIndexed: controller.tabIndexed.value,
                        oldUser: controller.oldUser.value,
                        onTapTabButton: controller.onTapTabButton,
                        logout: controller.logout,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: boxDecoration,
                child: Obx(
                  () => IndexedStack(
                    index: controller.tabIndexed.value,
                    children: controller.pageViews,
                  ),
                ),
              ),
            ),
          ],
        ),
      ).paddingSymmetric(horizontal: 50, vertical: 60),
    );
  }
}
