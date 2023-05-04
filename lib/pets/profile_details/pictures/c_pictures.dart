import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:userapp/network_globals.dart';
import 'package:userapp/pets/profile_details/models/m_pet_picture.dart';

import '../../../styles/custom_icons_icons.dart';
import 'extended_picture.dart';

class PetPicturesComponent extends StatefulWidget {
  const PetPicturesComponent({
    super.key,
    required this.petPictures,
    // required this.setPetPictures,
    // required this.newPetPictures,
    required this.removePetPicture,
    required this.imageView,
  });

  //Pictures
  final List<PetPicture> petPictures;
  //Maybe not needed since pictures form that lst can only be deleted
  // final ValueSetter<List<PetPicture>> setPetPictures;

  // final List<Uint8List> newPetPictures;
  //Param index
  final ValueSetter<int> removePetPicture;

  final double imageOffset = 12;
  final double closeBorderRadius = 8;

  //0 Grid 1 List
  final int imageView;

  @override
  State<PetPicturesComponent> createState() => _PetPicturesComponentState();
}

class _PetPicturesComponentState extends State<PetPicturesComponent> {
  // List<Uint8List> newPictures = List<Uint8List>.empty(growable: true);
  // late int petPictureLenght;
  // late int newPetPictureLenght;

  @override
  void initState() {
    super.initState();
    // petPictureLenght = widget.petPictures.length;
    // newPetPictureLenght = widget.newPictures.length;
    for (var element in widget.petPictures) {
      print(element.petPictureId.toString() +
          ": " +
          s3BaseUrl +
          element.petPictureLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageView == 0) {
      return GridView.builder(
        //Lenght of petPictures + 1 for new Image
        itemCount: widget.petPictures.length,
        // itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index < widget.petPictures.length) {
            return SinglePicture(
              removePetPicture: () {
                widget.removePetPicture.call(index);
              },
              imageUrl: s3BaseUrl +
                  widget.petPictures.elementAt(index).petPictureLink,
            );
          }
        },
      );
    } else {
      return ListView.builder(
        //Lenght of petPictures + 1 for new Image
        itemCount: widget.petPictures.length,
        // itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (index < widget.petPictures.length) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SinglePicture(
                  removePetPicture: () {
                    widget.removePetPicture.call(index);
                  },
                  imageUrl: s3BaseUrl +
                      widget.petPictures.elementAt(index).petPictureLink,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 38),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        // Icons.share,
                        CustomIcons.share_thin,
                        size: 24,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     // widget.removePetPicture.call();
                      //     Navigator.pop(context);
                      //   },
                      //   child: const Icon(
                      //     CustomIcons.delete,
                      //     size: 34,
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      );
    }
  }
}

class SinglePicture extends StatefulWidget {
  const SinglePicture({
    super.key,
    required this.removePetPicture,
    required this.imageUrl,
  });

  // final double imageOffsetRight;
  // final double imageWidth;
  // final double imageHeight;
  // final double imageBorderRadius;
  // final double closeBorderRadius;
  //Param index
  final VoidCallback removePetPicture;
  final String imageUrl;

  @override
  State<SinglePicture> createState() => _SinglePictureState();
}

class _SinglePictureState extends State<SinglePicture> {
  final GlobalKey extended = GlobalKey();

  void showExtendedPicture(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => ExtendedPicture(
        key: extended,
        imageUrl: widget.imageUrl,
        removePetPicture: () => widget.removePetPicture(),
        errorBuilder: (context, error, stackTrace) =>
            errorBuilder(context, error, stackTrace),
      ),
    );
  }

  void endExtendedPicture(BuildContext context) {}

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
    return GestureDetector(
      onTap: () {
        showExtendedPicture(context);
      },
      onLongPress: () {
        showExtendedPicture(context);
      },
      onLongPressEnd: (_) {
        print("end");
        setState(() {});
      },
      onLongPressCancel: () {
        print("cancel");
        setState(() {});
      },
      child: Image.network(
        widget.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            errorBuilder(context, error, stackTrace),
      ),
      // child: Container(
      //   // margin: EdgeInsets.only(
      //   //     top: imageOffsetRight / 1.2, right: imageOffsetRight, bottom: 8),
      //   // width: imageWidth,
      //   // height: imageHeight,
      //   decoration: BoxDecoration(
      //     // borderRadius: BorderRadius.circular(imageBorderRadius),
      //     // boxShadow: kElevationToShadow[2],
      //     image: DecorationImage(
      //       image: widget.image,
      //       fit: BoxFit.cover,
      //       alignment: Alignment.center,
      //     ),
      //   ),
      // ),
    );
  }
}
