import 'package:flutter/material.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:pomodoro_timer_clone/models/data.dart';

enum TimerControllerEvent {
  ready,
  start,
  pause,
  resume,
  countDown,
  goNext,
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
  double _displayRatio = 0.0;
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

  double get displayRatio => _displayRatio;

  List<TimerStage> get stageQue => _stageQue;

  int get stageIndex => _stageIndex;

  PausableTimer get timer => _timer;

  TimerControllerEvent get event => _event;

  ///////////////////////////////////
  // methods
  void start() {
    _isActive = true;
    _timer.reset();
    _timer.start();
    _remainRatio = 1;
    _remainTime = _getStageDuration(_stageQue[_stageIndex]);
    _event = TimerControllerEvent.start;
    _calcDisplayRatio();
    notifyListeners();
  }

  void pause() {
    _isActive = false;
    _timer.pause();
    _event = TimerControllerEvent.pause;
    notifyListeners();
  }

  void resume() {
    _isActive = true;
    _timer.start();
    _event = TimerControllerEvent.resume;
    notifyListeners();
  }

  void toggle() {
    if (_isActive) {
      pause();
    } else {
      if (_timer.isPaused) {
        resume();
      } else {
        start();
      }
    }
  }

  void goNext() async {
    if (_stageIndex == _stageQue.length - 1) return;
    _stageIndex++;
    _event = TimerControllerEvent.goNext;
    _calcDisplayRatio();
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 100));
    start();
  }

  void skipNext() async {
    if (_isActive) return;
    if (_stageIndex == _stageQue.length - 1) return;

    _timer.reset();
    _timer.pause();
    _remainRatio = 0;
    _event = TimerControllerEvent.skipNext;
    _calcDisplayRatio();
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));

    goNext();
  }

  void skipBack() async {
    _timer.reset();
    _timer.pause();
    _isActive = false;
    _remainRatio = 1;
    _event = TimerControllerEvent.skipBack;
    _calcDisplayRatio();
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 500));

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
      TimerStage.rest,
      TimerStage.work,
      TimerStage.longRest,
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
      goNext();
    } else {
      _remainRatio = _remainTime.inSeconds / _getStageDuration(_stageQue[_stageIndex]).inSeconds;
      _event = TimerControllerEvent.countDown;
      _calcDisplayRatio();
      notifyListeners();
    }
  }

  void _calcDisplayRatio() {
    if (_event == TimerControllerEvent.start) {
      _displayRatio = 1 - ((_remainTime.inSeconds - 1) / _getStageDuration(_stageQue[_stageIndex]).inSeconds);
    } else if (_event == TimerControllerEvent.countDown) {
      _displayRatio = 1 - ((_remainTime.inSeconds - 1) / _getStageDuration(_stageQue[_stageIndex]).inSeconds);
    } else if (_event == TimerControllerEvent.goNext) {
      _displayRatio = 0;
    } else if (_event == TimerControllerEvent.skipNext) {
      _displayRatio = 1;
    } else if (_event == TimerControllerEvent.skipBack) {
      _displayRatio = 0;
    }
  }

  Duration _getStageDuration(TimerStage stage) {
    switch (stage) {
      case TimerStage.work:
        return Duration(seconds: 10);
      case TimerStage.rest:
        return Duration(seconds: 10);
      case TimerStage.longRest:
        return Duration(seconds: 10);
    }
  }
}
