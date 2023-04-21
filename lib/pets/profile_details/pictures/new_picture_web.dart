import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:userapp/pet_color/hex_color.dart';
import '../../../theme/custom_colors.dart';
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
    required this.addNewImage,
  });

  final double imageOffsetRight;
  final double imageWidth;
  final double imageHeight;
  final double imageBorderRadius;
  final double closeBorderRadius;

  final Function(Uint8List) addNewImage;

  @override
  State<NewPictureWeb> createState() => _NewPictureWebState();
}

class _NewPictureWebState extends State<NewPictureWeb> {
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

Future<Uint8List?> pickAndCropImage(ImageSource imageSource) async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.image, allowMultiple: false);

  if (result != null && result.files.isNotEmpty) {
    Uint8List pictureBytes = result.files.first.bytes!;
    // return File(pictureBytes);
    return pictureBytes;
  }

  // XFile? image = await ImagePicker().pickImage(source: imageSource);

  // print(image!.by);

  // final http.Response responseData = await http.get(Uri.parse(image!.path));
  // Uint8List uint8list = responseData.bodyBytes;
  // var buffer = uint8list.buffer;
  // ByteData byteData = ByteData.view(buffer);
  // var tempDir = await getTemporaryDirectory();
  // File file = await File('${tempDir.path}/img').writeAsBytes(
  //     buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  // if (image != null) {
  //   CroppedFile? croppedFile = await cropFile(image.path);
  //   if (croppedFile != null) {
  //     return File(croppedFile.path);
  //   }
  // }

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
        toolbarTitle: 'Cropper',
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
        title: 'Cropper',
      ),
      //Didn't add manifest configuration stuff
      // WebUiSettings(
      //   context: context,
      // ),
    ],
  );
}
