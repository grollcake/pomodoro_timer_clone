import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/components/inputbox_item.dart';

class SettingsSchedulePage extends StatefulWidget {
  const SettingsSchedulePage({Key? key}) : super(key: key);

  @override
  State<SettingsSchedulePage> createState() => _SettingsSchedulePageState();
}

class _SettingsSchedulePageState extends State<SettingsSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputBoxItem(),
        Divider(),
      ],
    );
  }
}
