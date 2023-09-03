import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/general/network_globals.dart';
import 'package:userapp/general/utils_color/hex_color.dart';
import '../../../../general/utils_custom_icons/custom_icons_icons.dart';
import '../d_confirm_delete.dart';
import '../models/m_document.dart';
import '../u_profile_details.dart';
import 'document_edit.dart';

String getDocContTypeLabel(Document doc) {
  if (doc.contentType == 'image') {
    return 'PNG';
  } else if (doc.contentType == 'pdf') {
    return 'PDF';
  } else {
    return 'UDF';
  }
}

Color getDocContTypeColor(Document doc) {
  if (doc.contentType == 'image') {
    return HexColor("50C878");
  } else if (doc.contentType == 'pdf') {
    return HexColor("D2042D");
  } else {
    return HexColor("B2BEB5");
  }
}

class DocumentItem extends StatefulWidget {
  const DocumentItem({
    super.key,
    required this.document,
    required this.removeDocumentFromList,
    required this.docTypeKey,
    required this.reloadDocumentList,
  });

  final Document document;
  final String docTypeKey;
  final VoidCallback removeDocumentFromList;

  final VoidCallback reloadDocumentList;

  @override
  State<DocumentItem> createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
  void _showOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(CustomIcons.share_thin),
                title: const Text("Share"),
                onTap: () {
                  Navigator.pop(context);
                  Share.share(s3BaseUrl + widget.document.documentLink,
                      subject: 'Check out ${widget.document.documentName}');
                },
              ),
              ListTile(
                leading: const Icon(CustomIcons.edit),
                title: const Text("Edit"),
                onTap: () {
                  Navigator.pop(context);
                  // updateDocument
                  showDialog(
                    context: context,
                    builder: (context) => DocumentEditDialog(
                      document: widget.document,
                      docTypeKey: widget.docTypeKey,
                    ),
                  ).then(
                    (value) => widget.reloadDocumentList(),
                  );
                },
              ),
              ListTile(
                leading: const Icon(CustomIcons.delete),
                title: const Text("Delete Document"),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => const ConfirmDeleteDialog(
                      label: "Document",
                    ),
                  ).then((value) {
                    if (value != null) {
                      if (value == true) {
                        deleteDocument(widget.document).then(
                          (value) => widget.removeDocumentFromList(),
                        );
                      }
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        launchUrl(
          Uri.parse(s3BaseUrl + widget.document.documentLink),
        );
      },
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 6),
            Container(
              width: 50,
              height: 50,
              // margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: getDocContTypeColor(widget.document),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    Center(child: Text(getDocContTypeLabel(widget.document))),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.document.documentName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 16),
            VerticalDivider(
              endIndent: 6,
              indent: 6,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _showOptions(),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.more_vert,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}