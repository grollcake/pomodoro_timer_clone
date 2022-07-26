import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Center(
        child: Text('Settings Screen'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFE5E7EB),
          elevation: 0.0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_input_composite_rounded),
              label: 'Main',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Main',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm),
              label: 'Main',
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        title: Text('SETTINGS', style: settingTitleTextStyle),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close),
            color: Colors.black,
          ),
        ],
      );
}
