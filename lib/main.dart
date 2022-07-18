import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/homescreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(PomodoroApp());


class PomodoroApp extends StatelessWidget {
  const PomodoroApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PomodoroTimer',
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<TimerController>(
        create: (_) => TimerController(),
        child: HomeScreen(),
      ),
    );
  }
}
