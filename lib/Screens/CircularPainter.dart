import 'dart:math';

import 'package:flutter/material.dart';

class CircularPainter extends CustomPainter {
  final Color bgColor;
  final Color fillColor;
  final double width;
  final double percent;

  CircularPainter({this.percent, this.width, this.bgColor, this.fillColor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint bgLine = Paint()
      ..color = bgColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Paint fillLine = Paint()
      ..color = fillColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, bgLine);
    double sweepAngle = 2 * pi * percent;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        sweepAngle, false, fillLine);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    //throw UnimplementedError();
    return true;
  }
}
