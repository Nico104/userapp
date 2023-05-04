import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../c_component_padding.dart';
import '../c_component_title.dart';
import '../c_one_line_simple_input.dart';
import '../c_phone_number.dart';
import '../c_social_media.dart';
import '../models/m_document.dart';
import '../models/m_pet_profile.dart';
import '../u_profile_details.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({
    super.key,
    required this.petProfileDetails,
    required this.scrollController,
  });

  final PetProfileDetails petProfileDetails;
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

    List<Document> allergies = widget.petProfileDetails.petDocuments
        .where((i) => i.documentLink.contains('allergies'))
        .toList();

    List<Document> dewormers = widget.petProfileDetails.petDocuments
        .where((i) => i.documentLink.contains('dewormers'))
        .toList();

    List<Document> health = widget.petProfileDetails.petDocuments
        .where((i) => i.documentLink.contains('health'))
        .toList();

    List<Document> medicine = widget.petProfileDetails.petDocuments
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
            PaddingComponent(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 28),
                  const ComponentTitle(text: "Allergies"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: allergies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(allergies.elementAt(index).documentName),
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  const ComponentTitle(text: "Dewormers"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: dewormers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(dewormers.elementAt(index).documentName),
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  const ComponentTitle(text: "Health"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: health.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(health.elementAt(index).documentName),
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  const ComponentTitle(text: "Medicine"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: medicine.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(medicine.elementAt(index).documentName),
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
