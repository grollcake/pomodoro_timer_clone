import 'package:flutter/material.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:pomodoro_timer_clone/models/data.dart';

class TimerController extends ChangeNotifier {
  bool _isActive = false;
  late List<TimerStage> _stageQue;
  int _stageIndex = 0;
  late final PausableTimer _timer;
  late Duration _remainTime;
  double _remainRatio = 1.0;

  TimerController() {
    _init();
    _timer = PausableTimer(Duration(seconds: 1), _countDown);
    notifyListeners();
  }

  ///////////////////////////////////
  // getter
  bool get isActive => _isActive;

  Duration get remainTime => _remainTime;

  double get remainRatio => _remainRatio;

  List<TimerStage> get stageQue => _stageQue;

  int get stageIndex => _stageIndex;

  PausableTimer get timer => _timer;

  ///////////////////////////////////
  // methods
  void start() {
    _isActive = true;
    _timer.start();
    notifyListeners();
  }

  void pause() {
    _isActive = false;
    _timer.pause();
    notifyListeners();
  }

  void toggle() {
    if (_isActive) {
      pause();
    } else {
      start();
    }
  }

  void skipNext({bool timeUp = false}) {
    if (!timeUp && _isActive) return;
    if (_stageIndex == _stageQue.length - 1) return;
    _stageIndex++;
    _remainTime = _getStageDuration(_stageQue[_stageIndex]);
    _remainRatio = 1;
    _timer.reset();
    _timer.start();
    _isActive = true;
    notifyListeners();
  }

  void skipBack() {
    if (_stageIndex == 0) return;
    _stageIndex--;
    _remainTime = _getStageDuration(_stageQue[_stageIndex]);
    _remainRatio = 1;
    _timer.reset();
    _timer.start();
    _isActive = true;
    notifyListeners();
  }

  ///////////////////////////////////
  // private methods
  void _init() {
    _stageIndex = 0;
    _stageQue = [
      TimerStage.work,
      TimerStage.rest,
      TimerStage.work,
      TimerStage.longRest,
      TimerStage.work,
    ];
    _remainTime = _getStageDuration(_stageQue[_stageIndex]);
    _remainRatio = _remainTime.inSeconds / _getStageDuration(_stageQue[_stageIndex]).inSeconds;
  }

  void _countDown() {
    _timer.reset();
    _timer.start();

    _remainTime -= Duration(seconds: 1);
    if (_remainTime <= Duration.zero) {
      skipNext(timeUp: true);
    } else {
      _remainRatio = _remainTime.inSeconds / _getStageDuration(_stageQue[_stageIndex]).inSeconds;
      notifyListeners();
    }
  }

  Duration _getStageDuration(TimerStage stage) {
    switch (stage) {
      case TimerStage.work:
        return Duration(minutes: 3);
      case TimerStage.rest:
        return Duration(seconds: 30);
      case TimerStage.longRest:
        return Duration(minutes: 1);
    }
  }
}
