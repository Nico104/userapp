import 'package:flutter/material.dart';

import 'c_component_title.dart';
import 'g_profile_detail_globals.dart';

class PetPicturesComponent extends StatelessWidget {
  const PetPicturesComponent(
      {super.key,
      required this.imageHeight,
      required this.imageWidth,
      required this.imageBorderRadius,
      required this.imageSpacing});

  final double imageHeight;
  final double imageWidth;
  final double imageBorderRadius;
  final double imageSpacing;

  final double _imageOffset = 12;
  final double _closeBorderRadius = 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: profileDetailLeftPadding),
          child: const ComponentTitle(text: "Pictures"),
        ),
        SizedBox(
          height: imageHeight + _imageOffset,
          child: ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return SizedBox(width: profileDetailLeftPadding);
              } else {
                return Padding(
                  padding: EdgeInsets.only(right: imageSpacing),
                  child: SinglePicture(
                    imageOffsetRight: _imageOffset,
                    imageWidth: imageWidth,
                    imageHeight: imageHeight,
                    imageBorderRadius: imageBorderRadius,
                    closeBorderRadius: _closeBorderRadius,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class SinglePicture extends StatelessWidget {
  const SinglePicture({
    super.key,
    required this.imageOffsetRight,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageBorderRadius,
    required this.closeBorderRadius,
  });

  final double imageOffsetRight;
  final double imageWidth;
  final double imageHeight;
  final double imageBorderRadius;
  final double closeBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          margin: EdgeInsets.only(
              top: imageOffsetRight / 1.2, right: imageOffsetRight),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(imageBorderRadius)),
            child: Image.network(
              "https://picsum.photos/600/800",
              fit: BoxFit.cover,
              alignment: Alignment.center,
              width: imageWidth,
              height: imageHeight,
            ),
          ),
        ),
        Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(closeBorderRadius),
          // color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent, width: 1.5),
                borderRadius: BorderRadius.circular(closeBorderRadius),
                color: Colors.white),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.close_rounded,
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
