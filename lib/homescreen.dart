import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro_timer_clone/sections/background_section.dart';
import 'package:pomodoro_timer_clone/sections/control_section.dart';
import 'package:pomodoro_timer_clone/sections/status_section.dart';
import 'package:pomodoro_timer_clone/sections/timer_section.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  int currentStage = 0;

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
              StatusSection(),
              /////////////////////////////////////////
              // 경과 시간
              TimerSection(),
              /////////////////////////////////////////
              // 하단 제어 버튼들
              ControlSection()
            ],
          ),
        ),
      ),
    );
  }
}
