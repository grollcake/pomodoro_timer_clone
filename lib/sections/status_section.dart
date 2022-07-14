import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_timer_clone/utils/utils.dart';

class StatusSection extends StatelessWidget {
  const StatusSection({
    Key? key,
    required this.statTextStyle,
  }) : super(key: key);

  final TextStyle statTextStyle;

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
                child: Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: timerController.stageQue.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Container(
                          width: 46,
                          height: 46,
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: timerController.stageIndex == index
                                ? getColor(timerController.stageQue[index])
                                : getColor(timerController.stageQue[index]).withAlpha(70),
                            borderRadius: BorderRadius.circular(10),
                            border: timerController.stageIndex == index
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
                ),
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
            child: Text(getStageName(timerController.stageQue[timerController.stageIndex]), style: statTextStyle),
          ),
        )
      ],
    );
  }
}
