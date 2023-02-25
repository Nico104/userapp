import 'package:flutter/material.dart';

class CustomPath extends StatefulWidget {
  @override
  _CustomPathState createState() => _CustomPathState();
}

class _CustomPathState extends State<CustomPath> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BezierClipper(),
      child: Container(
        alignment: Alignment.center,
        color: Colors.black,
        width: 300,
        height: 800,
      ),
    );
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 1125;
    final double yScaling = size.height / 2436;
    path.lineTo(217.27 * xScaling, 386 * yScaling);
    path.cubicTo(
      217.27 * xScaling,
      386 * yScaling,
      897.58 * xScaling,
      386 * yScaling,
      897.58 * xScaling,
      386 * yScaling,
    );
    path.cubicTo(
      940.5724437190407 * xScaling,
      385.9180206140798 * yScaling,
      981.6614878476902 * xScaling,
      403.7237587000392 * yScaling,
      1011 * xScaling,
      435.15 * yScaling,
    );
    path.cubicTo(
      1025.3597034183613 * xScaling,
      450.4889384397208 * yScaling,
      1036.5713399585154 * xScaling,
      468.4955062464358 * yScaling,
      1044 * xScaling,
      488.15 * yScaling,
    );
    path.cubicTo(
      1051.7620526008584 * xScaling,
      508.6797531814334 * yScaling,
      1055.378386486216 * xScaling,
      530.5442982408576 * yScaling,
      1054.64 * xScaling,
      552.48 * yScaling,
    );
    path.cubicTo(
      1054.64 * xScaling,
      552.48 * yScaling,
      1017.0600000000001 * xScaling,
      1744.68 * yScaling,
      1017.0600000000001 * xScaling,
      1744.68 * yScaling,
    );
    path.cubicTo(
      1016.4700470268959 * xScaling,
      1763.3017534784312 * yScaling,
      1011.9692554355364 * xScaling,
      1781.5911169634217 * yScaling,
      1003.85 * xScaling,
      1798.3600000000001 * yScaling,
    );
    path.cubicTo(
      995.8490258946432 * xScaling,
      1814.8232627485206 * yScaling,
      984.7616853435657 * xScaling,
      1829.5973307503355 * yScaling,
      971.19 * xScaling,
      1841.88 * yScaling,
    );
    path.cubicTo(
      957.3887270656121 * xScaling,
      1854.3814992179368 * yScaling,
      941.4154442872104 * xScaling,
      1864.2508392448342 * yScaling,
      924.06 * xScaling,
      1871 * yScaling,
    );
    path.cubicTo(
      905.8896989746862 * xScaling,
      1878.0733413288713 * yScaling,
      886.5585002638865 * xScaling,
      1881.6920082813906 * yScaling,
      867.06 * xScaling,
      1881.67 * yScaling,
    );
    path.cubicTo(
      867.06 * xScaling,
      1881.67 * yScaling,
      256.49 * xScaling,
      1881.67 * yScaling,
      256.49 * xScaling,
      1881.67 * yScaling,
    );
    path.cubicTo(
      236.99226066357875 * xScaling,
      1881.6835925980306 * yScaling,
      217.6626378846492 * xScaling,
      1878.065214526337 * yScaling,
      199.49 * xScaling,
      1871 * yScaling,
    );
    path.cubicTo(
      182.06362241577742 * xScaling,
      1864.2379999340885 * yScaling,
      166.01746239639579 * xScaling,
      1854.3527520152682 * yScaling,
      152.14000000000001 * xScaling,
      1841.83 * yScaling,
    );
    path.cubicTo(
      138.49988852365777 * xScaling,
      1829.55034528385 * yScaling,
      127.32988563246613 * xScaling,
      1814.7791959055648 * yScaling,
      119.23000000000002 * xScaling,
      1798.31 * yScaling,
    );
    path.cubicTo(
      111.01828690519083 * xScaling,
      1781.5587805214614 * yScaling,
      106.4091762727808 * xScaling,
      1763.2722277366133 * yScaling,
      105.70000000000002 * xScaling,
      1744.6299999999999 * yScaling,
    );
    path.cubicTo(
      105.70000000000002 * xScaling,
      1744.6299999999999 * yScaling,
      61.13 * xScaling,
      552.44 * yScaling,
      61.13 * xScaling,
      552.44 * yScaling,
    );
    path.cubicTo(
      60.25968345809446 * xScaling,
      530.5281603390775 * yScaling,
      63.7505672434492 * xScaling,
      508.66169936312076 * yScaling,
      71.4 * xScaling,
      488.11 * yScaling,
    );
    path.cubicTo(
      78.72078315500069 * xScaling,
      468.4617140483591 * yScaling,
      89.846611326496 * xScaling,
      450.4510575602903 * yScaling,
      104.14000000000001 * xScaling,
      435.11 * yScaling,
    );
    path.cubicTo(
      133.35168947776424 * xScaling,
      403.6803348546825 * yScaling,
      174.36158906475816 * xScaling,
      385.877834929185 * yScaling,
      217.27 * xScaling,
      386 * yScaling,
    );
    path.cubicTo(
      217.27 * xScaling,
      386 * yScaling,
      217.27 * xScaling,
      386 * yScaling,
      217.27 * xScaling,
      386 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => true;
}
