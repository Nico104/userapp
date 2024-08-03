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

    return CachedNetworkImage(
      imageUrl: s3BaseUrl + picturePath,
      placeholder: (context, url) => const CustomLoadingIndicatior(),
      // errorWidget: (context, url, error) => const Icon(Icons.error),
      errorWidget: (context, url, error) =>
          Image.asset("assets/details_illustartions/newtag2.png"),
      width: collardimension,
      height: collardimension,
      fit: BoxFit.contain,
    );
  }
}
