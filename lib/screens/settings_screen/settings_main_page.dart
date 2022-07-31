import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/components/checkbox_item.dart';

class SettingsMainPage extends StatefulWidget {
  const SettingsMainPage({Key? key}) : super(key: key);

  @override
  State<SettingsMainPage> createState() => _SettingsMainPageState();
}

class _SettingsMainPageState extends State<SettingsMainPage> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckBoxItem(
          title: 'Play audio',
          desc: 'Let the app play sounds when a section is over',
          checked: _isChecked,
          onChanged: (value) => setState(() => _isChecked = !_isChecked),
        ),
        if (_isChecked)
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xFFFDE047),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded),
                SizedBox(width: 8),
                Text('Sorry, sound has not been implemented', style: descTextStyle),
              ],
            ),
          ),
        Divider(),
      ],
    );
  }
}
