import 'package:flutter/material.dart';
import 'package:userapp/network_globals.dart';
import 'dart:math' as math;

import '../../styles/text_styles.dart';
import '../profile_details/models/m_tag_personalisation.dart';

class TagSingle extends StatelessWidget {
  const TagSingle({
    super.key,
    required this.collardimension,
    required this.picturePath,
  });

  //width and height
  final double collardimension;
  // final TagPersonalisation tagPersonalisation;
  final String picturePath;

  @override
  Widget build(BuildContext context) {
    //Bilder direct mit shadow zeichnen
    return Image.network(
      // "assets/tmp/2d_paw_blue.png",
      s3BaseUrl + picturePath,
      width: collardimension,
      height: collardimension,
      fit: BoxFit.contain,
    );
  }
}

double getSideLenght(double collardimension) {
  double lenght = math.sqrt(math.pow(collardimension, 2) / 2);
  return lenght;
}
