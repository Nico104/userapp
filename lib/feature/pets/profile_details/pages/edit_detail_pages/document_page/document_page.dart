import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/document_page/document_item/documents_list_item.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/document_page/upload_document/upload_document_button.dart';

import '../../../../../../general/widgets/custom_scroll_view.dart';
import '../../../../u_pets.dart';
import '../../../models/m_document.dart';
import '../../custom_flexible_space_bar.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({
    super.key,
    required this.initialDocuments,
    required this.petProfileId,
  });

  final List<Document> initialDocuments;
  final int petProfileId;

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  late List<Document> documents;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    documents = widget.initialDocuments;
    _scrollController.addListener(() {
      _handleNavBarShown();
    });
  }

  //TODO getDocuments
  Future<void> reloadDocuments() async {
    documents = await getPetDocuments(widget.petProfileId);
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant DocumentPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    //Needed since docuemnts dont get accessed directly so updating it has effect
    documents = widget.initialDocuments;
  }

  bool _showUploadButton = true;

  void _handleNavBarShown() {
    //hideBar
    setState(() {
      _showUploadButton = false;
    });
    EasyDebounce.debounce(
      'handleUploadDocuemntBarShown',
      const Duration(milliseconds: 250),
      () {
        //shwoNavbar
        setState(() {
          _showUploadButton = true;
        });
      },
    );
  }

  Widget getNoDocumetsWidget() {
    return Column(
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
          "No Documents yet",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 32),
        UploadDocumentButton(
          showUploadButton: _showUploadButton,
          profileId: widget.petProfileId,
          reloadDocuments: reloadDocuments,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (documents.isEmpty) {
      return getNoDocumetsWidget();
    }
    return Scaffold(
      body: Stack(
        children: [
          CustomNicoScrollView(
            onScroll: _handleNavBarShown,
            title: Text("Tabos Docuemnts"),
            body: Column(
              children: [
                const SizedBox(height: 16),
                documents.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          return DocumentItem(
                            document: documents.elementAt(index),
                            removeDocumentFromList: () {
                              setState(
                                () {
                                  documents.removeAt(index);
                                },
                              );
                            },
                            reloadDocumentList: reloadDocuments,
                          );
                        },
                      )
                    : getNoDocumetsWidget(),
                SizedBox(height: 90.h),
              ],
            ),
          ),
          //UploadButton
          UploadDocumentButton(
            showUploadButton: _showUploadButton,
            profileId: widget.petProfileId,
            reloadDocuments: reloadDocuments,
          ),
        ],
      ),
    );
  }
}
