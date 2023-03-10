import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../profile_details/models/m_tag_personalisation.dart';

class TagSingle extends StatelessWidget {
  const TagSingle({
    super.key,
    required this.collardimension,
    required this.tagPersonalisation,
  });

  //width and height
  final double collardimension;
  final TagPersonalisation tagPersonalisation;

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
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  radius: 0.7,
                  focal: Alignment.center,
                  colors: [
                    tagPersonalisation.secondaryColor,
                    tagPersonalisation.primaryColor,
                  ],
                ),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                    width: 2.5, strokeAlign: BorderSide.strokeAlignCenter),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: Offset(3.5, 0), // changes position of shadow
                  ),
                ],
              ),
              width: getSideLenght(collardimension),
              height: getSideLenght(collardimension),
            ),
          ),
        ),
        Text(tagPersonalisation.letter),
      ],
    );
  }
}

double getSideLenght(double collardimension) {
  double lenght = math.sqrt(math.pow(collardimension, 2) / 2);
  return lenght;
}
