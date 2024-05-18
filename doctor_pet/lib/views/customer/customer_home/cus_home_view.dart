import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cus_home_controller.dart';

class CustomerHomeView extends GetView<CustomerHomeController> {
  const CustomerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Row(
          children: [
            Container(
              color: Colors.white,
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    ...controller.customerTabNameList
                        .asMap()
                        .map(
                          (i, element) => MapEntry(
                            i,
                            InkWell(
                              onTap: () => controller.changeTab(i),
                              child: ColoredBox(
                                color: i == controller.index.value
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                    : Colors.transparent,
                                child: Column(
                                  children: [
                                    Icon(
                                      element.icon,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      element.title,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ).paddingAll(10),
                              ),
                            ),
                          ),
                        )
                        .values
                        .toList()
                  ],
                ),
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: IndexedStack(
                sizing: StackFit.expand,
                index: controller.index.value,
                children: controller.listScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
