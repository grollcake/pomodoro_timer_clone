import 'package:pomodoro_timer_clone/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistentSettingController {
  late SharedPreferences pref;

  initialize() async {
    pref = await SharedPreferences.getInstance();
  }

  set totalCountOfSets(int interval) => pref.setInt('totalCountOfSets', interval);
  int get totalCountOfSets => pref.getInt('totalCountOfSets') ?? kDefaultTotalCountOfSets;

  set longBreakInterval(int interval) => pref.setInt('longBreakInterval', interval);
  int get longBreakInterval => pref.getInt('longBreakInterval') ?? kDefaultLongBreakInterval;

  set workDuration(Duration duration) => pref.setInt('workDuration', duration.inSeconds);
  Duration get workDuration => Duration(seconds: pref.getInt('workDuration') ?? 0);

  set restDuration(Duration duration) => pref.setInt('restDuration', duration.inSeconds);
  Duration get restDuration => Duration(seconds: pref.getInt('restDuration') ?? 0);

  set longRestDuration(Duration duration) => pref.setInt('longRestDuration', duration.inSeconds);
  Duration get longRestDuration => Duration(seconds: pref.getInt('longRestDuration') ?? 0);

  set displayStyle(int styleNo) => pref.setInt('displayStyle', styleNo);
  int get displayStyle => pref.getInt('displayStyle') ?? 0;
}
