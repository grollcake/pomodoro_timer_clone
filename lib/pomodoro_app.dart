import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/screens/timer_screen/timer_screen.dart';
import 'package:provider/provider.dart';

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PomodoroTimer',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: ChangeNotifierProvider<TimerController>(
        create: (_) => TimerController(),
        child: TimerScreen(),
      ),
    );
  }
}
