import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';

class InputBoxItem extends StatefulWidget {
  const InputBoxItem({Key? key}) : super(key: key);

  @override
  State<InputBoxItem> createState() => _InputBoxItemState();
}

class _InputBoxItemState extends State<InputBoxItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Long Break interval', style: menuTextStyle),
              Text('This is a description', style: descTextStyle),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: TextField(
            textAlign: TextAlign.right,
            keyboardType: TextInputType.number,
            style: menuTextStyle,
          ),
        ),
      ],
    );
  }
}
