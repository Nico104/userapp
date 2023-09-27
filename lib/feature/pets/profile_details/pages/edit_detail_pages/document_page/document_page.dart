import 'dart:typed_data';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/document_page/document_item/documents_list_item.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/document_page/upload_document/upload_document_page.dart';
import 'package:userapp/feature/pets/profile_details/widgets/shy_button.dart';

import '../../../../../../general/utils_general.dart';
import '../../../../../../general/widgets/custom_scroll_view.dart';
import '../../../../u_pets.dart';
import '../../../models/m_document.dart';
import '../../../pictures/upload_picture_dialog.dart';
import '../../../u_profile_details.dart';
import '../../../../../../general/widgets/custom_flexible_space_bar.dart';

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
  bool _showShyButton = true;

  @override
  void initState() {
    super.initState();
    documents = widget.initialDocuments;
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
        const SizedBox(height: 32), // UploadDocumentButton(
        //   showUploadButton: _showUploadButton,
        //   profileId: widget.petProfileId,
        //   reloadDocuments: reloadDocuments,
        // ),
        ShyButton(
          showUploadButton: _showShyButton,
          label: "Upload Document",
          onTap: () => _uploadDocument(),
          icon: Icon(
            Icons.file_upload_rounded,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  void _uploadDocument() {
    pickDocument().then((value) => {
          if (value != null)
            {
              navigatePerSlide(
                context,
                DocumentUploadPage(
                  pickedDocument: value,
                  addDocument: (value, filename, contentType) async {
                    // Loading Dialog Thingy
                    BuildContext? dialogContext;
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        dialogContext = context;
                        return const UploadPictureDialog();
                      },
                    );
                    await uploadDocuments(
                      widget.petProfileId,
                      value,
                      filename,
                      contentType,
                      () async {
                        // widget.reloadFuture.call();
                        //hekps against 403 from server
                        await Future.delayed(const Duration(milliseconds: 2000))
                            .then((value) => reloadDocuments());
                        //Close Loading Dialog Thingy
                        Navigator.pop(dialogContext!);
                      },
                    );
                  },
                ),
              )
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomNicoScrollView(
            // onScroll: _handleNavBarShown,
            onScroll: () => handleShyButtonShown(
              setShowShyButton: (p0) {
                setState(() {
                  _showShyButton = p0;
                });
              },
            ),
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
          ShyButton(
            showUploadButton: _showShyButton,
            label: "Upload Document",
            onTap: () => _uploadDocument(),
            icon: Icon(
              Icons.file_upload_rounded,
              color: Colors.white,
            ),
          ),
        ],
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
