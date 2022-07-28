import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/components/inputbox_item.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/components/select_card_item.dart';

class SettingsSchedulePage extends StatefulWidget {
  const SettingsSchedulePage({Key? key}) : super(key: key);

  @override
  State<SettingsSchedulePage> createState() => _SettingsSchedulePageState();
}

class _SettingsSchedulePageState extends State<SettingsSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputBoxItem(title: 'Long Break interval', defalutValue: '3'),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Divider(color: Colors.grey, thickness: 0.5),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text('Schedule preset', style: menuTextStyle),
        ),
        SelectCardItem(onChanged: (int index) {}, cards: [
          ['DEFAULT', 'The default Pomodoro values.'],
          ['DEFAULT1', 'The default Pomodoro values.1'],
          ['DEFAULT2', 'The default Pomodoro values.1'],
        ]),
      ],
    );
  }
}
