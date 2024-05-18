import 'package:doctor_pet/core/data/response/staff_response.dart';
import 'package:doctor_pet/utils/app_extension.dart';
import 'package:doctor_pet/views/clinic_manager/staff/staff_controller.dart';
import 'package:flutter/material.dart';
import 'package:doctor_pet/common_widget/data_title_widget.dart';
import 'package:get/get.dart';

import '../../../core/data/data_title_model.dart';

class StaffView extends GetView<StaffController> {
  const StaffView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          const Text(
            'Staff Management',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ).paddingOnly(left: 32),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: controller.showAddEditStaffDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Add Staff',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
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
                    DataTitleModel(name: 'Staff Name', flex: 4),
                    DataTitleModel(name: 'Address', flex: 4),
                    DataTitleModel(name: 'Phone', flex: 3),
                    DataTitleModel(name: 'Status', flex: 2),
                    DataTitleModel(name: 'Birthday', flex: 3),
                  ],
                ),
              ),
              const SizedBox(width: 66),
            ],
          ),
          const Divider(thickness: 3, height: 1),
          Expanded(
            child: Obx(
              () {
                final List<StaffResponse> data = controller.staffList.value;
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(thickness: 1),
                  itemBuilder: (context, index) => Row(
                    children: [
                      Expanded(
                        child: DataTitleWidget(
                          leftSpacing: 16,
                          verticalPadding: 8,
                          titles: [
                            DataTitleModel(
                                name: data[index].name ?? '', flex: 4),
                            DataTitleModel(
                                name: data[index].address ?? '', flex: 4),
                            DataTitleModel(
                                name: data[index].phone ?? '', flex: 3),
                            DataTitleModel(
                              name: (data[index].status == null)
                                  ? ''
                                  : data[index].status!
                                      ? 'Active'
                                      : 'Inactive',
                              flex: 2,
                            ),
                            DataTitleModel(
                                name: data[index].birthday == null
                                    ? ''
                                    : (data[index]
                                            .birthday!
                                            .parseDateTime('yyyy-MM-dd'))
                                        .formatDateTime('dd-MM-yyyy'),
                                flex: 3),
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
                                controller.showAddEditStaffDialog(
                                  staff: data[index],
                                );
                                break;
                              case 'delete':
                                (data[index].id?.isEmpty ?? true)
                                    ? null
                                    : controller.showDeleteDialog(
                                        data[index].id!,
                                      );
                                break;
                            }
                          },
                        ),
                      ).paddingOnly(right: 16),
                    ],
                  ),
                  itemCount: data.length,
                );
              },
            ),
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}
