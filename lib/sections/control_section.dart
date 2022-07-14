import 'package:flutter/material.dart';
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
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SkipButton(
                    icon: Icons.skip_previous_outlined,
                    position: 'L',
                    onPressed: () => timerController.skipBack(),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SkipButton(
                    icon: Icons.skip_next_outlined,
                    position: 'R',
                    onPressed: () => timerController.skipNext(),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: PlayButton(
                    icon: timerController.isActive ? Icons.pause : Icons.play_arrow_rounded,
                    onPressed: () => timerController.toggle(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
