import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';

class SettingsMainPage extends StatefulWidget {
  const SettingsMainPage({Key? key}) : super(key: key);

  @override
  State<SettingsMainPage> createState() => _SettingsMainPageState();
}

class _SettingsMainPageState extends State<SettingsMainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (_, index) => Container(
          padding: EdgeInsets.all(20),
          child: Text('[$index] Main Setting', style: menuTextStyle),
        ),
      ),
    );
  }
}
