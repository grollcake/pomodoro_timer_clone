import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/constants.dart';

class AnimatedSwitching extends StatefulWidget {
  const AnimatedSwitching({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<AnimatedSwitching> createState() => _AnimatedSwitchingState();
}

class _AnimatedSwitchingState extends State<AnimatedSwitching> with SingleTickerProviderStateMixin {
  Widget? _oldChild;
  bool _isOutgoingAnimation = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final Duration duration = kTransitionDuration;

  void _setupAnimation() {
    if (_isOutgoingAnimation) {
      _fadeAnimation =
          Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(curve: Curves.easeOut, parent: _controller));
      _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, -0.3))
          .animate(CurvedAnimation(curve: Curves.easeOut, parent: _controller));
    } else {
      _fadeAnimation =
          Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(curve: Curves.easeIn, parent: _controller));
      _slideAnimation = Tween<Offset>(begin: Offset(0.0, 0.3), end: Offset.zero)
          .animate(CurvedAnimation(curve: Curves.easeIn, parent: _controller));
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);

    _setupAnimation();

    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          if (_isOutgoingAnimation) {
            setState(() => _isOutgoingAnimation = false);
            _setupAnimation();
            _controller.reset();
            _controller.forward();
          }
        }
      },
    );
  }

  @override
  void didUpdateWidget(AnimatedSwitching oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.child.runtimeType != oldWidget.child.runtimeType || oldWidget.child.key != widget.child.key) {
      _oldChild = oldWidget.child;
      _isOutgoingAnimation = true;
      _setupAnimation();
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_oldChild == null) {
      return widget.child;
    } else {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: _isOutgoingAnimation ? _oldChild : widget.child,
        ),
      );
    }
  }
}
