import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/constants.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:provider/provider.dart';

class BackgroundSection extends StatelessWidget {
  const BackgroundSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerController = context.watch<TimerController>();

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final Color currentColor = timerController.stageColor;
    final Color nextColor = timerController.nextStageColor;

    Duration duration = Duration(seconds: 1);
    Curve curve = Curves.linear;
    if (timerController.status == TimerStatus.ready) {
      duration = Duration.zero;
    } else if (timerController.status == TimerStatus.skippingNext) {
      duration = kTransitionDuration;
      curve = Curves.easeOutCubic;
    } else if (timerController.status == TimerStatus.skippingBack) {
      duration = kTransitionDuration;
      curve = Curves.easeOutCubic;
    }

    return Stack(
      children: [
        // Current Stage Color
        Positioned.fill(
          child: Container(
            width: screenWidth,
            decoration: BoxDecoration(
              color: currentColor,
            ),
          ),
        ),
        // Next Stage Color
        Positioned(
          left: 0,
          top: 0,
          child: AnimatedContainer(
            duration: duration,
            curve: curve,
            width: screenWidth * timerController.displayRatio,
            height: screenHeight,
            decoration: BoxDecoration(
              color: nextColor,
              image: (timerController.stageIndex == timerController.stageQue.length - 1)
                  ? DecorationImage(
                      image: AssetImage('assets/images/finish.png'),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
