import 'dart:io';

import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/models/m_pet_picture.dart';
import 'package:userapp/pets/profile_details/pictures/new_picture.dart';

import '../c_component_title.dart';
import '../g_profile_detail_globals.dart';
import 'delete_alert_dialog.dart';

class PetPicturesComponent extends StatefulWidget {
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
  //Maybe not needed since pictures form that lst can only be deleted
  final ValueSetter<List<PetPicture>> setPetPictures;

  final double imageHeight;
  final double imageWidth;
  final double imageBorderRadius;
  final double imageSpacing;

  final double imageOffset = 12;
  final double closeBorderRadius = 8;

  @override
  State<PetPicturesComponent> createState() => _PetPicturesComponentState();
}

class _PetPicturesComponentState extends State<PetPicturesComponent> {
  List<File> newPictures = List<File>.empty(growable: true);
  int petPictureLenght = 2;

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
          height: widget.imageHeight + widget.imageOffset,
          child: ListView.builder(
            //Lenght of petPictures + newPictures + 2 for leading spacing and for new Image
            itemCount: petPictureLenght + newPictures.length + 2,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              int position = index - 1;
              if (position == -1) {
                return const SizedBox(width: profileDetailLeftPadding);
              } else if (position < petPictureLenght) {
                // print("I am a Path");
                return Padding(
                  padding: EdgeInsets.only(right: widget.imageSpacing),
                  child: SinglePicturePath(
                    imageOffsetRight: widget.imageOffset,
                    imageWidth: widget.imageWidth,
                    imageHeight: widget.imageHeight,
                    imageBorderRadius: widget.imageBorderRadius,
                    closeBorderRadius: widget.closeBorderRadius,
                  ),
                );
              } else if (position < petPictureLenght + newPictures.length) {
                // print("I am a File");
                return Padding(
                  padding: EdgeInsets.only(right: widget.imageSpacing),
                  child: SinglePictureFile(
                    image: newPictures.elementAt(position - petPictureLenght),
                    deleteImage: () {
                      setState(() {
                        newPictures.removeAt(position - petPictureLenght);
                      });
                    },
                    imageOffsetRight: widget.imageOffset,
                    imageWidth: widget.imageWidth,
                    imageHeight: widget.imageHeight,
                    imageBorderRadius: widget.imageBorderRadius,
                    closeBorderRadius: widget.closeBorderRadius,
                  ),
                );
              } else {
                // print("I am a New");
                return Padding(
                  padding: EdgeInsets.only(right: widget.imageSpacing),
                  child: NewPicture(
                    imageOffsetRight: widget.imageOffset,
                    imageWidth: widget.imageWidth,
                    imageHeight: widget.imageHeight,
                    imageBorderRadius: widget.imageBorderRadius,
                    closeBorderRadius: widget.closeBorderRadius,
                    addNewImage: (image) {
                      setState(() {
                        newPictures.add(image);
                      });
                    },
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

class SinglePicturePath extends StatelessWidget {
  const SinglePicturePath({
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
              top: imageOffsetRight / 1.2, right: imageOffsetRight, bottom: 8),
          width: imageWidth,
          height: imageHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(imageBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                blurRadius: 6,
                offset: const Offset(0.5, 1.5), // changes position of shadow
              ),
            ],
            image: const DecorationImage(
              image: NetworkImage("https://picsum.photos/600/800"),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.redAccent, width: 1),
            borderRadius: BorderRadius.circular(closeBorderRadius),
            color: Colors.white,
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

class SinglePictureFile extends StatelessWidget {
  const SinglePictureFile({
    super.key,
    required this.image,
    required this.deleteImage,
    required this.imageOffsetRight,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageBorderRadius,
    required this.closeBorderRadius,
  });

  final File image;
  final VoidCallback deleteImage;
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                blurRadius: 6,
                offset: const Offset(1, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(imageBorderRadius),
            image: DecorationImage(
              image: FileImage(image),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (_) => const DeleteImageAlertDialog(),
          ).then((value) {
            if (value == 1) {
              deleteImage.call();
            }
          }),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.redAccent, width: 1),
              borderRadius: BorderRadius.circular(closeBorderRadius),
              color: Colors.white,
            ),
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
