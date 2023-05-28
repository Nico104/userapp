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
        Flexible(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: const Text("cont"),
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            document.documentName,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        VerticalDivider(
          endIndent: 6,
          indent: 6,
          color: Colors.grey,
        ),
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert),
          ),
        ),
        // IconButton(
        //   onPressed: () {
        //     showDialog(
        //       context: context,
        //       builder: (_) => const ConfirmDeleteDialog(label: "Document"),
        //     ).then((value) {
        //       if (value != null && value is bool) {
        //         if (value == true) {
        //           deleteDocument(document)
        //               .then((value) => removeDocumentFromList());
        //         }
        //       }
        //     });
        //   },
        //   icon: const Icon(CustomIcons.delete),
        // ),
      ],
    );
  }
}
