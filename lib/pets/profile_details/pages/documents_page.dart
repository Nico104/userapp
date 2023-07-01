import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../u_pets.dart';
import '../c_component_padding.dart';
import '../c_component_title.dart';
import '../documents/document_expansion_tile.dart';
import '../documents/documents_list_item.dart';
import '../models/m_document.dart';

class DocumentsTab extends StatefulWidget {
  const DocumentsTab({
    super.key,
    required this.initialDocuments,
    required this.petProfileId,
  });

  final List<Document> initialDocuments;
  final int petProfileId;

  @override
  State<DocumentsTab> createState() => _DocumentsTabState();
}

class _DocumentsTabState extends State<DocumentsTab> {
  List<Document> allergies = List.empty();
  List<Document> dewormers = List.empty();
  List<Document> health = List.empty();
  List<Document> medicine = List.empty();

  late List<Document> documents;

  @override
  void initState() {
    super.initState();
    documents = widget.initialDocuments;
    setDocumentCategories();
  }

  //TODO getDocuments
  Future<void> reloadDocuments() async {
    documents = await getPetDocuments(widget.petProfileId);
    setDocumentCategories();
    print("relaoded Docs");
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant DocumentsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    //Needed since docuemnts dont get accessed directly so updating it has effect
    documents = widget.initialDocuments;
    setDocumentCategories();
  }

  void setDocumentCategories() {
    allergies = documents
        .where((i) => i.documentType.toLowerCase() == 'allergies')
        .toList();

    dewormers = documents
        .where((i) => i.documentType.toLowerCase() == 'dewormers')
        .toList();

    health = documents
        .where((i) => i.documentType.toLowerCase() == 'health')
        .toList();

    medicine = documents
        .where((i) => i.documentType.toLowerCase() == 'medicine')
        .toList();
  }

  Widget getDocumentsList() {
    return ListView(
      children: [
        const SizedBox(height: 36),
        allergies.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DocumentExpansionTile(
                  docKey: 'allergies',
                  label: "Allergies",
                  documents: allergies,
                  reloadDocumentList: () => reloadDocuments(),
                  initiallyExpanded:
                      (dewormers.isEmpty && health.isEmpty && medicine.isEmpty),
                ),
              )
            : const SizedBox(),
        dewormers.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DocumentExpansionTile(
                  docKey: 'dewormers',
                  label: "Dewormers",
                  documents: dewormers,
                  reloadDocumentList: () => reloadDocuments(),
                  initiallyExpanded:
                      (allergies.isEmpty && health.isEmpty && medicine.isEmpty),
                ),
              )
            : const SizedBox(),
        health.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DocumentExpansionTile(
                  docKey: 'health',
                  label: "Health",
                  documents: health,
                  reloadDocumentList: () => reloadDocuments(),
                  initiallyExpanded: (allergies.isEmpty &&
                      dewormers.isEmpty &&
                      medicine.isEmpty),
                ),
              )
            : const SizedBox(),
        medicine.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DocumentExpansionTile(
                  docKey: 'medicine',
                  label: "Medicine",
                  documents: medicine,
                  reloadDocumentList: () => reloadDocuments(),
                  initiallyExpanded: (allergies.isEmpty &&
                      dewormers.isEmpty &&
                      health.isEmpty),
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 28),
      ],
    );
  }

  Widget getNoDocumetsWidget() {
    // return Text("Oops no dpcsuments");
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 120,
          ),
          SizedBox(
            width: 30.w,
            child: Image.asset("assets/tmp/documents.png"),
          ),
          const SizedBox(height: 32),
          Text(
            "No Docuemnts uploaded",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 32),
          Text(
            "Upload",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PaddingComponent(
      child: (allergies.isNotEmpty ||
              dewormers.isNotEmpty ||
              health.isNotEmpty ||
              medicine.isNotEmpty)
          ? getDocumentsList()
          : getNoDocumetsWidget(),
    );
  }
}
