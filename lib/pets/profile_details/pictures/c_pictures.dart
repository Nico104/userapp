import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/models/m_pet_picture.dart';
import 'package:userapp/pets/profile_details/pictures/new_picture.dart';

import '../c_component_title.dart';
import '../g_profile_detail_globals.dart';

class PetPicturesComponent extends StatelessWidget {
  const PetPicturesComponent({
    super.key,
    required this.imageHeight,
    required this.imageWidth,
    required this.imageBorderRadius,
    required this.imageSpacing,
    required this.petPictures,
    required this.setPetPictures,
  });

  //Pictures
  final List<PetPicture> petPictures;
  final ValueSetter<List<PetPicture>> setPetPictures;

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
        const Padding(
          padding: EdgeInsets.only(left: profileDetailLeftPadding),
          child: ComponentTitle(text: "Pictures"),
        ),
        SizedBox(
          height: imageHeight + _imageOffset,
          child: ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return const SizedBox(width: profileDetailLeftPadding);
              } else if (index == 1) {
                return NewPicture(
                  imageOffsetRight: _imageOffset,
                  imageWidth: imageWidth,
                  imageHeight: imageHeight,
                  imageBorderRadius: imageBorderRadius,
                  closeBorderRadius: _closeBorderRadius,
                );
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
          width: imageWidth,
          height: imageHeight,
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(imageBorderRadius),
            image: const DecorationImage(
              image: NetworkImage("https://picsum.photos/600/800"),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.redAccent, width: 1.5),
            borderRadius: BorderRadius.circular(closeBorderRadius),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.redAccent.withOpacity(0.80),
                spreadRadius: 0,
                blurRadius: 0,
                offset: const Offset(0.5, 0.5), // changes position of shadow
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: Icon(
              Icons.close_rounded,
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}
