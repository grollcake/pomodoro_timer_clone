import 'package:flutter/material.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:pomodoro_timer_clone/constants/constants.dart';
import 'package:pomodoro_timer_clone/main.dart';
import 'package:pomodoro_timer_clone/models/data.dart';
import 'package:pomodoro_timer_clone/models/enums.dart';

enum TimerStatus {
  ready,
  playing,
  paused,
  skippingBack,
  skippingNext,
  finished,
}

class TimerController extends ChangeNotifier {
  late List<TimerStage> _stageQue;
  int _stageIndex = 0;
  late final PausableTimer _timer;
  late Duration _remainTime;
  double _progressRatio = 0.0;
  TimerStatus _status = TimerStatus.ready;
  Duration _workDuration = kSchedulePresets[0][0];
  Duration _breakDuration = kSchedulePresets[0][1];
  Duration _longBreakDuration = kSchedulePresets[0][2];

  TimerController() {
    _initialize();
    _timer = PausableTimer(Duration(seconds: 1), _timeGoesBy);
    notifyListeners();
  }

  ///////////////////////////////////
  // getter
  Duration get remainTime => _remainTime;

  double get displayRatio => _progressRatio;

  List<TimerStage> get stageQue => _stageQue;

  int get stageIndex => _stageIndex;

  PausableTimer get timer => _timer;

  TimerStatus get status => _status;

  String get stageName => _stageName();

  Color get stageColor => _stageColor(_stageQue[_stageIndex]);

  Color get nextStageColor =>
      _stageIndex < _stageQue.length - 1 ? _stageColor(_stageQue[_stageIndex + 1]) : _stageColor(TimerStage.done);

  Color stageColorByIdx(int idx) => _stageColor(_stageQue[idx]);

  Duration stageDurationById(int idx) => _getStageDuration(_stageQue[idx]);

  ///////////////////////////////////
  // public methods

  // 현재 스테이지 시작
  void start() {
    _timer.reset();
    _timer.start();
    _remainTime = _getStageDuration(_stageQue[_stageIndex]);
    _status = TimerStatus.playing;
    _calcProgressRatio();
    notifyListeners();
  }

  // 일시 정지
  void pause() {
    _timer.pause();
    _status = TimerStatus.paused;
    notifyListeners();
  }

  // 일시 정지 상태에서 재시작
  void resume() {
    _timer.start();
    _status = TimerStatus.playing;
    notifyListeners();
  }

  // 모든 스테이지 종료 후 재시작
  void reset() {
    _initialize();
    _calcProgressRatio();
    notifyListeners();
  }

  // 메인 버튼 동작
  void circleButton() async {
    if (_status == TimerStatus.finished) {
      reset();
    } else if (_status == TimerStatus.playing) {
      pause();
    } else if (_status == TimerStatus.paused) {
      resume();
    } else if (_status == TimerStatus.ready) {
      start();
    }
  }

  // 다음 스테이지로 이동
  void skipNext() async {
    if (_status == TimerStatus.playing) return;
    if (_stageIndex == _stageQue.length - 1) return;

    _timer.reset();
    _timer.pause();
    _status = TimerStatus.skippingNext;
    _calcProgressRatio();
    notifyListeners();
    await Future.delayed(kTransitionDuration);

    _stageIndex++;
    _status = TimerStatus.ready;
    _calcProgressRatio();
    _remainTime = _getStageDuration(_stageQue[_stageIndex]);
    notifyListeners();
  }

  // 현재 스테이지의 처음으로 이동
  void skipBack() async {
    _timer.reset();
    _timer.pause();
    _status = TimerStatus.skippingBack;
    _calcProgressRatio();
    notifyListeners();
    await Future.delayed(kTransitionDuration);

    _status = TimerStatus.ready;
    _calcProgressRatio();
    _remainTime = _getStageDuration(_stageQue[_stageIndex]);
    notifyListeners();
  }

  ///////////////////////////////////
  // 설정 관련
  void setStageQue(int totalCountOfSets, int longBreakInterval) {
    _setStageQue(totalCountOfSets, longBreakInterval);
    notifyListeners();
  }

  void setStageDuration(TimerStage stage, Duration duration) {
    switch (stage) {
      case TimerStage.work:
        _workDuration = duration;
        break;
      case TimerStage.rest:
        _breakDuration = duration;
        break;
      case TimerStage.longRest:
        _longBreakDuration = duration;
        break;
      case TimerStage.done:
        break;
    }
    _remainTime = _getStageDuration(_stageQue[_stageIndex]);
    notifyListeners();
  }

  ///////////////////////////////////
  // private methods
  void _initialize() {
    _stageIndex = 0;

    int totalCountOfSets = persistentSettingController.totalCountOfSets;
    int longBreakInterval = persistentSettingController.longBreakInterval;
    _setStageQue(totalCountOfSets, longBreakInterval);
    _status = TimerStatus.ready;
  }

  void _setStageQue(int totalCountOfSets, int longBreakInterval) {
    _stageQue = [];
    for (int i = 0; i < totalCountOfSets; i++) {
      _stageQue.add(TimerStage.work);
      _stageQue.add((i + 1) % longBreakInterval == 0 ? TimerStage.longRest : TimerStage.rest);
    }
    _remainTime = _getStageDuration(_stageQue[_stageIndex]);
  }

  void _timeGoesBy() {
    _timer.reset();
    _timer.start();

    _remainTime -= Duration(seconds: 1);
    if (_remainTime <= Duration.zero) {
      _goNext();
    } else {
      _status = TimerStatus.playing;
      _calcProgressRatio();
      notifyListeners();
    }
  }

  void _goNext() async {
    if (_stageIndex < _stageQue.length - 1) {
      _stageIndex++;
      _status = TimerStatus.ready;
      _calcProgressRatio();
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 100));
      start();
    } else {
      _timer.reset();
      _timer.pause();
      _status = TimerStatus.finished;
      notifyListeners();
    }
  }

  void _calcProgressRatio() {
    if (_status == TimerStatus.ready || _status == TimerStatus.skippingBack) {
      _progressRatio = 0;
    } else if (_status == TimerStatus.playing) {
      _progressRatio = 1 - ((_remainTime.inSeconds - 1) / _getStageDuration(_stageQue[_stageIndex]).inSeconds);
    } else if (_status == TimerStatus.skippingNext || _status == TimerStatus.finished) {
      _progressRatio = 1;
    }
  }

  Duration _getStageDuration(TimerStage stage) {
    switch (stage) {
      case TimerStage.work:
        return _workDuration;
      case TimerStage.rest:
        return _breakDuration;
      case TimerStage.longRest:
        return _longBreakDuration;
      case TimerStage.done:
        return Duration.zero;
    }
  }

  Color _stageColor(TimerStage stage) {
    switch (stage) {
      case TimerStage.work:
        return Color(0xFFFF6B6B);
      case TimerStage.rest:
        return Color(0xFFF4A261);
      case TimerStage.longRest:
        return Color(0xFF2EC4B6);
      case TimerStage.done:
        return Color(0xFF096FAF);
    }
  }

  String _stageName() {
    switch (_stageQue[_stageIndex]) {
      case TimerStage.work:
        return 'Work';
      case TimerStage.rest:
        return 'Break';
      case TimerStage.longRest:
        return 'Long Break';
      case TimerStage.done:
        return 'Finish';
    }
  }
}
