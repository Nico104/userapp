import 'package:flutter/material.dart';
import '../../../styles/custom_icons_icons.dart';
import '../d_confirm_delete.dart';
import '../models/m_document.dart';
import '../u_profile_details.dart';

class DocumentItem extends StatelessWidget {
  const DocumentItem({
    super.key,
    required this.document,
    required this.removeDocumentFromList,
  });

  final Document document;
  final VoidCallback removeDocumentFromList;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(document.documentName),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => const ConfirmDeleteDialog(label: "Document"),
            ).then((value) {
              if (value != null && value is bool) {
                if (value == true) {
                  deleteDocument(document)
                      .then((value) => removeDocumentFromList());
                }
              }
            });
          },
          icon: const Icon(CustomIcons.delete),
        ),
      ],
    );
  }
}
