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
    return Image.network(
      widget.imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          errorBuilder(context, error, stackTrace),
    );
  }
}
