import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:userapp/general/network_globals.dart';
import 'package:userapp/general/widgets/loading_indicator.dart';

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
