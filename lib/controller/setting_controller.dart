import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/models/enums.dart';

class SettingController with ChangeNotifier {
  final TimerController timerController;

  SettingController(this.timerController) : super();

  int _schedulePresetIndex = 0;

  DisplayStyle _displayStyle = DisplayStyle.approximate;

  int get schedulePresetIndex => _schedulePresetIndex;

  DisplayStyle get displayStyle => _displayStyle;

  void setSchedulePreset(int index) {
    _schedulePresetIndex = index;
    if (index == 0) {
      timerController.setStageDuration(TimerStage.work, Duration(minutes: 25));
      timerController.setStageDuration(TimerStage.rest, Duration(minutes: 5));
      timerController.setStageDuration(TimerStage.longRest, Duration(minutes: 15));
    } else if (index == 1) {
      timerController.setStageDuration(TimerStage.work, Duration(minutes: 15));
      timerController.setStageDuration(TimerStage.rest, Duration(minutes: 5));
      timerController.setStageDuration(TimerStage.longRest, Duration(minutes: 15));
    } else if (index == 2) {
      timerController.setStageDuration(TimerStage.work, Duration(minutes: 40));
      timerController.setStageDuration(TimerStage.rest, Duration(minutes: 10));
      timerController.setStageDuration(TimerStage.longRest, Duration(minutes: 30));
    } else if (index == 4) {
      timerController.setStageDuration(TimerStage.work, Duration(minutes: 50));
      timerController.setStageDuration(TimerStage.rest, Duration(minutes: 10));
      timerController.setStageDuration(TimerStage.longRest, Duration(minutes: 30));
    }
    notifyListeners();
  }

  void setDisplayStyle(DisplayStyle displayStyle) {
    _displayStyle = displayStyle;
    timerController.setDisplayStyle(displayStyle);
    notifyListeners();
  }
}
