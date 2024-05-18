import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class TitleValueWidget extends StatelessWidget {
  const TitleValueWidget({
    Key? key,
    required this.title,
    required this.value,
     this.textColor = const Color(0xFF424242),
  }) : super(key: key);

  final String title;
  final String value;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: Text(title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: textColor,
              )),
        ),
        Expanded(
            flex: 4,
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: textColor),
            )),
      ],
    );
  }
}
