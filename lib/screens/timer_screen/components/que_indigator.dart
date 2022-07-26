import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:provider/provider.dart';

class QueIndigator extends StatelessWidget {
  const QueIndigator({Key? key, required this.isActive, required this.stageIndex}) : super(key: key);
  final int stageIndex;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final timerController = context.watch<TimerController>();
    return Container(
      width: 46,
      height: 46,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isActive
            ? timerController.stageColorByIdx(stageIndex)
            : timerController.stageColorByIdx(stageIndex).withAlpha(70),
        borderRadius: BorderRadius.circular(10),
        border: isActive
            ? Border.all(
          color: Colors.white,
          width: 1.0,
        )
            : null,
      ),
    );
  }
}
