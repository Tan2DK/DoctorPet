import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'progress_line_widget.dart';
import 'task_widget.dart';

class TaskLineWidget extends StatelessWidget {
  const TaskLineWidget({
    Key? key,
    required this.isFirst,
    required this.isLast,
    required this.thickness,
    required this.taskSize,
    required this.title,
    this.child,
    this.isComplete = false,
  }) : super(key: key);
  final bool isFirst;
  final bool isLast;
  final double thickness;
  final double taskSize;
  final String title;
  final Widget? child;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    final colorStatus = isComplete
        ? Theme.of(context).primaryColor
        : Theme.of(context).disabledColor;
    return IntrinsicWidth(
      child: Column(
        children: [
          Row(
            children: [
              if (!isFirst)
                ProgressLineWidget(
                  color: colorStatus,
                  lineLength: taskSize * 1.5,
                  thickness: thickness,
                  front: true,
                ),
              TaskWidget(
                color: colorStatus,
                size: taskSize,
                title: title,
                child: child ?? const SizedBox(),
              ),
              if (!isLast)
                ProgressLineWidget(
                  color: colorStatus,
                  lineLength: taskSize * 1.5,
                  thickness: thickness,
                  front: false,
                ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                alignment: isFirst
                    ? Alignment.centerLeft
                    : isLast
                        ? Alignment.centerRight
                        : Alignment.center,
                child: Text(
                  title,
                  textAlign: isFirst
                      ? TextAlign.left
                      : isLast
                          ? TextAlign.right
                          : TextAlign.center,
                ).paddingOnly(
                  left: isFirst ? taskSize / 7 : 1,
                  right: isLast ? taskSize / 7 : 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
