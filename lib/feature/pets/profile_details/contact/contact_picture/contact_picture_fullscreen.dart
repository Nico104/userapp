import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ContactPictureFullscreen extends StatelessWidget {
  const ContactPictureFullscreen({super.key, required this.pictureLink});

  final String pictureLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "contactPictureFullscreen_contactPicture".tr(),
        ),

        // centerTitle: false,
      ),
      body: PhotoView(
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        imageProvider: NetworkImage(pictureLink),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 1.8,
        initialScale: PhotoViewComputedScale.contained,
      ),
    );
  }
}
