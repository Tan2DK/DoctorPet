import 'package:flutter/material.dart';

import '../../../../common_widget/data_title_widget.dart';
import '../../../../core/data/data_title_model.dart';
import '../../../../core/data/response/doctor_response.dart';

class DoctorTableWidget extends StatelessWidget {
  const DoctorTableWidget({
    Key? key,
    required this.doctorList,
  }) : super(key: key);

  final List<DoctorResponse> doctorList;

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
              'Doctor List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DataTitleWidget(
              leftSpacing: 0,
              titles: [
                DataTitleModel(name: 'Name', flex: 2),
                DataTitleModel(name: 'Address', flex: 2),
                DataTitleModel(name: 'Phone', flex: 2),
                DataTitleModel(name: 'Specialize', flex: 2),
                DataTitleModel(name: 'Degree', flex: 2),
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
                    name: doctorList[index].doctorName ?? '',
                    flex: 2,
                  ),
                  DataTitleModel(
                    name: doctorList[index].address ?? '',
                    flex: 2,
                  ),
                  DataTitleModel(
                    name: doctorList[index].phoneNumber ?? '',
                    flex: 2,
                  ),
                  DataTitleModel(
                    name: doctorList[index].specialized ?? '',
                    flex: 2,
                  ),
                  DataTitleModel(
                    name: doctorList[index].degreeId ?? '',
                    flex: 2,
                  ),
                  DataTitleModel(
                    name: (doctorList[index].doctorStatus ?? false)
                        ? 'Active'
                        : 'Inactive',
                    flex: 1,
                  ),
                ],
              ),
              itemCount: doctorList.length,
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
