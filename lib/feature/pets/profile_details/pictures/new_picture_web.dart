import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:userapp/general/utils_color/hex_color.dart';
import '../../../../general/utils_theme/custom_colors.dart';
import '../../../../general/widgets/loading_indicator.dart';
import 'gallery_camera_dialog.dart';
import 'package:http/http.dart' as http;

class NewPictureWeb extends StatefulWidget {
  const NewPictureWeb({
    super.key,
    required this.imageOffsetRight,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageBorderRadius,
    required this.closeBorderRadius,
    // required this.addNewImage,
    required this.addPetPicture,
  });

  final double imageOffsetRight;
  final double imageWidth;
  final double imageHeight;
  final double imageBorderRadius;
  final double closeBorderRadius;

  // final Function(Uint8List) addNewImage;
  final Future<void> Function(Uint8List) addPetPicture;

  @override
  State<NewPictureWeb> createState() => _NewPictureWebState();
}

class _NewPictureWebState extends State<NewPictureWeb> {
  bool _loading = false;

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
                    setState(() {
                      _loading = true;
                    });
                    widget.addPetPicture.call(image);
                  }
                },
              );
            }
          },
        );
      },
      child: _loading
          ? Container(
              margin: const EdgeInsets.all(24),
              child: const CustomLoadingIndicatior(),
            )
          : Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: getCustomColors(context).lightBorder ??
                        Colors.transparent,
                  ),
                  // borderRadius: BorderRadius.circular(widget.imageBorderRadius),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.add),
            ),
    );
  }
}

Future<Uint8List?> pickAndCropImage(ImageSource imageSource) async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.image, allowMultiple: false);

  if (result != null && result.files.isNotEmpty) {
    Uint8List pictureBytes = result.files.first.bytes!;
    // return File(pictureBytes);
    return pictureBytes;
  }

  return null;
}

Future<CroppedFile?> cropFile(String path) async {
  return await ImageCropper().cropImage(
    sourcePath: path,
    aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 16),
    uiSettings: [
      //TODO set Colors
      AndroidUiSettings(
        showCropGrid: false,
        toolbarTitle: 'newPictureWeb_cropper'.tr(),
        toolbarColor: HexColor("FFFF8F"),
        toolbarWidgetColor: Colors.black,
        activeControlsWidgetColor: Colors.black,
        backgroundColor: Colors.black,
        cropFrameColor: HexColor("FFFF8F"),
        cropFrameStrokeWidth: 6,
        hideBottomControls: true,
        lockAspectRatio: true,
      ),
      IOSUiSettings(
        title: 'newPictureWeb_cropper'.tr(),
      ),
      //Didn't add manifest configuration stuff
      // WebUiSettings(
      //   context: context,
      // ),
    ],
  );
}
