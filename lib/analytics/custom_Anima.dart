import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedCircularProgress extends StatelessWidget {
  final double percentage;
  final Color color;
  final Animation<double> animation;

  const AnimatedCircularProgress({
    super.key,
    required this.percentage,
    required this.color,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: CircularPainter(
            progress: percentage * animation.value,
            color: color,
          ),
          child: child,
        );
      },
    );
  }
}

class CircularPainter extends CustomPainter {
  double progress;
  Color color;

  CircularPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = Paint()
      ..color = Colors.grey
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, complete);

    double angle = 2 * pi * (progress / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, progressPaint);
    TextSpan span = TextSpan(
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        text: '${progress.round()}%');

    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));
    tp.paint(canvas, textCenter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
