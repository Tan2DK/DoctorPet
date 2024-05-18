import 'package:doctor_pet/core/data/task_model.dart';
import 'package:doctor_pet/views/customer/customer_booking/widgets/task_line_widget.dart';
import 'package:flutter/material.dart';

class CustomStepsProgressBarWidget extends StatelessWidget {
  const CustomStepsProgressBarWidget({
    Key? key,
    required this.taskList,
    this.taskSize = 30,
    this.thickness = 10,
    required this.lineLength,
  }) : super(key: key);
  final List<TaskModel> taskList;
  final double taskSize;
  final double thickness;

  final double lineLength;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  TaskLineWidget(
                    isFirst: index == 0,
                    isLast: index == taskList.length - 1,
                    taskSize: 50,
                    thickness: 10,
                    title: taskList[index].title,
                    isComplete: taskList[index].isComplete,
                    child: Icon(
                      taskList[index].icon,
                      color: taskList[index].isComplete
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              );
            },
            itemCount: taskList.length,
          ),
        ),
      ],
    );
  }
}
