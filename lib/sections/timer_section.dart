import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:provider/provider.dart';

class TimerSection extends StatelessWidget {
  const TimerSection({
    Key? key,
    required this.timeText1Style,
    required this.timeText2Style,
  }) : super(key: key);

  final TextStyle timeText1Style;
  final TextStyle timeText2Style;

  @override
  Widget build(BuildContext context) {
    final timerController = context.watch<TimerController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(timerController.remainTime.inMinutes.toString().padLeft(2, '0'), style: timeText1Style),
        Text(
            (timerController.remainTime.inSeconds - timerController.remainTime.inMinutes * 60)
                .toString()
                .padLeft(2, '0'),
            style: timeText2Style),
      ],
    );
  }
}
