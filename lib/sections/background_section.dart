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
    final double screenHeight = MediaQuery.of(context).size.height;
    final Color currentColor = getColor(timerController.stageQue[timerController.stageIndex]);
    final Color nextColor = (timerController.stageIndex == timerController.stageQue.length - 1)
        ? Color(0xFF263238)
        : getColor(timerController.stageQue[timerController.stageIndex + 1]);

    Duration duration = Duration(seconds: 1);
    Curve curve = Curves.linear;
    if (timerController.remainRatio == 1 &&
        [TimerControllerEvent.ready, TimerControllerEvent.skipNext].contains(timerController.event)) {
      duration = Duration.zero;
      curve = Curves.easeOutCubic;
    } else if (timerController.event == TimerControllerEvent.skipBack) {
      duration = Duration(milliseconds: 500);
      curve = Curves.easeOutCubic;
    }

      return Stack(
        children: [
          // Current Stage Color
          Positioned.fill(
            child: Container(
              width: screenWidth * timerController.remainRatio,
              color: currentColor,
            ),
          ),
          // Next Stage Color
          Positioned(
            left: 0,
            top: 0,
            child: AnimatedContainer(
              duration: duration,
              curve: curve,
              width: screenWidth * (1 - timerController.remainRatio),
              height: screenHeight,
              color: nextColor,
            ),
          ),
        ],
      );
  }
}
