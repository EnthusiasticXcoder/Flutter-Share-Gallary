import 'package:flutter/material.dart';

class BlueCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint pathPaint = Paint();
    pathPaint.shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomLeft,
        colors: [
          Colors.lightBlue,
          Colors.lightBlue.shade300,
          Colors.lightBlue.shade200,
          Colors.blue.shade100
        ]).createShader(Rect.fromPoints(
        const Offset(0, 0), Offset(size.width, size.height * 0.5)));
    pathPaint.color = Colors.lightBlueAccent;
    Path path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width * 0.5, size.height * 0.1),
        radius: size.width * 0.8));
    canvas.drawPath(path, pathPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
