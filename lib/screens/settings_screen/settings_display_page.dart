import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';

class SettingsDisplayPage extends StatefulWidget {
  const SettingsDisplayPage({Key? key}) : super(key: key);

  @override
  State<SettingsDisplayPage> createState() => _SettingsDisplayPageState();
}

class _SettingsDisplayPageState extends State<SettingsDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (_, index) => Container(
          padding: EdgeInsets.all(20),
          child: Text('[$index] Display Setting', style: menuTextStyle),
        ),
      ),
    );
  }
}
