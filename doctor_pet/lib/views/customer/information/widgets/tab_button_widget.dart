import 'package:flutter/material.dart';

class TabButtonWidget extends StatelessWidget {
  const TabButtonWidget({
    Key? key,
    required this.isSelected,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final bool isSelected;
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          onTap: onTap,
          selected: isSelected,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isSelected
                ? BorderSide.none
                : const BorderSide(color: Colors.black),
          ),
          selectedTileColor: Theme.of(context).primaryColor,
          selectedColor: Colors.white,
          textColor: isSelected ? Colors.white : Colors.black,
          title: Text(title),
        ),
      ),
    );
  }
}
