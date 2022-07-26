import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/constants.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/screens/timer_screen/components/SpinningArc.dart';
import 'package:pomodoro_timer_clone/screens/timer_screen/components/play_button.dart';
import 'package:pomodoro_timer_clone/screens/timer_screen/components/skip_button.dart';
import 'package:provider/provider.dart';

class LowerControlButtonSection extends StatefulWidget {
  const LowerControlButtonSection({Key? key}) : super(key: key);

  @override
  State<LowerControlButtonSection> createState() => _LowerControlButtonSectionState();
}

class _LowerControlButtonSectionState extends State<LowerControlButtonSection> {
  late TimerController timerController;

  @override
  Widget build(BuildContext context) {
    timerController = context.watch<TimerController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 200,
          height: 100,
          margin: EdgeInsets.only(bottom: 40),
          child: Stack(
            children: [
              /// 뒤로 감기 버튼
              if (timerController.status != TimerStatus.finished) buildSkipBackButton(),

              /// 앞으로 건너뛰기 버튼
              if (timerController.status != TimerStatus.finished) buildSkipNextButton(),

              /// 플레이/일시정지 버튼
              buildPlayButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSkipNextButton() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.centerRight,
        child: SubButton(
          icon: 'assets/icons/icon-tabler-player-skip-forward.svg',
          position: 'R',
          onPressed: (timerController.status == TimerStatus.playing ||
                  timerController.stageIndex == timerController.stageQue.length - 1)
              ? null
              : () => timerController.skipNext(),
        ),
      ),
    );
  }

  Widget buildSkipBackButton() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.centerLeft,
        child: SubButton(
          icon: 'assets/icons/icon-tabler-player-skip-back.svg',
          position: 'L',
          onPressed: () => timerController.skipBack(),
        ),
      ),
    );
  }

  Widget buildPlayButton() {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            buildCircleShadow(), // 원형 쉐도우 (진행 중일 때만 나타남)
            buildSpinningArc(), // 시간 흐름을 표현하는 애니메이션 (진행 중일 때만 나타남)
            PlayButton(
              icon: timerController.status == TimerStatus.finished
                  ? 'assets/icons/reload-svgrepo-com.svg'
                  : timerController.status == TimerStatus.playing
                      ? 'assets/icons/icon-tabler-player-pause.svg'
                      : 'assets/icons/icon-tabler-player-play.svg',
              onPressed: () => timerController.circleButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSpinningArc() {
    return AnimatedOpacity(
      duration: kTransitionDuration,
      opacity: timerController.status == TimerStatus.playing ? 1 : 0,
      child: SpinningArc(
        radius: 50,
        strokeWidth: 5,
        startDegree: 350,
        endDegree: 20,
        color: timerController.nextStageColor,
        isSpinning: timerController.status == TimerStatus.playing,
        curve: Curves.easeOut,
        reset: [TimerStatus.skippingNext, TimerStatus.skippingBack, TimerStatus.finished, TimerStatus.ready]
            .contains(timerController.status),
      ),
    );
  }

  Widget buildCircleShadow() {
    return AnimatedOpacity(
      duration: kTransitionDuration,
      opacity: timerController.status == TimerStatus.playing ? 1 : 0,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: timerController.stageColor,
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
      ),
    );
  }
}
