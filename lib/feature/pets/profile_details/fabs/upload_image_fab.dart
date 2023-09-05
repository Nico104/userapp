import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../general/utils_theme/custom_colors.dart';
import '../pages/edit_detail_pages/pictures_page/picture_selection.dart';

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
        // showDialog(
        //   context: context,
        //   builder: (_) => const GalleryCameraDialog(),
        // ).then(
        //   (value) {
        //     if (value != null) {
        //       ImageSource imageSource = ImageSource.gallery;
        //       if (value == 0) {
        //         imageSource = ImageSource.gallery;
        //       } else if (value == 1) {
        //         imageSource = ImageSource.camera;
        //       }
        //       if (kIsWeb) {
        //         pickAndCropImageWeb().then(
        //           (image) {
        //             if (image != null) {
        //               addPetPicture.call(image);
        //             }
        //           },
        //         );
        //       } else {
        //         pickAndCropImage(imageSource).then(
        //           (image) {
        //             if (image != null) {
        //               addPetPicture.call(image);
        //             }
        //           },
        //         );
        //       }
        //     }
        //   },
        // );
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(28),
              ),
              child: PictureSelection(
                addPicture: addPetPicture,
              ),
            );
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
