import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/styles/style.dart';
import 'package:provider/provider.dart';

class TimerSection extends StatelessWidget {
  const TimerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerController = context.watch<TimerController>();

    return timerController.status != TimerStatus.finished
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(timerController.remainTime.inMinutes.toString().padLeft(2, '0'), style: timeText1Style),
              Text(
                  (timerController.remainTime.inSeconds - timerController.remainTime.inMinutes * 60)
                      .toString()
                      .padLeft(2, '0'),
                  style: timeText2Style),
            ],
          )
        : SizedBox();
  }
}
