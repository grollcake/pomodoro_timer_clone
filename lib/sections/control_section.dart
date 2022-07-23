import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/components/SpinningArc.dart';
import 'package:pomodoro_timer_clone/components/spinning_wheel.dart';
import 'package:pomodoro_timer_clone/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_timer_clone/components/play_button.dart';
import 'package:pomodoro_timer_clone/components/skip_button.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';

class ControlSection extends StatelessWidget {
  const ControlSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerController = context.watch<TimerController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 200,
          height: 120,
          margin: EdgeInsets.only(bottom: 20),
          child: Stack(
            children: [
              /// 뒤로 감기 버튼
              if (timerController.status != TimerStatus.finished)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SubButton(
                      icon: Icons.skip_previous_outlined,
                      position: 'L',
                      onPressed: () => timerController.skipBack(),
                    ),
                  ),
                ),
              /// 앞으로 건너뛰기 버튼
              if (timerController.status != TimerStatus.finished)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SubButton(
                      icon: Icons.skip_next_outlined,
                      position: 'R',
                      onPressed: (timerController.status == TimerStatus.playing ||
                              timerController.stageIndex == timerController.stageQue.length - 1)
                          ? null
                          : () => timerController.skipNext(),
                    ),
                  ),
                ),
              /// 원형 쉐도우 (진행 중일 때만 나타남)
              if (timerController.status == TimerStatus.playing)
              Positioned.fill(
                child: Center(
                  child: buildCircleShadow(getColor(timerController.stageQue[timerController.stageIndex])),
                ),
              ),
              // 초 경과 애니메이션 (진행 중일 때만 나타남)
              if (timerController.status == TimerStatus.playing)
              Positioned.fill(
                child: Center(
                  // child: SpinningWheel(timer: timerController.timer, isActive: timerController.status == TimerStatus.playing),
                  child: SpinningArc(
                    radius: 50,
                    startDegree: 350,
                    endDegree: 20,
                    color: getColor(timerController.stageQue[timerController.stageIndex + 1]),
                    isSpinning: timerController.status == TimerStatus.playing,
                    curve: Curves.easeOut,
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: PlayButton(
                    icon: timerController.status == TimerStatus.finished
                        ? Icons.replay_rounded
                        : timerController.status == TimerStatus.playing
                            ? Icons.pause
                            : Icons.play_arrow_rounded,
                    onPressed: () => timerController.circleButton(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildCircleShadow(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
    );
  }
}
