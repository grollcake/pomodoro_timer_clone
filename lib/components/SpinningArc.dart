import 'dart:math' as math;

import 'package:flutter/material.dart';

class SpinningArc extends StatefulWidget {
  const SpinningArc({
    Key? key,
    required this.radius,
    this.strokeWidth,
    this.color = Colors.pink,
    this.startDegree = 0,
    this.endDegree = 45,
    this.isSpinning = true,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.linear,
    this.reset = false,
  }) : super(key: key);
  final double radius;
  final double? strokeWidth;
  final Color color;
  final double startDegree;
  final double endDegree;
  final bool isSpinning;
  final Duration duration;
  final Curve curve;
  final bool reset;

  @override
  State<SpinningArc> createState() => _SpinningArcState();
}

class _SpinningArcState extends State<SpinningArc> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: 360).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
    if (widget.isSpinning) _controller.forward();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reset) _controller.reset();
    if (oldWidget.isSpinning != widget.isSpinning) {
      if (widget.isSpinning) {
        _controller.forward();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius * 2,
      height: widget.radius * 2,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: _ArcPainter(
              startDegree: widget.startDegree + _animation.value,
              endDegree: widget.endDegree + _animation.value,
              strokeWidth: widget.strokeWidth ?? widget.radius / 10,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double startDegree;
  final double endDegree;
  final double strokeWidth;
  final Color color;

  _ArcPainter({required this.startDegree, required this.endDegree, required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;

    final arcPaint = Paint()
      ..color = color.withOpacity(.7)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // 시작 각도의 x,y 좌표 구하기
    double startingDegree = convertDegree(startDegree);
    double startingX = math.cos(degreeToRadian(degree: startingDegree)) * radius;
    double startingY = math.sin(degreeToRadian(degree: startingDegree)) * radius;

    // 종료 각도의 x,y 좌표 구하기
    double endingDegree = convertDegree(endDegree);
    double endingX = math.cos(degreeToRadian(degree: endingDegree)) * radius;
    double endingY = math.sin(degreeToRadian(degree: endingDegree)) * radius;

    // 원호 그리기
    // 데카르트식 좌표계(정가운데가 0,0)를 플러터 좌표계(좌상단이 0,0)로 변환
    // x 좌표는 radius만큼 오른쪽으로 쉬프트 처리
    // y 좌표는 반전으로 처리
    final arcPath = Path();
    arcPath.moveTo(startingX + radius, radius - startingY);
    arcPath.arcToPoint(Offset(endingX + radius, radius - endingY), radius: Radius.circular(radius));
    canvas.drawPath(arcPath, arcPaint);

    // 그림자 그리기
    Paint shadowPaint = Paint()
      ..color = color.withOpacity(1.0)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, strokeWidth * 2 / 3);
    canvas.drawPath(arcPath, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  //각도를 라디안으로 변환
  double degreeToRadian({required double degree}) {
    return degree * (math.pi / 180);
  }

  // 각도 변환
  // 입력값: (시계방향 각도) 12시 방향이 0도, 3시 방향이 90도, 6시 방향이 180도
  // 출력값: (반시계방향 각도) 12시 방향이 90도, 3시 방향이 360도, 6시 방향이 270도
  double convertDegree(double degree) => (360 + 90 - degree) % 360;
}
