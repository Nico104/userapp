import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class QuickMenu extends StatefulWidget {
  const QuickMenu({super.key, required this.heroTag});

  final String heroTag;

  @override
  State<QuickMenu> createState() => _QuickMenuState();
}

class _QuickMenuState extends State<QuickMenu> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.06),
          child: SizedBox.expand(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  color: Colors.white.withOpacity(0.1),
                  width: double.infinity,
                ),
                QuickMenuItem(
                  color: Colors.white.withOpacity(0.2),
                  heightFactor: 0.8,
                ),
                QuickMenuItem(
                  color: Colors.white.withOpacity(0.3),
                  heightFactor: 0.6,
                ),
                QuickMenuItem(
                  color: Colors.white.withOpacity(0.4),
                  heightFactor: 0.4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuickMenuItem extends StatelessWidget {
  const QuickMenuItem(
      {super.key, required this.color, required this.heightFactor});

  final double heightFactor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: heightFactor,
      child: Transform.scale(
        scaleX: 1.15,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.elliptical(90.w, 200),
            ),
            color: color,
          ),
          width: double.infinity,
          // height: height,
        ),
      ),
    );
  }
}
