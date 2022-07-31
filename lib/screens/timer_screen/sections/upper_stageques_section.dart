import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/constants.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';
import 'package:pomodoro_timer_clone/controller/timer_controller.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/settings_screen.dart';
import 'package:pomodoro_timer_clone/screens/timer_screen/components/que_indigator.dart';
import 'package:provider/provider.dart';

class UpperStageQueSection extends StatelessWidget {
  const UpperStageQueSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerController = context.watch<TimerController>();

    // 모든 스테이지가 완료됐다면 아무것도 출력하지 않음
    if (timerController.status == TimerStatus.finished) {
      return SizedBox();
    }

    return Column(
      children: [
        // 스테이지 대기열 표시자 노출
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
                        child: StageQueSecion(
                          status: timerController.status,
                          // Schedule이 변경으로 전체 Que 개수가 바뀐경우 rebuild 하도록 key 값에 que 개수를 전달한다.
                          key: ValueKey<int>(timerController.stageQue.length),
                        ),
                      )
                    : SizedBox(),
              ),
              SizedBox(
                width: 80,
                child: IconButton(
                  icon: Icon(Icons.settings),
                  color: Colors.grey,
                  onPressed: () => Navigator.of(context).push(_createRoute(SettingsScreen())),
                ),
              ),
            ],
          ),
        ),
        // 현재 스테이지에 대한 텍스트 노출
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

  // 오른쪽에서 slide-in으로 나타나는 페이지 전환 효과
  Route _createRoute(Widget targetPage) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => targetPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

class StageQueSecion extends StatefulWidget {
  const StageQueSecion({Key? key, required this.status}) : super(key: key);
  final TimerStatus status;

  @override
  State<StageQueSecion> createState() => _StageQueSecionState();
}

class _StageQueSecionState extends State<StageQueSecion> {
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();
  late TimerController timerController;

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status && widget.status == TimerStatus.skippingNext) {
      _removeFirstQue();
    }
  }

  void _removeFirstQue() {
    _animatedListKey.currentState!.removeItem(
      0,
      (context, animation) {
        return FadeTransition(
          opacity: AlwaysStoppedAnimation(0.0),
          child: SizeTransition(
            sizeFactor: animation,
            axis: Axis.horizontal,
            child: Center(
              child: QueIndigator(stageIndex: timerController.stageIndex, isActive: false),
            ),
          ),
        );
      },
      duration: kTransitionDuration,
    );
  }

  @override
  void initState() {
    super.initState();
    timerController = context.read<TimerController>();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _animatedListKey,
      initialItemCount: timerController.stageQue.length - timerController.stageIndex,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, index, animation) {
        int idx = timerController.stageIndex + index;
        // SkippingNext 이벤트 중에는 첫번째 아이템은 삭제 애니메이션 처리 중이므로 두번째 아이템부터 화면에 그린다.
        if (timerController.status == TimerStatus.skippingNext) idx++;
        if (idx < timerController.stageQue.length) {
          return Center(
            key: UniqueKey(),
            child: QueIndigator(stageIndex: idx, isActive: index == 0),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
