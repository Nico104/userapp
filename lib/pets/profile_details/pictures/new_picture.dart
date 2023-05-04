import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:userapp/pet_color/hex_color.dart';
import '../../../theme/custom_colors.dart';
import 'gallery_camera_dialog.dart';

class NewPicture extends StatefulWidget {
  const NewPicture({
    super.key,
    required this.imageOffsetRight,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageBorderRadius,
    required this.closeBorderRadius,
    required this.addNewImage,
  });

  final double imageOffsetRight;
  final double imageWidth;
  final double imageHeight;
  final double imageBorderRadius;
  final double closeBorderRadius;

  final Function(File) addNewImage;

  @override
  State<NewPicture> createState() => _NewPictureState();
}

class _NewPictureState extends State<NewPicture> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => const GalleryCameraDialog(),
        ).then(
          (value) {
            if (value != null) {
              ImageSource imageSource = ImageSource.gallery;
              if (value == 0) {
                imageSource = ImageSource.gallery;
              } else if (value == 1) {
                imageSource = ImageSource.camera;
              }
              pickAndCropImage(imageSource).then(
                (image) {
                  if (image != null) {
                    widget.addNewImage.call(image);
                  }
                },
              );
            }
          },
        );
      },
      child: Container(
        // margin: EdgeInsets.only(
        //     top: widget.imageOffsetRight / 1.2, right: widget.imageOffsetRight),
        // width: widget.imageWidth,
        // height: widget.imageHeight,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: getCustomColors(context).lightBorder ?? Colors.transparent,
            ),
            // borderRadius: BorderRadius.circular(widget.imageBorderRadius),
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<File?> pickAndCropImage(ImageSource imageSource) async {
  XFile? image = await ImagePicker().pickImage(source: imageSource);
  if (image != null) {
    CroppedFile? croppedFile = await cropFile(image.path);
    if (croppedFile != null) {
      return File(croppedFile.path);
    }
  }
  return null;
}

Future<CroppedFile?> cropFile(String path) async {
  return await ImageCropper().cropImage(
    sourcePath: path,
    // aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 16),
    uiSettings: [
      //TODO set Colors
      AndroidUiSettings(
        showCropGrid: false,
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.grey,
        toolbarWidgetColor: Colors.black,
        activeControlsWidgetColor: Colors.black,
        backgroundColor: Colors.black,
        cropFrameColor: Colors.grey,
        cropFrameStrokeWidth: 6,
        hideBottomControls: true,
        // lockAspectRatio: true,
      ),
      IOSUiSettings(
        title: 'Cropper',
      ),
      //Didn't add manifest configuration stuff
      // WebUiSettings(
      //   context: context,
      // ),
    ],
  );
}
