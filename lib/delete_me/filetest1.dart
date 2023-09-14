import 'package:flutter/material.dart';

class ShapeTest1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Colors.green;
    path = Path();
    path.lineTo(size.width, size.height * 2.09);
    path.cubicTo(size.width, size.height * 2.09, 0, size.height * 2.09, 0,
        size.height * 2.09);
    path.cubicTo(
        0, size.height * 2.09, 0, size.height * 1.3, 0, size.height * 1.3);
    path.cubicTo(0, size.height * 1.25, size.width * 0.08, size.height * 1.11,
        size.width * 0.19, size.height * 1.1);
    path.cubicTo(size.width * 0.28, size.height * 1.09, size.width * 0.38,
        size.height * 1.09, size.width * 0.49, size.height * 1.09);
    path.cubicTo(size.width * 0.58, size.height * 1.09, size.width * 0.71,
        size.height * 1.09, size.width * 0.81, size.height * 1.1);
    path.cubicTo(size.width * 0.92, size.height * 1.11, size.width,
        size.height * 1.25, size.width, size.height * 1.3);
    path.cubicTo(size.width, size.height * 1.3, size.width, size.height * 2.09,
        size.width, size.height * 2.09);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
  // @override
  // void paint(Canvas canvas, Size size) {
  //   Paint paint = Paint();
  //   Path path = Path();

  //   // Path number 1

  //   paint.color = Color(0xFFFF5252);
  //   path = Path();
  //   path.lineTo(0, size.height);
  //   path.cubicTo(size.width * 0.09, size.height * 0.93, size.width * 0.11,
  //       size.height * 0.78, size.width * 0.11, size.height * 0.66);
  //   path.cubicTo(size.width * 0.11, size.height * 0.49, size.width * 0.16,
  //       size.height * 0.37, size.width / 4, size.height * 0.28);
  //   path.cubicTo(size.width * 0.36, size.height * 0.23, size.width * 0.54,
  //       size.height * 0.18, size.width * 0.68, size.height * 0.16);
  //   path.cubicTo(size.width * 0.81, size.height * 0.13, size.width * 0.89,
  //       size.height * 0.07, size.width * 0.98, 0);
  //   path.cubicTo(
  //       size.width * 0.94, 0, size.width * 0.86, 0, size.width * 0.84, 0);
  //   path.cubicTo(size.width * 0.56, 0, size.width * 0.28, 0, 0, 0);
  //   path.cubicTo(0, 0, 0, size.height, 0, size.height);
  //   canvas.drawPath(path, paint);
  // }

  // @override
  // bool shouldRepaint(CustomPainter oldDelegate) {
  //   return true;
  // }
}
