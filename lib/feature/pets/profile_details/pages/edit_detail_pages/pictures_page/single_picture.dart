import 'package:flutter/material.dart';

class SinglePicture extends StatefulWidget {
  const SinglePicture({
    super.key,
    // required this.removePetPicture,
    required this.imageUrl,
  });

  // final double imageOffsetRight;
  // final double imageWidth;
  // final double imageHeight;
  // final double imageBorderRadius;
  // final double closeBorderRadius;
  //Param index
  // final VoidCallback removePetPicture;
  final String imageUrl;

  @override
  State<SinglePicture> createState() => _SinglePictureState();
}

class _SinglePictureState extends State<SinglePicture> {
  final GlobalKey extended = GlobalKey();

  // void showExtendedPicture(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => ExtendedPicture(
  //       key: extended,
  //       imageUrl: widget.imageUrl,
  //       removePetPicture: () => widget.removePetPicture(),
  //       errorBuilder: (context, error, stackTrace) =>
  //           errorBuilder(context, error, stackTrace),
  //     ),
  //   );
  // }

  // void endExtendedPicture(BuildContext context) {}

  Widget errorBuilder(
      BuildContext context, Object error, StackTrace? stackTrace) {
    print(error);
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      setState(() {});
    });
    return CircularProgressIndicator();
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
