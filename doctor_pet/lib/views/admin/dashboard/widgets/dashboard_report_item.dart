import 'package:flutter/material.dart';

class DashBoardReportItem extends StatelessWidget {
  const DashBoardReportItem({
    Key? key,
    required this.model,
    required this.number,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.icon,
    this.onTabChanged,
  }) : super(key: key);

  final String model;
  final String number;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final IconData? icon;
  final Function()? onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: const Color.fromARGB(242, 227, 227, 227),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Icon(icon, color: color, size: 55),
              ),
              Text(
                number.toString(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: onTabChanged,
                child:
                    Text(model, style: const TextStyle(color: Colors.black54)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
