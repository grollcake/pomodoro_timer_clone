import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:pausable_timer/pausable_timer.dart';

class SpinningWheel extends StatefulWidget {
  final PausableTimer timer;
  final bool isActive;

  const SpinningWheel({Key? key, required this.timer, required this.isActive}) : super(key: key);

  @override
  State<SpinningWheel> createState() => _SpinningWheelState();
}

class _SpinningWheelState extends State<SpinningWheel> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 1), vsync: this);
    _animation =
        IntTween(begin: -20, end: 340).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      if (widget.isActive) {
        _controller.forward(from: widget.timer.elapsed.inMilliseconds / 1000);
        _controller.addStatusListener((status) {
          if (status == AnimationStatus.completed) _controller.repeat();
        });
      } else {
        _controller.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: widget.isActive ? 1.0 : 0.0,
      child: SizedBox(
        width: 100,
        height: 100,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return Transform.rotate(
              angle: _animation.value * math.pi / 180,
              child: CircularProgressIndicator(
                value: .1,
                color: Colors.blueGrey.withOpacity(.5),
                strokeWidth: 5.0,
              ),
            );
          },
        ),
      ),
    );
  }
}
