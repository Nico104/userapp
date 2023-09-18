import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../general/utils_theme/custom_colors.dart';
import '../../../../../../../general/utils_theme/custom_text_styles.dart';
import '../../../../models/m_document.dart';
import '../../../../u_profile_details.dart';
import '../../../../widgets/custom_textformfield.dart';
import 'package:easy_debounce/easy_debounce.dart';

class DocumentEditDialog extends StatefulWidget {
  const DocumentEditDialog({
    super.key,
    required this.document,
  });

  final Document document;

  @override
  State<DocumentEditDialog> createState() => _DocumentEditDialogState();
}

class _DocumentEditDialogState extends State<DocumentEditDialog> {
  // late DocumentType selectedDocType;
  // List<DocumentType> docTypes = <DocumentType>[
  //   const DocumentType('allergies', 'Allergies'),
  //   const DocumentType('dewormers', 'dewormers'),
  //   const DocumentType('health', 'health'),
  //   const DocumentType('medicine', 'medicine'),
  // ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _docNameController;

  @override
  void initState() {
    super.initState();
    // selectedDocType =
    //     docTypes.where((element) => element.key == widget.docTypeKey).first;
    _docNameController =
        TextEditingController(text: widget.document.documentName);
  }

  Widget _getDocPreview() {
    if (widget.document.contentType == 'image') {
      return Image.network(widget.document.documentLink);
    } else if (widget.document.contentType == 'pdf') {
      return Text("pdf document");
    } else {
      return Text("undefined documenttype");
    }
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Upload Doucment",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 28),
                _getDocPreview(),
                const SizedBox(height: 28),
                CustomTextFormField(
                  textEditingController: _docNameController,
                  labelText: "Document Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'textInputErrorEmpty'.tr();
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 28),
                OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateDocument(
                        documentId: widget.document.documentId,
                        documentName: _docNameController.text,
                        documentType: "",
                      ).then((value) => Navigator.pop(context));
                    }
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
                    "Save",
                    style: getCustomTextStyles(context)
                        .dataEditDialogButtonSaveStyle,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
