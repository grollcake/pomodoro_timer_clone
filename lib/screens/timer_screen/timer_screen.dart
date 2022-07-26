import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/screens/timer_screen/sections/background_section.dart';
import 'package:pomodoro_timer_clone/screens/timer_screen/sections/center_time_section.dart';
import 'package:pomodoro_timer_clone/screens/timer_screen/sections/lower_control_button_section.dart';
import 'package:pomodoro_timer_clone/screens/timer_screen/sections/upper_stageques_ection.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              /////////////////////////////////////////
              // 배경 화면 (시간 진행 상태 노출)
              BackgroundSection(),
              /////////////////////////////////////////
              // 상단 상태
              UpperStageQueSection(),
              /////////////////////////////////////////
              // 경과 시간
              CenterTimeSection(),
              /////////////////////////////////////////
              // 하단 제어 버튼들
              LowerControlButtonSection()
            ],
          ),
        ),
      ),
    );
  }
}
