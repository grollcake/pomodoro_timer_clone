import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/setting_controller.dart';
import 'package:pomodoro_timer_clone/models/enums.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/components/inputbox_item.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/components/select_card_item.dart';
import 'package:provider/provider.dart';

class SettingsSchedulePage extends StatefulWidget {
  const SettingsSchedulePage({Key? key}) : super(key: key);

  @override
  State<SettingsSchedulePage> createState() => _SettingsSchedulePageState();
}

class _SettingsSchedulePageState extends State<SettingsSchedulePage> {
  late Duration _workDuration;
  late Duration _breakDuration;
  late Duration _longBreakDuration;

  String _formatDuration(Duration duration) {
    final String min = duration.inMinutes.toString().padLeft(2, '0');
    final String sec = (duration.inSeconds - duration.inMinutes * 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  void _timeChange(TimerStage stage, String timeString) {
    final settingController = Provider.of<SettingController>(context, listen: false);

    int min = int.parse(timeString.split(':')[0]);
    int sec = int.parse(timeString.split(':')[1]);
    settingController.setIndividualSechedule(stage, Duration(minutes: min, seconds: sec));
  }

  @override
  Widget build(BuildContext context) {
    final settingController = Provider.of<SettingController>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputBoxItem(
            title: 'Total count of sets',
            desc: 'Number of iterations',
            regex: r'^\d{1,2}$',
            formatErrorMessage: 'Incorrectly formatted number (1 to 99)',
            defalutValue: settingController.totalCountOfSets.toString(),
            onSubmitted: (value) => settingController.setTotalCountOfSets(int.parse(value)),
          ),
          _buildDivider(),
          InputBoxItem(
            title: 'Long Break interval',
            regex: r'^\d{1,2}$',
            formatErrorMessage: 'Incorrectly formatted number (0 to 99)',
            defalutValue: settingController.longBreakInterval.toString(),
            onSubmitted: (value) => settingController.setLongBreakInterval(int.parse(value)),
          ),
          _buildDivider(),
          SelectCardItem(
            title: 'Schedule preset',
            onChanged: (int index) => settingController.setSchedulePreset(index),
            selectedIndex: settingController.schedulePresetIndex,
            cards: [
              ['DEFAULT', 'The default Pomodoro values.'],
              ['BEGINNER', 'For those who haven\'t yet tried the Pomodoro technique.'],
              ['ADVANCED', 'Work slightly more effectively.'],
              ['WORKAHOLIC', 'For long work sessions.'],
            ],
          ),
          InputBoxItem(
            title: 'Work',
            regex: r'^[0-9]{1,2}:[0-9]{1,2}$',
            formatErrorMessage: 'Incorrectly formatted time (MM:SS)',
            defalutValue: _formatDuration(settingController.workDuration),
            onSubmitted: (timeString) => _timeChange(TimerStage.work, timeString),
          ),
          InputBoxItem(
            title: 'Break',
            regex: r'^[0-9]{1,2}:[0-9]{1,2}$',
            formatErrorMessage: 'Incorrectly formatted time (MM:SS)',
            defalutValue: _formatDuration(settingController.restDuration),
            onSubmitted: (timeString) => _timeChange(TimerStage.rest, timeString),
          ),
          InputBoxItem(
            title: 'Long break',
            regex: r'^[0-9]{1,2}:[0-9]{1,2}$',
            formatErrorMessage: 'Incorrectly formatted time (MM:SS)',
            defalutValue: _formatDuration(settingController.longRestDuration),
            onSubmitted: (timeString) => _timeChange(TimerStage.longRest, timeString),
          ),
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
