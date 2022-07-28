import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/components/select_card_item.dart';

class SettingsDisplayPage extends StatefulWidget {
  const SettingsDisplayPage({Key? key}) : super(key: key);

  @override
  State<SettingsDisplayPage> createState() => _SettingsDisplayPageState();
}

class _SettingsDisplayPageState extends State<SettingsDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectCardItem(
            title: 'Timer style',
            onChanged: (int index) {},
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
