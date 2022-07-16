import 'package:flutter/material.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:pomodoro_timer_clone/models/data.dart';

enum TimerControllerEvent {
  ready,
  play,
  pause,
  countDown,
  skipNext,
  skipBack,
}

class TimerController extends ChangeNotifier {
  bool _isActive = false;
  late List<TimerStage> _stageQue;
  int _stageIndex = 0;
  late final PausableTimer _timer;
  late Duration _remainTime;
  double _remainRatio = 1.0;
  TimerControllerEvent _event = TimerControllerEvent.ready;

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

  TimerControllerEvent get event => _event;

  ///////////////////////////////////
  // methods
  void start() {
    _isActive = true;
    _timer.start();
    _event = TimerControllerEvent.play;
    notifyListeners();
  }

  void pause() {
    _isActive = false;
    _timer.pause();
    _event = TimerControllerEvent.pause;
    notifyListeners();
  }

  void toggle() {
    if (_isActive) {
      pause();
    } else {
      start();
    }
  }

  void skipNext({bool timeUp = false}) async {
    if (!timeUp && _isActive) return;
    if (_stageIndex == _stageQue.length - 1) return;
    _timer.reset();
    _remainRatio = 0;
    _event = TimerControllerEvent.skipNext;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));

    _remainRatio = 1;
    _stageIndex++;
    _remainTime = _getStageDuration(_stageQue[_stageIndex]);
    _timer.start();
    _isActive = true;
    notifyListeners();
  }

  void skipBack() async {
    _timer.reset();
    _timer.pause();
    _isActive = false;
    _remainRatio = 1;
    _event = TimerControllerEvent.skipBack;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));

    _remainTime = _getStageDuration(_stageQue[_stageIndex]);
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
      _event = TimerControllerEvent.countDown;
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
