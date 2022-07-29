import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/models/enums.dart';

class SettingController with ChangeNotifier {
  final TimerController timerController;

  DisplayStyle _displayStyle = DisplayStyle.approximate;

  SettingController(this.timerController) : super();

  DisplayStyle get displayStyle => _displayStyle;

  void setDisplayStyle(DisplayStyle displayStyle) {
    _displayStyle = displayStyle;
    timerController.setDisplayStyle(displayStyle);
    notifyListeners();
  }
}
