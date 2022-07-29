import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomodoro_timer_clone/constants/constants.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';
import 'package:pomodoro_timer_clone/controller/setting_controller.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/models/enums.dart';
import 'package:pomodoro_timer_clone/screens/timer_screen/components/animated_switching.dart';
import 'package:provider/provider.dart';

class CenterTimeSection extends StatelessWidget {
  const CenterTimeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerController = context.watch<TimerController>();
    final settingController = context.watch<SettingController>();
    late Widget timeDisplay;

    if (timerController.status != TimerStatus.finished) {
      // SkipNext 버튼을 클릭한 경우 전환 애니메이션 동안 시간변경도 동시에 발생하도록 다음 스테이지의 시간으로 변경하여 출력한다.
      // SkipBack 버튼을 클릭한 경우 현재 스테이지의 전체 시간으로 미리 변경하여 전환 애니메이션이 동시 진행되도록 한다.
      Duration displayDurtaion;
      double percentage;
      if (timerController.status == TimerStatus.skippingNext &&
          timerController.stageIndex < timerController.stageQue.length) {
        displayDurtaion = timerController.stageDurationById(timerController.stageIndex + 1);
        percentage = 0;
      } else if (timerController.status == TimerStatus.skippingBack) {
        displayDurtaion = timerController.stageDurationById(timerController.stageIndex);
        percentage = 0;
      } else {
        displayDurtaion = timerController.remainTime;
        percentage = 1 -
            (timerController.remainTime.inSeconds /
                timerController.stageDurationById(timerController.stageIndex).inSeconds);
      }

      switch (settingController.displayStyle) {
        case DisplayStyle.traditional:
          timeDisplay = _buildTraditionalDisplay(displayDurtaion);
          break;
        case DisplayStyle.approximate:
          timeDisplay = _buildApproximateDisplay(displayDurtaion);
          break;
        case DisplayStyle.percentage:
          timeDisplay = _buildPercentageDisplay(percentage);
          break;
      }

      return AnimatedOpacity(
        duration: kTransitionDuration,
        opacity: timerController.status == TimerStatus.playing ? 1.0 : 0.7,
        child: timeDisplay,
      );
    } else {
      return _buildFinishedScreen();
    }
  }

  _buildTraditionalDisplay(Duration duration) {
    final String min = duration.inMinutes.toString().padLeft(2, '0');
    final String sec = (duration.inSeconds - duration.inMinutes * 60).toString().padLeft(2, '0');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(min, style: timeMin1Style),
        Text(sec, style: timeSec1Style),
      ],
    );
  }

  _buildApproximateDisplay(Duration duration) {
    String min = duration.inMinutes.toString();
    // 초가 0이 아니면 1분 올림하여 출력
    if (duration.inSeconds % 60 != 0) {
      min = (duration.inMinutes + 1).toString();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitching(
          child: Text(
            min,
            style: timeDisplay2Style,
            key: ValueKey<String>(min),
          ),
        ),
        Text('minutes', style: timeDisplay3Style),
      ],
    );
  }

  _buildPercentageDisplay(double percentage) {
    String displayPercent = (percentage * 100).toString().split('.')[0];
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitching(
          child: Text(
            displayPercent,
            style: timeDisplay2Style,
            key: ValueKey<String>(displayPercent),
          ),
        ),
        SizedBox(width: 10),
        Text('%', style: timeDisplay4Style),
      ],
    );
  }

  _buildFinishedScreen() {
    return FadeInUp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/images/enjoy-beach-vacation.json', width: 300),
          SizedBox(height: 50),
          Text(
            'All done\nTake some rest',
            style: timeMin1Style.copyWith(fontSize: 30, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
