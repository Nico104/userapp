import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/custom_colors.dart';
import '../pictures/gallery_camera_dialog.dart';
import '../pictures/new_picture.dart';

class UploadDocumentFab extends StatelessWidget {
  const UploadDocumentFab({super.key, required this.addDocument});

  final Future<void> Function(Uint8List) addDocument;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: getCustomColors(context).accent,
      tooltip: "Click to upload document",
      onPressed: () async {
        // pickDocument().then((value) => {
        //       showDialog(
        //         context: context,
        //         builder: (_) => const DocumentDialog(),
        //       )
        //     });
        showDialog(
          context: context,
          builder: (_) => const DocumentDialog(),
        ).then((value) {
          pickDocument().then((value) {
            showDialog(
              context: context,
              builder: (_) => const DocumentDialog(),
            );
          });
        });
      },
      child: Icon(
        Icons.post_add_rounded,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

Future<Uint8List?> pickDocument() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ["jpg", "jpeg", 'png', 'pdf', 'doc', 'mp3', 'm4a'],
    allowMultiple: false,
  );

  if (result != null && result.files.isNotEmpty) {
    String fileExtension = result.files.first.extension!;
    Uint8List pictureBytes = result.files.first.bytes!;
    return pictureBytes;
  }
  return null;
}

class DocumentTypeDialog extends StatelessWidget {
  const DocumentTypeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 16,
      child: SizedBox(
        width: 80.w,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose Doucment Type",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.browse_gallery),
                        Text("Image"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context, 1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.camera),
                        Text("Camera"),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentDialog extends StatelessWidget {
  const DocumentDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 16,
      child: SizedBox(
        width: 80.w,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose Doucment with",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.browse_gallery),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context, 1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.camera),
                        Text("Camera"),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
