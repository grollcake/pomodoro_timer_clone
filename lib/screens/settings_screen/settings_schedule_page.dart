import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';

class SettingsSchedulePage extends StatefulWidget {
  const SettingsSchedulePage({Key? key}) : super(key: key);

  @override
  State<SettingsSchedulePage> createState() => _SettingsSchedulePageState();
}

class _SettingsSchedulePageState extends State<SettingsSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (_, index) => Container(
          padding: EdgeInsets.all(20),
          child: Text('[$index] Schedule Setting', style: menuTextStyle),
        ),
      ),
    );
  }
}
