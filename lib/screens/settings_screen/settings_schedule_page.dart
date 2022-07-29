import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/setting_controller.dart';
import 'package:pomodoro_timer_clone/models/data.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/components/inputbox_item.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/components/select_card_item.dart';
import 'package:provider/provider.dart';

class SettingsSchedulePage extends StatefulWidget {
  const SettingsSchedulePage({Key? key}) : super(key: key);

  @override
  State<SettingsSchedulePage> createState() => _SettingsSchedulePageState();
}

class _SettingsSchedulePageState extends State<SettingsSchedulePage> {
  int _selectedScheduleIndex = 0;
  late Duration _workDuration;
  late Duration _breakDuration;
  late Duration _longBreakDuration;

  void _changeSchedule(int index) {
    String key = '';
    if (index == 0) {
      key = 'default';
    } else if (index == 1) {
      key = 'beginner';
    } else if (index == 2) {
      key = 'advanced';
    } else if (index == 3) {
      key = 'workaholic';
    }
    _workDuration = kSchedulePresets[key]![0];
    _breakDuration = kSchedulePresets[key]![1];
    _longBreakDuration = kSchedulePresets[key]![2];
    context.read<SettingController>().setSchedulePreset(index);
  }

  String _formatDuration(Duration duration) {
    final String min = duration.inMinutes.toString().padLeft(2, '0');
    final String sec = (duration.inSeconds - duration.inMinutes * 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override
  void initState() {
    super.initState();
    _changeSchedule(_selectedScheduleIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputBoxItem(title: 'Long Break interval', defalutValue: '3'),
          _buildDivider(),
          SelectCardItem(
            title: 'Schedule preset',
            onChanged: (int index) => setState(() => _changeSchedule(index)),
            selectedIndex: _selectedScheduleIndex,
            cards: [
              ['DEFAULT', 'The default Pomodoro values.'],
              ['BEGINNER', 'For those who haven\'t yet tried the Pomodoro technique.'],
              ['ADVANCED', 'Work slightly more effectively.'],
              ['WORKAHOLIC', 'For long work sessions.'],
            ],
          ),
          InputBoxItem(title: 'Work', defalutValue: _formatDuration(_workDuration)),
          InputBoxItem(title: 'Break', defalutValue: _formatDuration(_breakDuration)),
          InputBoxItem(title: 'Long break', defalutValue: _formatDuration(_longBreakDuration)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Divider(color: Colors.grey, thickness: 0.5),
    );
  }
}
