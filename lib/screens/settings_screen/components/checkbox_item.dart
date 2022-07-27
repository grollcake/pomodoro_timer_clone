import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';

class CheckBoxItem extends StatelessWidget {
  const CheckBoxItem(
      {Key? key, required this.title, required this.desc, required this.checked, required this.onChanged})
      : super(key: key);
  final String title;
  final String desc;
  final bool checked;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: menuTextStyle),
                Text(desc, style: descTextStyle),
              ],
            ),
          ),
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: BorderSide(
                  color: Colors.grey,
                ),
              ),
              checkColor: Colors.white,
              activeColor: primaryColor,
              value: checked,
              onChanged: (value) => onChanged(value),
            ),
          ),
        ],
      ),
    );
  }
}
