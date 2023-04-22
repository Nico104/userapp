// import 'dart:io';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:userapp/network_globals.dart';
// import 'package:userapp/pets/profile_details/models/m_pet_picture.dart';
// import 'package:userapp/pets/profile_details/pictures/new_picture.dart';
// import 'package:userapp/pets/profile_details/pictures/new_picture_web.dart';

// import '../../../theme/custom_colors.dart';
// import '../c_component_title.dart';
// import '../g_profile_detail_globals.dart';
// import 'delete_alert_dialog.dart';
// import 'extended_picture.dart';

// class PetPicturesComponent extends StatefulWidget {
//   const PetPicturesComponent({
//     super.key,
//     required this.imageHeight,
//     required this.imageWidth,
//     required this.imageBorderRadius,
//     required this.imageSpacing,
//     required this.petPictures,
//     required this.setPetPictures,
//     required this.newPetPictures,
//     required this.addPetPicture,
//     required this.removePetPicture,
//   });

//   //Pictures
//   final List<PetPicture> petPictures;
//   //Maybe not needed since pictures form that lst can only be deleted
//   final ValueSetter<List<PetPicture>> setPetPictures;

//   final List<Uint8List> newPetPictures;
//   final ValueSetter<Uint8List> addPetPicture;
//   //Param index
//   final ValueSetter<int> removePetPicture;

//   final double imageHeight;
//   final double imageWidth;
//   final double imageBorderRadius;
//   final double imageSpacing;

//   final double imageOffset = 12;
//   final double closeBorderRadius = 8;

//   @override
//   State<PetPicturesComponent> createState() => _PetPicturesComponentState();
// }

// class _PetPicturesComponentState extends State<PetPicturesComponent> {
//   // List<Uint8List> newPictures = List<Uint8List>.empty(growable: true);
//   // late int petPictureLenght;
//   // late int newPetPictureLenght;

