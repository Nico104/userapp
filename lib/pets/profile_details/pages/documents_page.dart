import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/styles/custom_icons_icons.dart';
import '../c_component_padding.dart';
import '../c_component_title.dart';
import '../documents/documents_list_item.dart';
import '../models/m_document.dart';
import '../u_profile_details.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({
    super.key,
    required this.scrollController,
    required this.documents,
  });

  final List<Document> documents;
  final ScrollController scrollController;

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  List<Document> allergies = List.empty();

  List<Document> dewormers = List.empty();

  List<Document> health = List.empty();

  List<Document> medicine = List.empty();

  @override
  void initState() {
    super.initState();
    setDocumentCategories();
  }

  @override
  void didUpdateWidget(covariant DocumentsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    //Needed since docuemnts dont get accessed directly so updating it has effect
    setDocumentCategories();
  }

  void setDocumentCategories() {
    allergies = widget.documents
        .where((i) => i.documentLink.contains('allergies'))
        .toList();

    dewormers = widget.documents
        .where((i) => i.documentLink.contains('dewormers'))
        .toList();

    health = widget.documents
        .where((i) => i.documentLink.contains('health'))
        .toList();

    medicine = widget.documents
        .where((i) => i.documentLink.contains('medicine'))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appBarTitleProfileDetails'.tr()),
        scrolledUnderElevation: 8,
      ),
      body: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          key: const ValueKey("Documents"),
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 36),
            PaddingComponent(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 28),
                  const ComponentTitle(text: "Allergies"),
                  ListView.builder(
                    key: Key(allergies.length.toString()),
                    shrinkWrap: true,
                    itemCount: allergies.length,
                    itemBuilder: (context, index) {
                      return DocumentItem(
                        document: allergies.elementAt(index),
                        removeDocumentFromList: () {
                          setState(() {
                            allergies.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  const ComponentTitle(text: "Dewormers"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: dewormers.length,
                    itemBuilder: (context, index) {
                      return DocumentItem(
                        document: dewormers.elementAt(index),
                        removeDocumentFromList: () {
                          setState(() {
                            dewormers.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  const ComponentTitle(text: "Health"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: health.length,
                    itemBuilder: (context, index) {
                      return DocumentItem(
                        document: health.elementAt(index),
                        removeDocumentFromList: () {
                          setState(() {
                            health.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  const ComponentTitle(text: "Medicine"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: medicine.length,
                    itemBuilder: (context, index) {
                      return DocumentItem(
                        document: medicine.elementAt(index),
                        removeDocumentFromList: () {
                          setState(() {
                            medicine.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
