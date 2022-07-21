import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/components/animated_switching.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/styles/style.dart';
import 'package:provider/provider.dart';

class TimerSection extends StatelessWidget {
  const TimerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerController = context.watch<TimerController>();
    final String min = timerController.remainTime.inMinutes.toString().padLeft(2, '0');
    final String sec =
        (timerController.remainTime.inSeconds - timerController.remainTime.inMinutes * 60).toString().padLeft(2, '0');

    return timerController.status != TimerStatus.finished
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitching(child: Text(min, style: timeText1Style, key: ValueKey<String>(min))),
              Text(sec, style: timeText2Style),
            ],
          )
        : SizedBox();
  }
}
