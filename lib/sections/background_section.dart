import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_timer_clone/utils/utils.dart';

class BackgroundSection extends StatelessWidget {
  const BackgroundSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerController = context.watch<TimerController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final Color currentColor = getColor(timerController.stageQue[timerController.stageIndex]);
    final Color nextColor = (timerController.stageIndex == timerController.stageQue.length - 1)
        ? Color(0xFF263238)
        : getColor(timerController.stageQue[timerController.stageIndex + 1]);

    return Row(
      children: [
        AnimatedContainer(
          duration: Duration(seconds: 1),
          width: screenWidth * (1 - timerController.remainRatio),
          color: nextColor,
        ),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          width: screenWidth * timerController.remainRatio,
          color: currentColor,
        ),
      ],
    );
  }
}
