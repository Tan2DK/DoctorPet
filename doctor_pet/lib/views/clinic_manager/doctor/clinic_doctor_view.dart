import 'package:doctor_pet/common_widget/custom_searchbar_widget.dart';
import 'package:doctor_pet/common_widget/custom_text/custom_text_widget.dart';
import 'package:doctor_pet/core/data/data_title_model.dart';
import 'package:doctor_pet/core/data/response/doctor_response.dart';
import 'package:doctor_pet/utils/app_extension.dart';
import 'package:doctor_pet/views/clinic_manager/doctor/clinic_doctor_controller.dart';
import 'package:flutter/material.dart';
import 'package:doctor_pet/common_widget/data_title_widget.dart';
import 'package:get/get.dart';
import '../../../common_widget/custom_button/custom_button_action_widget.dart';

class ClinicDoctorView extends GetView<ClinicDoctorController> {
  const ClinicDoctorView({super.key});
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
              // ignore: unnecessary_const
              const CustomTextWidget(
                text: 'Doctor Management',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButtonActionWidget(
              label: 'Add Doctor',
              bgColor: Colors.blue,
              txtColor: Colors.white,
              icon: Icons.add,
              iconColor: Colors.white,
              onPressed: controller.showAddEditDialog,
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
                    DataTitleModel(name: 'Doctor Name', flex: 2),
                    DataTitleModel(name: 'Address', flex: 2),
                    DataTitleModel(name: 'Phone', flex: 2),
                    DataTitleModel(name: 'Birthday', flex: 2),
                    DataTitleModel(name: 'Degree', flex: 2),
                    DataTitleModel(name: 'Specialized', flex: 2),
                    DataTitleModel(name: 'Status', flex: 1),
                  ],
                ),
              ),
              const SizedBox(width: 66),
            ],
          ),
          const Divider(thickness: 3),
          Expanded(
            child: Obx(() {
              final List<DoctorResponse> data = controller.doctorList.value;
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
                              name: data[index].doctorName ?? '', flex: 2),
                          DataTitleModel(
                              name: data[index].address ?? '', flex: 2),
                          DataTitleModel(
                              name: data[index].phoneNumber ?? '', flex: 2),
                          DataTitleModel(
                              name: data[index].birthday == null
                                  ? ''
                                  : (data[index]
                                          .birthday!
                                          .parseDateTime('yyyy-MM-dd'))
                                      .formatDateTime('dd-MM-yyyy'),
                              flex: 2),
                          DataTitleModel(
                              name: controller.degreeList.value
                                      .firstWhereOrNull(
                                        (degree) =>
                                            degree.degreeId ==
                                            data[index].degreeId,
                                      )
                                      ?.degreeName ??
                                  '',
                              flex: 2),
                          DataTitleModel(
                              name: data[index].specialized ?? '', flex: 2),
                          DataTitleModel(
                            name: (data[index].doctorStatus == null)
                                ? ''
                                : data[index].doctorStatus!
                                    ? 'Active'
                                    : 'Inactive',
                            flex: 1,
                          ),
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
                                data[index].doctorId ?? '',
                              );
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
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
