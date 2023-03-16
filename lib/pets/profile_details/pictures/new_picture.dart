import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'gallery_camera_dialog.dart';

class NewPicture extends StatefulWidget {
  const NewPicture({
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
  State<NewPicture> createState() => _NewPictureState();
}

class _NewPictureState extends State<NewPicture> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => const GalleryCameraDialog(),
        ).then(
          (value) async {
            if (value != null) {
              if (value == 0) {
                _image = await _picker.pickImage(source: ImageSource.gallery);
              } else if (value == 1) {
                _image = await _picker.pickImage(source: ImageSource.camera);
              }
            }
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(
            top: widget.imageOffsetRight / 1.2, right: widget.imageOffsetRight),
        width: widget.imageWidth,
        height: widget.imageHeight,
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(widget.imageBorderRadius),
          color: Colors.grey,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
