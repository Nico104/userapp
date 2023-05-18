import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userapp/styles/custom_icons_icons.dart';

import '../../d_confirm_delete.dart';
import '../../fabs/upload_image_fab.dart';
import '../../pictures/picture_selection.dart';

class ContactPictureSelection extends StatelessWidget {
  const ContactPictureSelection({
    super.key,
    required this.addContactPicture,
    required this.onDelete,
  });

  final Future<void> Function(Uint8List) addContactPicture;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Select Contact Picture",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => const ConfirmDeleteDialog(
                    label: "Contact Picture",
                  ),
                ).then((value) {
                  if (value != null) {
                    if (value == true) {
                      Navigator.pop(context);
                      onDelete();
                    }
                  }
                });
              },
              child: const Icon(CustomIcons.delete),
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
                        addContactPicture.call(image);
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
                        addContactPicture.call(image);
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
                        addContactPicture.call(image);
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
                        addContactPicture.call(image);
                      }
                    },
                  );
                }
              },
            ),
            const SizedBox(width: 32),
            SelectionOption(
              label: "Avatar",
              icon: const Icon(Icons.person_2),
              onTap: () {},
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
