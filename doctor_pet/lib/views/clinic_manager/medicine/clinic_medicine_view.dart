import 'package:doctor_pet/common_widget/custom_button/custom_button_action_widget.dart';
import 'package:doctor_pet/common_widget/custom_searchbar_widget.dart';
import 'package:doctor_pet/common_widget/custom_text/custom_text_widget.dart';
import 'package:doctor_pet/core/data/response/medicine_response.dart';
import 'package:doctor_pet/views/clinic_manager/medicine/clinic_medicine_controller.dart';
import 'package:flutter/material.dart';
import 'package:doctor_pet/common_widget/data_title_widget.dart';
import 'package:get/get.dart';
import '../../../core/data/data_title_model.dart';

class ClinicMedicineView extends GetView<ClinicMedicineController> {
  const ClinicMedicineView({super.key});
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
                text: 'Medicine Management',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButtonActionWidget(
              label: 'Add Medicine',
              bgColor: Colors.blue,
              txtColor: Colors.white,
              icon: Icons.add,
              iconColor: Colors.white,
              onPressed: controller.showAddEditMedicineDialog,
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
                    DataTitleModel(name: 'Name', flex: 3),
                    DataTitleModel(name: 'Medicine Unit', flex: 2),
                    DataTitleModel(name: 'Price', flex: 2),
                    DataTitleModel(name: 'Inventory', flex: 2),
                    DataTitleModel(name: 'Specifications', flex: 4),
                    DataTitleModel(name: 'Category', flex: 3),
                  ],
                ),
              ),
              const SizedBox(width: 66),
            ],
          ),
          const Divider(thickness: 3),
          Expanded(
            child: Obx(() {
              final List<MedicineResponse> data = controller.medicineList.value;
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1),
                itemBuilder: (context, index) => Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: DataTitleWidget(
                        leftSpacing: 16,
                        verticalPadding: 8,
                        titles: [
                          DataTitleModel(
                              name: data[index].medicineName ?? '', flex: 3),
                          DataTitleModel(
                              name: data[index].medicineUnit ?? '', flex: 2),
                          DataTitleModel(
                              name: data[index].prices == null
                                  ? ''
                                  : data[index].prices.toString(),
                              flex: 2),
                          DataTitleModel(
                              name: data[index].inventory == null
                                  ? ''
                                  : data[index].inventory.toString(),
                              flex: 2),
                          DataTitleModel(
                              name: data[index].specifications ?? '', flex: 4),
                          DataTitleModel(
                              name: data[index].medicineCateName ?? '',
                              flex: 3),
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
                              controller.showAddEditMedicineDialog(
                                medicine: data[index],
                              );
                              break;
                            case 'delete':
                              controller.showDeleteMedicineDialog(
                                  data[index].medicineId ?? '');
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
