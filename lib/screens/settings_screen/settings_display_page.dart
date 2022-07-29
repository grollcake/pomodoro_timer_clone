import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/setting_controller.dart';
import 'package:pomodoro_timer_clone/models/enums.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/components/select_card_item.dart';
import 'package:provider/provider.dart';

class SettingsDisplayPage extends StatefulWidget {
  const SettingsDisplayPage({Key? key}) : super(key: key);

  @override
  State<SettingsDisplayPage> createState() => _SettingsDisplayPageState();
}

class _SettingsDisplayPageState extends State<SettingsDisplayPage> {
  @override
  Widget build(BuildContext context) {
    final settingController = context.watch<SettingController>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectCardItem(
            title: 'Timer style',
            selectedIndex: settingController.displayStyle.index,
            onChanged: (int index) {
              if (index == 0) {
                settingController.setDisplayStyle(DisplayStyle.traditional);
              } else if (index == 1) {
                settingController.setDisplayStyle(DisplayStyle.approximate);
              } else if (index == 2) {
                settingController.setDisplayStyle(DisplayStyle.percentage);
              }
            },
            cards: [
              ['TRADITIONAL', '12:34'],
              ['APPROXIMATE', '13 minutes'],
              ['PERCENTAGE', '50%'],
            ],
          ),
        ],
      ),
    );
  }
}
