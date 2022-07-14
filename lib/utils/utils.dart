import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/models/data.dart';

Color getColor(TimerStage stage) {
  switch (stage) {
    case TimerStage.work:
      return Color(0xFFFF6B6B);
    case TimerStage.rest:
      return Color(0xFFF4A261);
    case TimerStage.longRest:
      return Color(0xFF2EC4B6);
  }
}

String getStageName(TimerStage stage) {
  switch (stage) {
    case TimerStage.work:
      return 'Work';
    case TimerStage.rest:
      return 'Break';
    case TimerStage.longRest:
      return 'Long Break';
  }
}
