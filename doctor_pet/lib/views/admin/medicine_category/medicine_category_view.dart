import 'package:doctor_pet/common_widget/custom_button/custom_button_action_widget.dart';
import 'package:doctor_pet/common_widget/custom_text/custom_text_widget.dart';
import 'package:doctor_pet/core/data/response/medicine_category_response.dart';
import 'package:flutter/material.dart';
import 'package:doctor_pet/common_widget/data_title_widget.dart';
import 'package:get/get.dart';
import '../../../core/data/data_title_model.dart';
import 'medicine_category_controller.dart';

class MedicineCategoryView extends GetView<MedicineCategoryController> {
  const MedicineCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          const Row(
            children: [
              SizedBox(width: 70),
              CustomTextWidget(
                text: 'Medicine Category Management',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButtonActionWidget(
              label: 'Add Medicine Category',
              bgColor: Colors.blue,
              txtColor: Colors.white,
              icon: Icons.add,
              iconColor: Colors.white,
              onPressed: controller.showAddEditMedicineCategoryDialog,
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
                    DataTitleModel(name: 'Medicine Category Id', flex: 1),
                    DataTitleModel(name: 'Medicine Category Name', flex: 3),
                  ],
                ),
              ),
              const SizedBox(width: 66),
            ],
          ),
          const Divider(thickness: 3, height: 0),
          Expanded(
            child: Obx(() {
              final List<MedicineCategoryResponse> data =
                  controller.medicineCategoryList.value;
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1, height: 0),
                itemBuilder: (context, index) => Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: DataTitleWidget(
                        leftSpacing: 16,
                        verticalPadding: 8,
                        titles: [
                          DataTitleModel(name: data[index].id ?? '', flex: 1),
                          DataTitleModel(name: data[index].name ?? '', flex: 3),
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
                              controller.showAddEditMedicineCategoryDialog(
                                medicineCategory: data[index],
                              );
                              break;
                            case 'delete':
                              controller.showDeleteMedicineCategoryDialog(
                                  data[index].id ?? '');
                              break;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
                itemCount: data.length,
              );
            }),
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}
