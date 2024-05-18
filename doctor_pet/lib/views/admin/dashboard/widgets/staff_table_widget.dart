import 'package:doctor_pet/utils/app_extension.dart';
import 'package:flutter/material.dart';

import '../../../../common_widget/data_title_widget.dart';
import '../../../../core/data/data_title_model.dart';
import '../../../../core/data/response/staff_response.dart';

class StaffTableWidget extends StatelessWidget {
  const StaffTableWidget({
    Key? key,
    required this.staffList,
  }) : super(key: key);

  final List<StaffResponse> staffList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Staff List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DataTitleWidget(
              leftSpacing: 0,
              titles: [
                DataTitleModel(name: 'Name', flex: 2),
                DataTitleModel(name: 'Address', flex: 2),
                DataTitleModel(name: 'Phone', flex: 2),
                DataTitleModel(name: 'Email', flex: 2),
                DataTitleModel(name: 'Birthday', flex: 2),
                DataTitleModel(name: 'Status', flex: 1),
              ],
            ),
            const Divider(thickness: 3),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(thickness: 1),
              itemBuilder: (context, index) => DataTitleWidget(
                leftSpacing: 0,
                titles: [
                  DataTitleModel(
                    name: staffList[index].name ?? '',
                    flex: 2,
                  ),
                  DataTitleModel(
                    name: staffList[index].address ?? '',
                    flex: 2,
                  ),
                  DataTitleModel(
                    name: staffList[index].phone ?? '',
                    flex: 2,
                  ),
                  DataTitleModel(
                    name: staffList[index].email ?? '',
                    flex: 2,
                  ),
                  DataTitleModel(
                    name: staffList[index].birthday == null
                        ? ''
                        : (staffList[index]
                                .birthday!
                                .parseDateTime('yyyy-MM-dd'))
                            .formatDateTime('dd-MM-yyyy'),
                    flex: 2,
                  ),
                  DataTitleModel(
                    name: (staffList[index].status ?? false)
                        ? 'Active'
                        : 'Inactive',
                    flex: 1,
                  ),
                ],
              ),
              itemCount: staffList.length,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextWidget {
  const CustomTextWidget();
}
