import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomodoro_timer_clone/constants/constants.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/models/enums.dart';
import 'package:pomodoro_timer_clone/screens/timer_screen/components/animated_switching.dart';
import 'package:provider/provider.dart';

class CenterTimeSection extends StatelessWidget {
  const CenterTimeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerController = context.watch<TimerController>();

    // SkipNext 버튼을 클릭한 경우 전환 애니메이션 동안 시간변경도 동시에 발생하도록 다음 스테이지의 시간으로 변경하여 출력한다.
    // SkipBack 버튼을 클릭한 경우 현재 스테이지의 전체 시간으로 미리 변경하여 전환 애니메이션이 동시 진행되도록 한다.
    Duration displayDurtaion;
    if (timerController.status == TimerStatus.skippingNext &&
        timerController.stageIndex < timerController.stageQue.length) {
      displayDurtaion = timerController.stageDurationById(timerController.stageIndex + 1);
    } else if (timerController.status == TimerStatus.skippingBack) {
      displayDurtaion = timerController.stageDurationById(timerController.stageIndex);
    } else {
      displayDurtaion = timerController.remainTime;
      print(timerController.remainTime);
    }

    String part1 = '';
    String part2 = '';
    if (timerController.displayStyle == DisplayStyle.traditional) {
      part1 = displayDurtaion.inMinutes.toString().padLeft(2, '0');
      part2 = (displayDurtaion.inSeconds - displayDurtaion.inMinutes * 60).toString().padLeft(2, '0');
    } else if (timerController.displayStyle == DisplayStyle.approximate) {
      part1 = displayDurtaion.inMinutes.toString().padLeft(2, '0');
      part2 = 'minutes';
    } else if (timerController.displayStyle == DisplayStyle.percentage) {
      part1 = '11';
      part2 = '%';
    }

    if (timerController.status != TimerStatus.finished) {
      return AnimatedOpacity(
        duration: kTransitionDuration,
        opacity: timerController.status == TimerStatus.playing ? 1.0 : 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitching(child: Text(part1, style: timeText1Style, key: ValueKey<String>(part1))),
            Text(part2, style: timeText2Style),
          ],
        ),
      );
    } else {
      return FinishedScreen();
    }
  }
}

class FinishedScreen extends StatelessWidget {
  const FinishedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/images/enjoy-beach-vacation.json', width: 300),
          SizedBox(height: 50),
          Text(
            'All done\nTake some rest',
            style: timeText1Style.copyWith(fontSize: 30, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
