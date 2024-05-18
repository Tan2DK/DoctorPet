import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/response/user_response.dart';

import 'tab_button_widget.dart';

class InformationTabWidget extends StatelessWidget {
  const InformationTabWidget({
    Key? key,
    this.oldUser,
    required this.tabButton,
    required this.tabIndexed,
    this.onTapTabButton,
    this.logout,
  }) : super(key: key);

  final UserResponse? oldUser;
  final List<String> tabButton;
  final int tabIndexed;
  final Function(int)? onTapTabButton;
final Function()? logout;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          (oldUser?.username.isNotEmpty ?? false)
              ? oldUser!.username
              : 'NoName',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...tabButton
                    .asMap()
                    .map(
                      (index, value) => MapEntry(
                        index,
                        TabButtonWidget(
                          isSelected: tabIndexed == index,
                          title: tabButton[index],
                          onTap: () => onTapTabButton?.call(index),
                        ).paddingOnly(bottom: 10),
                      ),
                    )
                    .values
                    .toList(),
                TabButtonWidget(
                  isSelected: false,
                  title: 'Logout',
                  onTap: logout,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
