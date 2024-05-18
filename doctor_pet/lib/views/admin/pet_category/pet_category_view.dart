import 'package:doctor_pet/common_widget/custom_text/custom_text_widget.dart';
import 'package:doctor_pet/core/data/data_title_model.dart';
import 'package:doctor_pet/core/data/response/pet_category_response.dart';
import 'package:doctor_pet/views/admin/pet_category/pet_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:doctor_pet/common_widget/data_title_widget.dart';
import 'package:get/get.dart';

import '../../../../common_widget/custom_button/custom_button_action_widget.dart';

class PetCategoryView extends GetView<PetCategoryController> {
  const PetCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                SizedBox(width: 50),
                CustomTextWidget(
                  text: 'Pet Category Management',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButtonActionWidget(
                label: 'Add Pet Category',
                bgColor: Colors.blue,
                txtColor: Colors.white,
                icon: Icons.add,
                iconColor: Colors.white,
                onPressed: () {
                  controller.showAddEditDialog();
                },
              ).paddingSymmetric(horizontal: 16),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DataTitleWidget(
                    leftSpacing: 16,
                    verticalPadding: 8,
                    titles: [
                      DataTitleModel(name: 'Pet Category ID', flex: 4),
                      DataTitleModel(name: 'Pet Category Name', flex: 4),
                    ],
                  ),
                ),
                const SizedBox(width: 66),
              ],
            ),
            const Divider(thickness: 3, height: 0),
            Expanded(
              child: Obx(() {
                final List<PetCategoryResponse> data =
                    controller.petCategoryList.value;
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0),
                  itemBuilder: (context, index) => Row(
                    children: [
                      Expanded(
                        child: DataTitleWidget(
                          leftSpacing: 16,
                          verticalPadding: 8,
                          titles: [
                            DataTitleModel(
                                name: data[index].petTypeId ?? '', flex: 4),
                            DataTitleModel(
                                name: data[index].petTypeName ?? '', flex: 4),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50, // Set the width of the container
                        child: PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'edit',
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                              ),
                            ),
                          ],
                          onSelected: (String action) {
                            // Handle menu item selection
                            switch (action) {
                              case 'edit':
                                controller.showAddEditDialog(
                                  response: data[index],
                                );
                                break;
                              case 'delete':
                                controller.showDeleteDialog(
                                    data[index].petTypeId ?? '');
                              case 'detail':
                                // view clinic detail
                                break;
                            }
                          },
                        ),
                      ).paddingOnly(right: 16),
                    ],
                  ),
                  itemCount: data.length,
                );
              }),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
