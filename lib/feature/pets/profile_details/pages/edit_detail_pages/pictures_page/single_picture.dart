import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../general/widgets/loading_indicator.dart';

class SinglePicture extends StatefulWidget {
  const SinglePicture({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  State<SinglePicture> createState() => _SinglePictureState();
}

class _SinglePictureState extends State<SinglePicture> {
  final GlobalKey extended = GlobalKey();

  Widget errorBuilder(
      BuildContext context, Object error, StackTrace? stackTrace) {
    print(error);
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      setState(() {});
    });
    return const CustomLoadingIndicatior();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.imageUrl);
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      placeholder: (context, url) => const CustomLoadingIndicatior(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }
}
