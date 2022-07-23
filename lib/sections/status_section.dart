import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/styles/style.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_timer_clone/utils/utils.dart';

class StatusSection extends StatelessWidget {
  const StatusSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerController = context.watch<TimerController>();

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          color: Color(0xFF1F2937),
          child: Row(
            children: [
              Expanded(
                child: timerController.status != TimerStatus.finished
                    ? Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: timerController.stageQue.length - timerController.stageIndex,
                          itemBuilder: (BuildContext context, int index) {
                            int idx = timerController.stageIndex + index;
                            return Center(
                              child: Container(
                                width: 46,
                                height: 46,
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: index == 0
                                      ? timerController.stageColor
                                      : timerController.stageColorByIdx(idx).withAlpha(70),
                                  borderRadius: BorderRadius.circular(10),
                                  border: index == 0
                                      ? Border.all(
                                          color: Colors.white,
                                          width: 1.0,
                                        )
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(),
              ),
              SizedBox(
                width: 80,
                child: IconButton(
                  icon: Icon(Icons.settings),
                  color: Colors.grey,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 36,
          color: Color(0xFF374151),
          child: Center(
            child: Text(timerController.stageName, style: statTextStyle),
          ),
        )
      ],
    );
  }
}
