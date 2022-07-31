import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pomodoro_timer_clone/constants/constants.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsAboutPage extends StatefulWidget {
  const SettingsAboutPage({Key? key}) : super(key: key);

  @override
  State<SettingsAboutPage> createState() => _SettingsAboutPageState();
}

class _SettingsAboutPageState extends State<SettingsAboutPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Lottie.asset('assets/images/lottie-space.json'),
          ),
          SizedBox(height: 30),
          Text('ERA, 2022', style: settingTitleTextStyle),
          SizedBox(height: 8),
          Text('grollcake@gmail.com', style: menuTextStyle),
          SizedBox(height: 24),
          ElevatedButton.icon(
            icon: Icon(FontAwesomeIcons.github, color: Colors.black, size: 16),
            onPressed: () async {
              if (!await launchUrl(
                Uri.parse(kGithubUrl),
                mode: LaunchMode.platformDefault,
              )) throw 'Could not launch $kGithubUrl';
            },
            label: Text('Source code', style: menuTextStyle),
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              minimumSize: Size(160, 40),
              elevation: 0.0,
            ),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('A clone-coding of ', style: menuTextStyle.copyWith(color: Colors.grey)),
              GestureDetector(
                onTap: () async {
                  if (!await launchUrl(
                    Uri.parse('https://another-pomodoro.app/timer/'),
                    mode: LaunchMode.platformDefault,
                  )) throw 'Could not launch https://another-pomodoro.app/timer/';
                },
                child: Text('AnotherPomodoro', style: menuTextStyle.copyWith(color: Colors.blueAccent.withOpacity(.8))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
