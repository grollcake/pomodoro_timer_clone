import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/sections/bottom_nav_section.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/settings_about_page.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/settings_display_page.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/settings_main_page.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/settings_schedule_page.dart';

int _menuIndex = 0;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [SettingsMainPage(), SettingsSchedulePage(), SettingsDisplayPage(), SettingsAboutPage()];
  }

  void _changeMenu(int index) {
    setState(() {
      _menuIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(), // TextField 외부 터치 시 키보드 닫기
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 10.0),
          child: IndexedStack(index: _menuIndex, children: pages),
        ),
        bottomNavigationBar: BottomNavSection(initialIndex: _menuIndex, callBack: (index) => _changeMenu(index)),
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
