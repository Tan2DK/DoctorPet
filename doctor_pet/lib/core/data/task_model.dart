import 'package:flutter/material.dart';

class TaskListModel {
  TaskListModel._();
  static const List<TaskModel> taskData = [
    TaskModel(
      icon: Icons.local_hospital_outlined,
      title: 'Clinic\nSelection',
      isComplete: false,
    ),
    TaskModel(
      icon: Icons.calendar_month,
      title: 'Schedule\nArangement',
      isComplete: false,
    ),
    TaskModel(
      icon: Icons.pets_outlined,
      title: 'Pet\nRegister',
      isComplete: false,
    ),
    TaskModel(
      icon: Icons.check_circle_outline,
      title: 'Booking\nConfirmation',
      isComplete: false,
    ),
  ];
}

class TaskModel {
  final String title;
  final IconData icon;
  final bool isComplete;
  const TaskModel({
    required this.title,
    required this.icon,
    required this.isComplete,
  });

  TaskModel copyWith({
    String? title,
    IconData? icon,
    bool? isComplete,
  }) {
    return TaskModel(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  String toString() =>
      'TaskModel(title: $title, icon: $icon, isComplete: $isComplete)';
}
