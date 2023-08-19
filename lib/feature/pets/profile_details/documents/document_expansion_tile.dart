import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/models/m_document.dart';

import 'documents_list_item.dart';

class DocumentExpansionTile extends StatefulWidget {
  const DocumentExpansionTile({
    super.key,
    required this.label,
    required this.docKey,
    required this.documents,
    required this.reloadDocumentList,
    this.initiallyExpanded = false,
  });

  final String label;
  final String docKey;
  final List<Document> documents;
  final bool initiallyExpanded;

  final VoidCallback reloadDocumentList;

  @override
  State<DocumentExpansionTile> createState() => _DocumentExpansionTileState();
}

class _DocumentExpansionTileState extends State<DocumentExpansionTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  List<Widget> getChildren() {
    if (widget.documents.isEmpty) {
      return [
        Center(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text("No Documents regarding ${widget.label} uploaded"),
        )),
      ];
    }
    return List<Widget>.generate(
      widget.documents.length,
      (index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: DocumentItem(
          document: widget.documents.elementAt(index),
          // docTypeKey: 'allergies',
          docTypeKey: widget.docKey,
          removeDocumentFromList: () {
            setState(
              () {
                widget.documents.removeAt(index);
              },
            );
          },
          reloadDocumentList: widget.reloadDocumentList,
        ),
      ),
    );
  }

  String getDocumentCount() {
    if (widget.documents.length > 1) {
      return "${widget.documents.length} Documents";
    } else {
      return "${widget.documents.length} Document";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14),
      elevation: _isExpanded ? 8 : 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Theme.of(context).primaryColor,
        ),
        padding: const EdgeInsets.all(12),
        // margin: const EdgeInsets.all(16),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              widget.label,
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(getDocumentCount()),
            onExpansionChanged: (value) async {
              if (value) {
                setState(() {
                  _isExpanded = true;
                });
              } else {
                setState(() {
                  _isExpanded = false;
                });
              }
            },
            initiallyExpanded: widget.initiallyExpanded,
            children: getChildren(),
          ),
        ),
      ),
    );
  }
}
