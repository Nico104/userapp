import 'package:flutter/material.dart';
import 'package:userapp/general/network_globals.dart';
import 'dart:math' as math;

class TagSingle extends StatelessWidget {
  const TagSingle({
    super.key,
    this.collardimension,
    required this.picturePath,
  });

  //width and height
  final double? collardimension;
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
