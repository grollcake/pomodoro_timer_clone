import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/components/checkbox_item.dart';

class SettingsMainPage extends StatefulWidget {
  const SettingsMainPage({Key? key}) : super(key: key);

  @override
  State<SettingsMainPage> createState() => _SettingsMainPageState();
}

class _SettingsMainPageState extends State<SettingsMainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckBoxItem(
          title: 'Reset settings',
          desc: 'All settings will be reset after the app is reloaded',
          checked: true,
          onChanged: (value) {},
        ),
        CheckBoxItem(
          title: 'Reset settings',
          desc: 'All settings will be reset after the app is reloaded',
          checked: false,
          onChanged: (value) {},
        ),
        Divider(),
      ],
    );
  }
}
