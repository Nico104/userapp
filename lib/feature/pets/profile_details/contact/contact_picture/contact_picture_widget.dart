import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:userapp/general/network_globals.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';
import 'contact_picture_fullscreen.dart';
import 'contact_picture_selection.dart';

class ContactPicture extends StatelessWidget {
  const ContactPicture({
    super.key,
    required this.addContactPicture,
    required this.contactPictureLink,
    required this.onDelete,
  });

  final String? contactPictureLink;
  final Future<void> Function(Uint8List) addContactPicture;
  final VoidCallback onDelete;

  String _getContactPictureLink() {
    if (contactPictureLink != null) {
      return s3BaseUrl + contactPictureLink!;
    } else {
      //TDO get default avatar Link
      return "https://picsum.photos/512";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Material(
          borderRadius: BorderRadius.circular(128),
          elevation: 2,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactPictureFullscreen(
                    pictureLink: _getContactPictureLink(),
                  ),
                ),
              );
            },
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(128),
                // border: Border.all(color: Colors.grey, width: 1.5),
                image: DecorationImage(
                  image: NetworkImage(_getContactPictureLink()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
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
                  child: ContactPictureSelection(
                    addContactPicture: addContactPicture,
                    onDelete: onDelete,
                  ),
                );
              },
            );
          },
          child: Material(
            borderRadius: BorderRadius.circular(128),
            elevation: 4,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(128),
                color: getCustomColors(context).accent,
              ),
              child: Icon(
                Icons.camera_alt_rounded,
                color: Theme.of(context).primaryColor,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
