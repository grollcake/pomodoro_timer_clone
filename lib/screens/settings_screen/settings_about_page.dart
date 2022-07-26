import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';

class SettingsAboutPage extends StatefulWidget {
  const SettingsAboutPage({Key? key}) : super(key: key);

  @override
  State<SettingsAboutPage> createState() => _SettingsAboutPageState();
}

class _SettingsAboutPageState extends State<SettingsAboutPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (_, index) => Container(
          padding: EdgeInsets.all(20),
          child: Text('[$index] About Setting', style: menuTextStyle),
        ),
      ),
    );
  }
}
