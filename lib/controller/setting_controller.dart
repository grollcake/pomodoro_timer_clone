import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/models/data.dart';
import 'package:pomodoro_timer_clone/models/enums.dart';

class SettingController with ChangeNotifier {
  final TimerController timerController;

  SettingController(this.timerController) : super() {
    // Timer(Duration.zero, () => setSchedulePreset(_schedulePresetIndex));
  }

  int _schedulePresetIndex = 0;
  Duration _workDuration = kSchedulePresets[0][0];
  Duration _restDuration = kSchedulePresets[0][1];
  Duration _longRestDuration = kSchedulePresets[0][2];

  Duration get workDuration => _workDuration;
  Duration get restDuration => _restDuration;
  Duration get longRestDuration => _longRestDuration;

  DisplayStyle _displayStyle = DisplayStyle.approximate;

  int get schedulePresetIndex => _schedulePresetIndex;

  DisplayStyle get displayStyle => _displayStyle;

  void setSchedulePreset(int index) {
    _schedulePresetIndex = index;
    _workDuration = kSchedulePresets[index][0];
    _restDuration = kSchedulePresets[index][1];
    _longRestDuration = kSchedulePresets[index][2];
    timerController.setStageDuration(TimerStage.work, _workDuration);
    timerController.setStageDuration(TimerStage.rest, _restDuration);
    timerController.setStageDuration(TimerStage.longRest, _longRestDuration);
    notifyListeners();
  }

  void setIndividualSechedule(TimerStage stage, Duration duration) {
    switch (stage) {
      case TimerStage.work:
        _workDuration = duration;
        timerController.setStageDuration(TimerStage.work, _workDuration);
        break;
      case TimerStage.rest:
        _restDuration = duration;
        timerController.setStageDuration(TimerStage.rest, _restDuration);
        break;
      case TimerStage.longRest:
        _longRestDuration = duration;
        timerController.setStageDuration(TimerStage.longRest, _longRestDuration);
        break;
      case TimerStage.done:
        return;
    }

    // 개별 수정한 스케쥴이 미리 정의된 스케쥴세트와 일치하는지 확인
    bool isMatched = false;
    for (int i = 0; i < kSchedulePresets.length; i++) {
      if (_workDuration == kSchedulePresets[i][0] &&
          _restDuration == kSchedulePresets[i][1] &&
          _longRestDuration == kSchedulePresets[i][2]) {
        _schedulePresetIndex = i;
        isMatched = true;
      }
    }

    if (!isMatched) _schedulePresetIndex = -1;

    // 모든 UI는 변경사항을 반영하라
    notifyListeners();
  }

  void setDisplayStyle(DisplayStyle displayStyle) {
    _displayStyle = displayStyle;
    notifyListeners();
  }
}
