import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/main.dart';
import 'package:pomodoro_timer_clone/models/data.dart';
import 'package:pomodoro_timer_clone/models/enums.dart';

class SettingController with ChangeNotifier {
  final TimerController timerController;

  SettingController(this.timerController) : super() {
    _initialize();
  }

  late int _totalCountOfSets;
  int get totalCountOfSets => _totalCountOfSets;

  late int _longBreakInterval;
  int get longBreakInterval => _longBreakInterval;

  late int _schedulePresetIndex;
  Duration _workDuration = kSchedulePresets[0][0];
  Duration _restDuration = kSchedulePresets[0][1];
  Duration _longRestDuration = kSchedulePresets[0][2];

  Duration get workDuration => _workDuration;
  Duration get restDuration => _restDuration;
  Duration get longRestDuration => _longRestDuration;

  late DisplayStyle _displayStyle;
  int get schedulePresetIndex => _schedulePresetIndex;
  DisplayStyle get displayStyle => _displayStyle;

  void setTotalCountOfSets(int count) {
    _totalCountOfSets = count;
    persistentSettingController.totalCountOfSets = count;
    timerController.setStageQue(_totalCountOfSets, _longBreakInterval);
  }

  void setLongBreakInterval(int interval) {
    _longBreakInterval = interval;
    persistentSettingController.longBreakInterval = interval;
    timerController.setStageQue(_totalCountOfSets, _longBreakInterval);
  }

  void setSchedulePreset(int index) {
    _schedulePresetIndex = index;

    _workDuration = kSchedulePresets[index][0];
    _restDuration = kSchedulePresets[index][1];
    _longRestDuration = kSchedulePresets[index][2];

    persistentSettingController.workDuration = _workDuration;
    persistentSettingController.restDuration = _restDuration;
    persistentSettingController.longRestDuration = _longRestDuration;

    timerController.setStageDuration(TimerStage.work, _workDuration);
    timerController.setStageDuration(TimerStage.rest, _restDuration);
    timerController.setStageDuration(TimerStage.longRest, _longRestDuration);
    notifyListeners();
  }

  void setIndividualSechedule(TimerStage stage, Duration duration) {
    switch (stage) {
      case TimerStage.work:
        _workDuration = duration;
        persistentSettingController.workDuration = _workDuration;
        timerController.setStageDuration(TimerStage.work, _workDuration);
        break;
      case TimerStage.rest:
        _restDuration = duration;
        persistentSettingController.restDuration = _restDuration;
        timerController.setStageDuration(TimerStage.rest, _restDuration);
        break;
      case TimerStage.longRest:
        _longRestDuration = duration;
        persistentSettingController.longRestDuration = _longRestDuration;
        timerController.setStageDuration(TimerStage.longRest, _longRestDuration);
        break;
      case TimerStage.done:
        return;
    }

    // 개별 수정한 스케쥴이 미리 정의된 스케쥴세트와 일치하는지 확인
    _schedulePresetIndex = _getMatchingPresetIndex();

    // 모든 UI는 변경사항을 반영하라
    notifyListeners();
  }

  void setDisplayStyle(DisplayStyle displayStyle) {
    _displayStyle = displayStyle;
    persistentSettingController.displayStyle = _displayStyle.index;
    notifyListeners();
  }

  void _initialize() {
    _totalCountOfSets = persistentSettingController.totalCountOfSets;
    _longBreakInterval = persistentSettingController.longBreakInterval;
    _displayStyle = DisplayStyle.values[persistentSettingController.displayStyle];
    _workDuration = persistentSettingController.workDuration;
    _restDuration = persistentSettingController.restDuration;
    _longRestDuration = persistentSettingController.longRestDuration;
    _schedulePresetIndex = _getMatchingPresetIndex();
  }

  // 개별 스케쥴 값이 미리 정의된 스케쥴세트와 일치하면 세트번호 반환
  int _getMatchingPresetIndex() {
    for (int i = 0; i < kSchedulePresets.length; i++) {
      if (_workDuration == kSchedulePresets[i][0] &&
          _restDuration == kSchedulePresets[i][1] &&
          _longRestDuration == kSchedulePresets[i][2]) {
        return i;
      }
    }
    return -1;
  }
}
