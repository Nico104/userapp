import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = getShapePath(size);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Path getShapePath(Size size) {
  Path path_0 = Path();
  path_0.moveTo(size.width * 0.9974190, size.height * 0.4354715);
  path_0.lineTo(size.width * 0.7180671, size.height * 0.2108330);
  path_0.lineTo(size.width * 0.7161227, size.height * 0.1426864);
  path_0.arcToPoint(Offset(size.width * 0.6793981, size.height * 0.07551261),
      radius:
          Radius.elliptical(size.width * 0.1891551, size.height * 0.1514236),
      rotation: 0,
      largeArc: false,
      clockwise: false);
  path_0.arcToPoint(Offset(size.width * 0.6284722, size.height * 0.03213224),
      radius:
          Radius.elliptical(size.width * 0.1640741, size.height * 0.1313456),
      rotation: 0,
      largeArc: false,
      clockwise: false);
  path_0.arcToPoint(Offset(size.width * 0.5522454, size.height * 0.003215077),
      radius:
          Radius.elliptical(size.width * 0.1861343, size.height * 0.1490054),
      rotation: 0,
      largeArc: false,
      clockwise: false);
  path_0.arcToPoint(Offset(size.width * 0.5071065, size.height * 0.0001111842),
      radius:
          Radius.elliptical(size.width * 0.1812847, size.height * 0.1451232),
      rotation: 0,
      largeArc: false,
      clockwise: false);
  path_0.arcToPoint(Offset(size.width * 0.3729051, size.height * 0.03471727),
      radius:
          Radius.elliptical(size.width * 0.2423495, size.height * 0.1940072),
      rotation: 0,
      largeArc: false,
      clockwise: false);
  path_0.arcToPoint(Offset(size.width * 0.3270949, size.height * 0.07504934),
      radius:
          Radius.elliptical(size.width * 0.1958333, size.height * 0.1567697),
      rotation: 0,
      largeArc: false,
      clockwise: false);
  path_0.arcToPoint(Offset(size.width * 0.2916667, size.height * 0.1467817),
      radius:
          Radius.elliptical(size.width * 0.1641435, size.height * 0.1314012),
      rotation: 0,
      largeArc: false,
      clockwise: false);
  path_0.quadraticBezierTo(size.width * 0.2900694, size.height * 0.1757174,
      size.width * 0.2884491, size.height * 0.2046345);
  path_0.lineTo(0, size.height * 0.4354715);
  path_0.lineTo(0, size.height * 0.7691353);
  path_0.lineTo(size.width * 0.2896644, size.height);
  path_0.lineTo(size.width * 0.7103125, size.height);
  path_0.lineTo(size.width, size.height * 0.7644841);
  path_0.close();
  path_0.moveTo(size.width * 0.6316088, size.height * 0.1994737);
  path_0.lineTo(size.width * 0.3767708, size.height * 0.1994737);
  path_0.lineTo(size.width * 0.3767708, size.height * 0.1504137);
  path_0.arcToPoint(Offset(size.width * 0.4006481, size.height * 0.09875937),
      radius:
          Radius.elliptical(size.width * 0.1298032, size.height * 0.1039109),
      rotation: 0,
      largeArc: false,
      clockwise: true);
  path_0.arcToPoint(Offset(size.width * 0.6019444, size.height * 0.09358004),
      radius:
          Radius.elliptical(size.width * 0.1242824, size.height * 0.09949133),
      rotation: 0,
      largeArc: false,
      clockwise: true);
  path_0.arcToPoint(Offset(size.width * 0.6316088, size.height * 0.1498670),
      radius:
          Radius.elliptical(size.width * 0.1292361, size.height * 0.1034569),
      rotation: 0,
      largeArc: false,
      clockwise: true);
  path_0.close();

  return path_0;
}

class RPSCustomPainter extends CustomPainter {
  final Color color;

  RPSCustomPainter(
    this.color,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9974190, size.height * 0.4354715);
    path_0.lineTo(size.width * 0.7180671, size.height * 0.2108330);
    path_0.lineTo(size.width * 0.7161227, size.height * 0.1426864);
    path_0.arcToPoint(Offset(size.width * 0.6793981, size.height * 0.07551261),
        radius:
            Radius.elliptical(size.width * 0.1891551, size.height * 0.1514236),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.arcToPoint(Offset(size.width * 0.6284722, size.height * 0.03213224),
        radius:
            Radius.elliptical(size.width * 0.1640741, size.height * 0.1313456),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.arcToPoint(Offset(size.width * 0.5522454, size.height * 0.003215077),
        radius:
            Radius.elliptical(size.width * 0.1861343, size.height * 0.1490054),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.arcToPoint(
        Offset(size.width * 0.5071065, size.height * 0.0001111842),
        radius:
            Radius.elliptical(size.width * 0.1812847, size.height * 0.1451232),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.arcToPoint(Offset(size.width * 0.3729051, size.height * 0.03471727),
        radius:
            Radius.elliptical(size.width * 0.2423495, size.height * 0.1940072),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.arcToPoint(Offset(size.width * 0.3270949, size.height * 0.07504934),
        radius:
            Radius.elliptical(size.width * 0.1958333, size.height * 0.1567697),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.arcToPoint(Offset(size.width * 0.2916667, size.height * 0.1467817),
        radius:
            Radius.elliptical(size.width * 0.1641435, size.height * 0.1314012),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.quadraticBezierTo(size.width * 0.2900694, size.height * 0.1757174,
        size.width * 0.2884491, size.height * 0.2046345);
    path_0.lineTo(0, size.height * 0.4354715);
    path_0.lineTo(0, size.height * 0.7691353);
    path_0.lineTo(size.width * 0.2896644, size.height);
    path_0.lineTo(size.width * 0.7103125, size.height);
    path_0.lineTo(size.width, size.height * 0.7644841);
    path_0.close();
    path_0.moveTo(size.width * 0.6316088, size.height * 0.1994737);
    path_0.lineTo(size.width * 0.3767708, size.height * 0.1994737);
    path_0.lineTo(size.width * 0.3767708, size.height * 0.1504137);
    path_0.arcToPoint(Offset(size.width * 0.4006481, size.height * 0.09875937),
        radius:
            Radius.elliptical(size.width * 0.1298032, size.height * 0.1039109),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.arcToPoint(Offset(size.width * 0.6019444, size.height * 0.09358004),
        radius:
            Radius.elliptical(size.width * 0.1242824, size.height * 0.09949133),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.arcToPoint(Offset(size.width * 0.6316088, size.height * 0.1498670),
        radius:
            Radius.elliptical(size.width * 0.1292361, size.height * 0.1034569),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color;
    // canvas.drawShadow(path_0, Colors.grey, 2, false);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