//   @override
//   void initState() {
//     super.initState();
//     // petPictureLenght = widget.petPictures.length;
//     // newPetPictureLenght = widget.newPictures.length;
//     for (var element in widget.petPictures) {
//       print(element.petPictureId.toString() +
//           ": " +
//           s3BaseUrl +
//           element.petPictureLink);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       //Lenght of petPictures + newPictures + 1 for new Image
//       itemCount: widget.petPictures.length + widget.newPetPictures.length + 1,
//       // itemCount: 10,
//       shrinkWrap: true,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         childAspectRatio: 1,
//       ),
//       itemBuilder: (BuildContext context, int index) {
//         // int position = index;
//         if (index < widget.petPictures.length) {
//           // print("I am a Path");
//           return SinglePicture(
//             imageOffsetRight: widget.imageOffset,
//             imageWidth: widget.imageWidth,
//             imageHeight: widget.imageHeight,
//             imageBorderRadius: widget.imageBorderRadius,
//             closeBorderRadius: widget.closeBorderRadius,
//             deleteImage: () {},
//             // image: const NetworkImage("https://picsum.photos/600/800"),
//             image: NetworkImage(
//                 s3BaseUrl + widget.petPictures.elementAt(index).petPictureLink),
//           );
//         } else if (index <
//             widget.petPictures.length + widget.newPetPictures.length) {
//           // print("I am a File");
//           return SinglePicture(
//             imageOffsetRight: widget.imageOffset,
//             imageWidth: widget.imageWidth,
//             imageHeight: widget.imageHeight,
//             imageBorderRadius: widget.imageBorderRadius,
//             closeBorderRadius: widget.closeBorderRadius,
//             deleteImage: () {
//               setState(() {
//                 widget.newPetPictures
//                     .removeAt(index - widget.petPictures.length);
//               });
//             },
//             // image: FileImage(newPictures.elementAt(index - petPictureLenght)),
//             image: MemoryImage(widget.newPetPictures
//                 .elementAt(index - widget.petPictures.length)),
//           );
//         } else {
//           // print("I am a New");
//           return kIsWeb
//               ? NewPictureWeb(
//                   imageOffsetRight: widget.imageOffset,
//                   imageWidth: widget.imageWidth,
//                   imageHeight: widget.imageHeight,
//                   imageBorderRadius: widget.imageBorderRadius,
//                   closeBorderRadius: widget.closeBorderRadius,
//                   addNewImage: (image) {
//                     // setState(() {
//                     //   widget.newPictures.add(image);
//                     // });
//                     widget.addPetPicture.call(image);
//                   },
//                 )
//               : NewPicture(
//                   imageOffsetRight: widget.imageOffset,
//                   imageWidth: widget.imageWidth,
//                   imageHeight: widget.imageHeight,
//                   imageBorderRadius: widget.imageBorderRadius,
//                   closeBorderRadius: widget.closeBorderRadius,
//                   addNewImage: (image) {
//                     // setState(() {
//                     //   //TODO change returnType from File to Bytes
//                     //   widget.newPictures.add(image.readAsBytesSync());
//                     // });
//                     widget.addPetPicture.call(image.readAsBytesSync());
//                   },
//                 );
//         }
//       },
//     );
//   }
//   // child: ListView.builder(
//   //   //Lenght of petPictures + newPictures + 2 for leading spacing and for new Image
//   //   itemCount: petPictureLenght + newPictures.length + 2,
//   //   shrinkWrap: true,
//   //   scrollDirection: Axis.horizontal,
//   //   itemBuilder: (BuildContext context, int index) {
//   //     int position = index - 1;
//   //     if (position == -1) {
//   //       return const SizedBox(width: profileDetailLeftPadding);
//   //     } else if (position < petPictureLenght) {
//   //       // print("I am a Path");
//   //       return Padding(
//   //         padding: EdgeInsets.only(right: widget.imageSpacing),
//   //         child: SinglePicture(
//   //           imageOffsetRight: widget.imageOffset,
//   //           imageWidth: widget.imageWidth,
//   //           imageHeight: widget.imageHeight,
//   //           imageBorderRadius: widget.imageBorderRadius,
//   //           closeBorderRadius: widget.closeBorderRadius,
//   //           deleteImage: () {},
//   //           image: const NetworkImage("https://picsum.photos/600/800"),
//   //         ),
//   //       );
//   //     } else if (position < petPictureLenght + newPictures.length) {
//   //       // print("I am a File");
//   //       return Padding(
//   //         padding: EdgeInsets.only(right: widget.imageSpacing),
//   //         child: SinglePicture(
//   //             imageOffsetRight: widget.imageOffset,
//   //             imageWidth: widget.imageWidth,
//   //             imageHeight: widget.imageHeight,
//   //             imageBorderRadius: widget.imageBorderRadius,
//   //             closeBorderRadius: widget.closeBorderRadius,
//   //             deleteImage: () {
//   //               setState(() {
//   //                 newPictures.removeAt(position - petPictureLenght);
//   //               });
//   //             },
//   //             image: FileImage(
//   //                 newPictures.elementAt(position - petPictureLenght))),
//   //       );
//   //     } else {
//   //       // print("I am a New");
//   //       return Padding(
//   //         padding: EdgeInsets.only(right: widget.imageSpacing),
//   //         child: NewPicture(
//   //           imageOffsetRight: widget.imageOffset,
//   //           imageWidth: widget.imageWidth,
//   //           imageHeight: widget.imageHeight,
//   //           imageBorderRadius: widget.imageBorderRadius,
//   //           closeBorderRadius: widget.closeBorderRadius,
//   //           addNewImage: (image) {
//   //             setState(() {
//   //               newPictures.add(image);
//   //             });
//   //           },
//   //         ),
//   //       );
//   //     }
//   //   },
//   // ),
// }

// class SinglePicture extends StatefulWidget {
//   const SinglePicture({
//     super.key,
//     required this.imageOffsetRight,
//     required this.imageWidth,
//     required this.imageHeight,
//     required this.imageBorderRadius,
//     required this.closeBorderRadius,
//     required this.image,
//     required this.deleteImage,
//   });

//   final double imageOffsetRight;
//   final double imageWidth;
//   final double imageHeight;
//   final double imageBorderRadius;
//   final double closeBorderRadius;
//   final VoidCallback deleteImage;
//   final ImageProvider<Object> image;

//   @override
//   State<SinglePicture> createState() => _SinglePictureState();
// }

// class _SinglePictureState extends State<SinglePicture> {
//   final GlobalKey extended = GlobalKey();

//   void showExtendedPicture(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (_) => ExtendedPicture(
//         key: extended,
//         image: widget.image,
//       ),
//     );
//   }

//   void endExtendedPicture(BuildContext context) {}

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showExtendedPicture(context);
//       },
//       onLongPress: () {
//         showExtendedPicture(context);
//       },
//       onLongPressEnd: (_) {
//         print("end");
//         setState(() {});
//       },
//       onLongPressCancel: () {
//         print("cancel");
//         setState(() {});
//       },
//       child: Container(
//         // margin: EdgeInsets.only(
//         //     top: imageOffsetRight / 1.2, right: imageOffsetRight, bottom: 8),
//         // width: imageWidth,
//         // height: imageHeight,
//         decoration: BoxDecoration(
//           // borderRadius: BorderRadius.circular(imageBorderRadius),
//           // boxShadow: kElevationToShadow[2],
//           image: DecorationImage(
//             image: widget.image,
//             fit: BoxFit.cover,
//             alignment: Alignment.center,
//           ),
//         ),
//       ),
//     );
//   }
// }
