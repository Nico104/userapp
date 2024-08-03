import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/general/utils_color/hex_color.dart';

Color bgcolor = HexColor("#bfdcfe");
Color fgcolor = Colors.white;
Color bordercolor = Colors.black;

class FancyAuthBackground extends StatelessWidget {
  const FancyAuthBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: tellMeTheRightHeigt(10.h, 80),
                child: Text(
                  "Logo + Name",
                  style: TextStyle(fontSize: 32),
                ),
              ),
              SizedBox(
                height: tellMeTheRightHeigt(5.h, 80),
              ),
            ],
          ),
          SizedBox(
            // - 15 for the Already Registered? Button
            height: tellMeTheRightHeigt(85.h - 15, 480),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Align(
                      // alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 100.w / 2),
                        color: fgcolor,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    CustomPaint(
                      size: Size(100, 100),
                      // painter: TrianglePainter(color: fgcolor),
                      painter: MyPainter(),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(28, 100.w / 2 - 30, 28, 28),
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

double tellMeTheRightHeigt(double wantedValue, double minimumValue) {
  if (wantedValue > minimumValue) {
    return wantedValue;
  } else {
    return minimumValue;
  }
}

class TrianglePainter extends CustomPainter {
  final double angleDegrees = 90;
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double angleRadians = angleDegrees * pi / 180;
    double height = (size.width / 2) * tan(angleRadians / 2);

    var path = Path();
    path.moveTo(0, height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xffffffff).withOpacity(0);
    path = Path();
    path.lineTo(size.width, size.height * 0.19);
    path.cubicTo(size.width, size.height * 0.19, size.width, size.height * 1.19,
        size.width, size.height * 1.19);
    path.cubicTo(size.width, size.height * 1.19, size.width, size.height * 1.18,
        size.width, size.height * 1.18);
    path.cubicTo(size.width, size.height * 1.18, size.width * 0.53,
        size.height * 0.73, size.width * 0.53, size.height * 0.73);
    path.cubicTo(size.width * 0.52, size.height * 0.71, size.width * 0.49,
        size.height * 0.71, size.width * 0.48, size.height * 0.73);
    path.cubicTo(size.width * 0.48, size.height * 0.73, size.width * 0.01,
        size.height * 1.18, size.width * 0.01, size.height * 1.18);
    path.cubicTo(size.width * 0.01, size.height * 1.18, size.width * 0.01,
        size.height * 1.19, 0, size.height * 1.19);
    path.cubicTo(
        0, size.height * 1.19, 0, size.height * 0.19, 0, size.height * 0.19);
    path.cubicTo(0, size.height * 0.19, size.width, size.height * 0.19,
        size.width, size.height * 0.19);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
