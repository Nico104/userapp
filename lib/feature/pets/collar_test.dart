import 'package:flutter/material.dart';
import 'dart:math' as math;

class CollarTest extends StatelessWidget {
  const CollarTest({super.key, required this.collardimension});

  //width and height
  final double collardimension;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(
              (collardimension - getSideLenght(collardimension)) / 2),
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Material(
              elevation: 8,
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    radius: 2,
                    focal: Alignment.center,
                    colors: [
                      Colors.greenAccent,
                      Colors.blue,
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                width: getSideLenght(collardimension),
                height: getSideLenght(collardimension),
              ),
            ),
          ),
        ),
        const Text("D"),
      ],
    );
  }
}

double getSideLenght(double collardimension) {
  double lenght = math.sqrt(math.pow(collardimension, 2) / 2);
  return lenght;
}
