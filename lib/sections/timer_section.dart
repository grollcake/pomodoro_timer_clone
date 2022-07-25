import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/components/animated_switching.dart';
import 'package:pomodoro_timer_clone/constants/constants.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/styles/style.dart';
import 'package:provider/provider.dart';

class TimerSection extends StatelessWidget {
  const TimerSection({Key? key}) : super(key: key);

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
    final String min = displayDurtaion.inMinutes.toString().padLeft(2, '0');
    final String sec = (displayDurtaion.inSeconds - displayDurtaion.inMinutes * 60).toString().padLeft(2, '0');

    if (timerController.status != TimerStatus.finished) {
      return AnimatedOpacity(
        duration: kTransitionDuration,
        opacity: timerController.status == TimerStatus.playing ? 1.0 : 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitching(child: Text(min, style: timeText1Style, key: ValueKey<String>(min))),
            Text(sec, style: timeText2Style),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
