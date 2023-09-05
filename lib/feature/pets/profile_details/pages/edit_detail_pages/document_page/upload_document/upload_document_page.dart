import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/document_page/upload_document/upload_document_button.dart';

import '../../../../../../../general/utils_theme/custom_colors.dart';
import '../../../../../../../general/utils_theme/custom_text_styles.dart';
import '../../../../fabs/upload_document_fab.dart';
import '../../../../widgets/custom_textformfield.dart';

//Consider Dopng a new page insteat of a dialog, espeally for uploading waiting times
class DocumentUploadPage extends StatefulWidget {
  const DocumentUploadPage({
    super.key,
    required this.pickedDocument,
    required this.addDocument,
  });

  final PickedDocument pickedDocument;
  final Future<void> Function(Uint8List, String, String) addDocument;

  @override
  State<DocumentUploadPage> createState() => _DocumentUploadPageState();
}

class _DocumentUploadPageState extends State<DocumentUploadPage> {
  String getContentType() {
    print(widget.pickedDocument.fileExtension.toLowerCase());
    return widget.pickedDocument.fileExtension.toLowerCase() == 'pdf'
        ? 'pdf'
        : 'image';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload new Document"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Upload Doucment",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 28),
            getContentType() != 'pdf'
                ? Image.memory(widget.pickedDocument.fileBytes)
                : Text("pdf document"),
            const SizedBox(height: 28),
            CustomTextFormField(
              initialValue: widget.pickedDocument.fileName,
              labelText: "Document Name",
            ),
            const SizedBox(height: 28),
            OutlinedButton(
              onPressed: () {
                // widget
                //     .addDocument(
                //       widget.pickedDocument.fileBytes,
                //       widget.pickedDocument.fileName,
                //       selectedUser.key,
                //       getContentType(),
                //     )
                //     .then((value) => Navigator.pop(context));
                Navigator.pop(context);
                widget.addDocument(
                  widget.pickedDocument.fileBytes,
                  widget.pickedDocument.fileName,
                  getContentType(),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                backgroundColor: getCustomColors(context).accent,
                side: BorderSide(
                  width: 0.5,
                  color: getCustomColors(context).lightBorder ??
                      Colors.transparent,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Upload",
                style:
                    getCustomTextStyles(context).dataEditDialogButtonSaveStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DocumentType {
  const DocumentType(this.key, this.value);

  final String value;
  final String key;
}
