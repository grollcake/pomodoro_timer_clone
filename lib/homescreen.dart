import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro_timer_clone/sections/background_section.dart';
import 'package:pomodoro_timer_clone/sections/control_section.dart';
import 'package:pomodoro_timer_clone/sections/status_section.dart';
import 'package:pomodoro_timer_clone/sections/timer_section.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final timeText1Style =
      GoogleFonts.poppins(fontSize: 144, fontWeight: FontWeight.w700, height: 0.9, color: Color(0xFF4D2020));
  final timeText2Style =
      GoogleFonts.poppins(fontSize: 144, fontWeight: FontWeight.w300, height: 0.9, color: Color(0xFF4D2020));
  final statTextStyle = GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white);

  int currentStage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              /////////////////////////////////////////
              // 배경 화면
              BackgroundSection(),
              /////////////////////////////////////////
              // 상단 상태
              StatusSection(statTextStyle: statTextStyle),
              /////////////////////////////////////////
              // 경과 시간
              TimerSection(timeText1Style: timeText1Style, timeText2Style: timeText2Style),
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
