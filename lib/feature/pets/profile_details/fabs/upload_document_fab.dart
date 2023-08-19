import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/widgets/custom_textformfield.dart';
import '../../../../general/utils_theme/custom_colors.dart';
import '../../../../general/utils_theme/custom_text_styles.dart';

class UploadDocumentFab extends StatelessWidget {
  const UploadDocumentFab({super.key, required this.addDocument});

  final Future<void> Function(Uint8List, String, String, String) addDocument;

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
        pickDocument().then((value) => {
              if (value != null)
                {
                  showDialog(
                    context: context,
                    builder: (_) => DocumentDialog(
                        pickedDocument: value, addDocument: addDocument),
                  )
                }
            });
      },
      child: Icon(
        Icons.post_add_rounded,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

Future<PickedDocument?> pickDocument() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    withData: true,
    type: FileType.custom,
    // allowedExtensions: ["jpg", "jpeg", 'png', 'pdf', 'doc', 'mp3', 'm4a'],
    allowedExtensions: ["jpg", "jpeg", 'png', 'pdf'],
    allowMultiple: false,
  );

  print("Result: " + result.toString());

  if (result != null && result.files.isNotEmpty) {
    String fileExtension = result.files.first.extension!;
    Uint8List fileBytes = result.files.first.bytes!;

    String fileName = result.files.first.name.split('.').first;
    print("File Name: " + fileName);
    return PickedDocument(fileExtension, fileBytes, fileName);
  }
  return null;
}

class PickedDocument {
  final String fileExtension;
  final String fileName;
  final Uint8List fileBytes;

  PickedDocument(this.fileExtension, this.fileBytes, this.fileName);
}

//Consider Dopng a new page insteat of a dialog, espeally for uploading waiting times
class DocumentDialog extends StatefulWidget {
  const DocumentDialog({
    super.key,
    required this.pickedDocument,
    required this.addDocument,
  });

  final PickedDocument pickedDocument;
  final Future<void> Function(Uint8List, String, String, String) addDocument;

  @override
  State<DocumentDialog> createState() => _DocumentDialogState();
}

class _DocumentDialogState extends State<DocumentDialog> {
  late DocumentType selectedUser;
  List<DocumentType> users = <DocumentType>[
    const DocumentType('allergies', 'Allergies'),
    const DocumentType('dewormers', 'dewormers'),
    const DocumentType('health', 'health'),
    const DocumentType('medicine', 'medicine'),
  ];

  @override
  void initState() {
    super.initState();
    selectedUser = users[0];
  }

  String getContentType() {
    print(widget.pickedDocument.fileExtension.toLowerCase());
    return widget.pickedDocument.fileExtension.toLowerCase() == 'pdf'
        ? 'pdf'
        : 'image';
  }

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
              Container(
                width: 70.h,
                alignment: Alignment.centerLeft,
                child: DropdownButton<DocumentType>(
                  focusColor: Colors.transparent,
                  value: selectedUser,
                  onChanged: (DocumentType? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedUser = newValue;
                      });
                    }
                  },
                  items: users.map((DocumentType user) {
                    return DropdownMenuItem<DocumentType>(
                      value: user,
                      child: Text(
                        user.value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
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
                    selectedUser.key,
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
                  style: getCustomTextStyles(context)
                      .dataEditDialogButtonSaveStyle,
                ),
              )
            ],
          ),
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
