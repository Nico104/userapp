import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:sizer/sizer.dart';

class CollarTag extends StatefulWidget {
  const CollarTag(
      {super.key, required this.collarheight, required this.collarelevation});

  final double collarheight, collarelevation;

  @override
  State<CollarTag> createState() => _CollarTagState();
}

class _CollarTagState extends State<CollarTag> {
  bool collarchooseactive = false;
  Duration duration = const Duration(milliseconds: 250);
  Curve curve = Curves.fastOutSlowIn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          collarchooseactive = !collarchooseactive;
        });
      },
      child: AnimatedAlign(
        alignment: collarchooseactive == true
            ? Alignment.center
            : Alignment.bottomCenter,
        duration: duration,
        curve: curve,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedRotation(
              turns: collarchooseactive == true ? 0 : 0.125,
              duration: duration,
              curve: curve,
              child: Material(
                elevation: widget.collarelevation,
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                    Radius.circular(collarchooseactive == true ? 18 : 4)),
                child: AnimatedContainer(
                  duration: duration,
                  // color: Colors.greenAccent,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      radius: collarchooseactive == true ? 6 : 2,
                      focal: collarchooseactive == true
                          ? Alignment.bottomCenter
                          : Alignment.center,
                      colors: [
                        Colors.greenAccent,
                        Colors.blue,
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(collarchooseactive == true ? 18 : 4)),
                  ),
                  width: collarchooseactive == true ? 300 : widget.collarheight,
                  height:
                      collarchooseactive == true ? 400 : widget.collarheight,
                ),
              ),
            ),
            const Text("D"),
          ],
        ),
      ),
    );
  }
}
