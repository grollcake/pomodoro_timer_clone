import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';

class SelectBoxItem extends StatelessWidget {
  const SelectBoxItem({Key? key, required this.title, required this.desc, required this.selected}) : super(key: key);

  final String title;
  final String desc;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: selected ? primaryColor : Colors.white,
          border: selected ? null : Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: settingsText1),
            Text(desc, style: descTextStyle),
          ],
        ),
      ),
    );
  }
}
