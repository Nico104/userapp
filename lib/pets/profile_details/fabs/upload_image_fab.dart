import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../theme/custom_colors.dart';
import '../pictures/gallery_camera_dialog.dart';
import '../pictures/new_picture.dart';

class UploadImageFab extends StatelessWidget {
  const UploadImageFab({super.key, required this.addPetPicture});

  final Future<void> Function(Uint8List) addPetPicture;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: getCustomColors(context).accent,
      tooltip: "Click to upload image",
      onPressed: () async {
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
              if (kIsWeb) {
                pickAndCropImageWeb().then(
                  (image) {
                    if (image != null) {
                      addPetPicture.call(image);
                    }
                  },
                );
              } else {
                pickAndCropImage(imageSource).then(
                  (image) {
                    if (image != null) {
                      addPetPicture.call(image);
                    }
                  },
                );
              }
            }
          },
        );
      },
      child: Icon(
        Icons.add_photo_alternate_rounded,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

Future<Uint8List?> pickAndCropImageWeb() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.image, allowMultiple: false);

  if (result != null && result.files.isNotEmpty) {
    Uint8List pictureBytes = result.files.first.bytes!;
    return pictureBytes;
  }
  return null;
}

Future<Uint8List?> pickAndCropImage(ImageSource imageSource) async {
  XFile? image = await ImagePicker().pickImage(source: imageSource);
  if (image != null) {
    CroppedFile? croppedFile = await cropFile(image.path);
    if (croppedFile != null) {
      return File(croppedFile.path).readAsBytesSync();
    }
  }
  return null;
}
