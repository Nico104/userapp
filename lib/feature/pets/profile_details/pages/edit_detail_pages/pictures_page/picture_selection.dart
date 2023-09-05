import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';

import '../../../pictures/new_picture.dart';

class PictureSelection extends StatelessWidget {
  const PictureSelection({
    super.key,
    required this.addPicture,
  });

  final Future<void> Function(Uint8List) addPicture;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Select Picture",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 36),
        Row(
          children: [
            SelectionOption(
              label: "Camera",
              icon: const Icon(Icons.camera_alt_rounded),
              onTap: () {
                if (kIsWeb) {
                  pickAndCropImageWeb().then(
                    (image) {
                      if (image != null) {
                        //If pop after addPicture it dismisses the upload loading dialog
                        Navigator.pop(context);
                        addPicture.call(image);
                      }
                    },
                  );
                } else {
                  ImageSource imageSource = ImageSource.camera;
                  pickAndCropImage(imageSource).then(
                    (image) {
                      if (image != null) {
                        //If pop after addPicture it dismisses the upload loading dialog
                        Navigator.pop(context);
                        addPicture.call(image);
                      }
                    },
                  );
                }
              },
            ),
            const SizedBox(width: 32),
            SelectionOption(
              label: "Gallery",
              icon: const Icon(Icons.image),
              onTap: () {
                if (kIsWeb) {
                  pickAndCropImageWeb().then(
                    (image) {
                      if (image != null) {
                        //If pop after addPicture it dismisses the upload loading dialog
                        Navigator.pop(context);
                        addPicture.call(image);
                      }
                    },
                  );
                } else {
                  ImageSource imageSource = ImageSource.gallery;
                  pickAndCropImage(imageSource).then(
                    (image) {
                      if (image != null) {
                        //If pop after addPicture it dismisses the upload loading dialog
                        Navigator.pop(context);
                        addPicture.call(image);
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class SelectionOption extends StatelessWidget {
  const SelectionOption({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(128),
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            child: icon,
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}

Future<Uint8List?> pickAndCropImageWeb() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.image, allowMultiple: false, withData: true);

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
