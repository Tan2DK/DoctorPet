import 'package:doctor_pet/common_widget/custom_text/custom_text_widget.dart';
import 'package:doctor_pet/core/data/data_title_model.dart';
import 'package:doctor_pet/core/data/response/pet_response.dart';
import 'package:doctor_pet/utils/app_enum.dart';
import 'package:flutter/material.dart';
import 'package:doctor_pet/common_widget/data_title_widget.dart';
import 'package:get/get.dart';

import '../../../../common_widget/custom_button/custom_button_action_widget.dart';
import 'pet_controller.dart';

class PetView extends GetView<PetController> {
  const PetView({super.key});
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
            const SizedBox(height: 20),
            const Row(
              children: [
                SizedBox(width: 50),
                CustomTextWidget(
                  text: 'My Pet',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButtonActionWidget(
                label: 'Add Pet',
                bgColor: Colors.blue,
                txtColor: Colors.white,
                icon: Icons.add,
                iconColor: Colors.white,
                onPressed: () {
                  controller.showAddEditDialog(
                    context,
                    null,
                  );
                },
              ).paddingSymmetric(horizontal: 10),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DataTitleWidget(
                    leftSpacing: 16,
                    verticalPadding: 8,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    titles: [
                      DataTitleModel(name: 'Name', flex: 2),
                      DataTitleModel(name: 'Species', flex: 2),
                      DataTitleModel(name: 'Type', flex: 2),
                      DataTitleModel(name: 'Age', flex: 1),
                      DataTitleModel(name: 'Gender', flex: 1),
                      DataTitleModel(name: 'Color', flex: 1),
                    ],
                  ),
                ),
                const SizedBox(width: 66),
              ],
            ),
            const Divider(thickness: 3, height: 0),
            Expanded(
              child: Obx(() {
                final List<PetResponse> data = controller.petList.value;
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0),
                  itemBuilder: (context, index) => Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: DataTitleWidget(
                          leftSpacing: 16,
                          verticalPadding: 8,
                          titles: [
                            DataTitleModel(
                              name: data[index].petName ?? '',
                              flex: 2,
                            ),
                            DataTitleModel(
                              name: data[index].petSpecies ?? '',
                              flex: 2,
                            ),
                            DataTitleModel(
                              name: (data[index].petTypeId?.isEmpty ?? true)
                                  ? ''
                                  : controller.petCategoryList.value
                                          .firstWhereOrNull((cate) =>
                                              cate.petTypeId ==
                                              data[index].petTypeId)
                                          ?.petTypeName ??
                                      '',
                              flex: 2,
                            ),
                            DataTitleModel(
                              name: data[index].petAge != null
                                  ? data[index].petAge!.toString()
                                  : '',
                              flex: 1,
                            ),
                            DataTitleModel(
                                name: data[index].petGender != null
                                    ? data[index].petGender!
                                        ? Gender.male.genderName
                                        : Gender.female.genderName
                                    : '',
                                flex: 1),
                            DataTitleModel(
                              name: data[index].petColor ?? '',
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
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
                                  context,
                                  data[index],
                                );
                                break;
                              case 'delete':
                                controller.showDeleteDialog(
                                  data[index].petId ?? '',
                                );
                              case 'detail':
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
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
