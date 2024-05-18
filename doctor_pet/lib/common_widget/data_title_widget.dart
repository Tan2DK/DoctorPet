import 'package:flutter/material.dart';

import 'package:doctor_pet/core/data/data_title_model.dart';

class DataTitleWidget extends StatelessWidget {
  const DataTitleWidget({
    Key? key,
    required this.titles,
    this.style,
    this.leftSpacing = 90,
    this.bgColor,
    this.verticalPadding,
    this.onTap,
  }) : super(key: key);

  final List<DataTitleModel> titles;
  final TextStyle? style;
  final double? leftSpacing;
  final Color? bgColor;
  final double? verticalPadding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(width: leftSpacing),
            ...titles
                .map(
                  (e) => Flexible(
                    flex: e.flex,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: verticalPadding ?? 0)
                              .copyWith(right: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: Text(e.name, style: style)),
                          if (e.action != null) ...[
                            const SizedBox(width: 4),
                            SizedBox(
                              height: 32,
                              child: TextButton.icon(
                                label: Text(e.actionName ?? ''),
                                onPressed: e.action,
                                icon: const Icon(Icons.edit, size: 16),
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
