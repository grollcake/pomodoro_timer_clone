import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/persistent_setting_controller.dart';
import 'package:pomodoro_timer_clone/controller/setting_controller.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/pomodoro_app.dart';
import 'package:provider/provider.dart';

late final PersistentSettingController persistentSettingController;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  persistentSettingController = PersistentSettingController();
  await persistentSettingController.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TimerController>(create: (context) => TimerController()),
        ChangeNotifierProxyProvider<TimerController, SettingController>(
            create: (context) => SettingController(Provider.of<TimerController>(context, listen: false)),
            update: (context, timerController, oldSettingController) => oldSettingController!),
      ],
      child: PomodoroApp(),
    ),
  );
}
