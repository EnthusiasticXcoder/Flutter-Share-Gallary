import 'package:flutter/material.dart';

class GradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint pathPaint = Paint();
    Paint white = Paint();
    white.color = Colors.white;
    pathPaint.shader = LinearGradient(colors: [
      Colors.lightBlue.shade100,
      Colors.lightBlue.shade200,
      Colors.lightBlue.shade300,
      Colors.lightBlue.shade400,
      Colors.lightBlue.shade400,
      Colors.lightBlue.shade300,
      Colors.lightBlue.shade200,
      Colors.lightBlue.shade100,
    ]).createShader(Rect.fromPoints(
        const Offset(0, 0), Offset(size.width, size.height * 0.5)));
    pathPaint.color = Colors.lightBlueAccent;
    Path path = Path();
    path.addRect(Rect.fromPoints(
        const Offset(0, 0), Offset(size.width, size.height * 0.5)));

    canvas.drawPath(path, pathPaint);

    path = Path();
    path.addRect(Rect.fromPoints(
        Offset(0, size.height * 0.5), Offset(size.width, size.height)));
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
