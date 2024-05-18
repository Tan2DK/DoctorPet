import 'package:doctor_pet/common_widget/custom_searchbar_widget.dart';
import 'package:doctor_pet/common_widget/custom_text/custom_text_widget.dart';
import 'package:doctor_pet/core/data/data_title_model.dart';
import 'package:doctor_pet/core/data/response/manage_clinic_response.dart';
import 'package:doctor_pet/views/admin/clinic/clinic_controller.dart';
import 'package:flutter/material.dart';
import 'package:doctor_pet/common_widget/data_title_widget.dart';
import 'package:get/get.dart';

import '../../../../common_widget/custom_button/custom_button_action_widget.dart';

class ClinicView extends GetView<ClinicController> {
  const ClinicView({super.key});
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
            const SizedBox(height: 10),
            const Row(
              children: [
                SizedBox(width: 50),
                CustomTextWidget(
                  text: 'Clinic Management',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButtonActionWidget(
                label: 'Add Clinic',
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
                      DataTitleModel(name: 'Name', flex: 2),
                      DataTitleModel(name: 'Address', flex: 3),
                      DataTitleModel(name: 'Phone', flex: 1),
                      DataTitleModel(name: 'Coordinate', flex: 2),
                      DataTitleModel(name: 'Manager', flex: 2),
                    ],
                  ),
                ),
                const SizedBox(width: 66),
              ],
            ),
            const Divider(thickness: 3, height: 0),
            Expanded(
              child: Obx(() {
                final List<ManageClinicResponse> data =
                    controller.clinicList.value;
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
                                name: data[index].clinicName ?? '', flex: 2),
                            DataTitleModel(
                                name: data[index].address ?? '', flex: 3),
                            DataTitleModel(
                                name: data[index].clinicPhoneNumber ?? '',
                                flex: 1),
                            DataTitleModel(
                                name:
                                    'Latitude: ${data[index].latitude ?? ''}\nLongitude: ${data[index].longitude ?? ''}',
                                flex: 2),
                            DataTitleModel(
                                name: data[index].staff?.toDataTable() ?? '',
                                flex: 2),
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
                                  context,
                                  data[index],
                                );
                                break;
                              case 'delete':
                                controller.showDeleteDialog(
                                  data[index].clinicId ?? '',
                                );
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
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
