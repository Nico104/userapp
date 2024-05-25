import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';

import '../../../../../../../general/widgets/custom_nico_modal.dart';
import '../../../../models/m_document.dart';
import '../../document_page/document_item/documents_list_item.dart';

class HealthIssueLinkDocumentSelection extends StatefulWidget {
  const HealthIssueLinkDocumentSelection(
      {super.key,
      required this.petProfileId,
      required this.documents,
      required this.healthIssueId});

  final int petProfileId;
  final List<Document> documents;
  final int healthIssueId;

  @override
  State<HealthIssueLinkDocumentSelection> createState() =>
      _HealthIssueLinkDocumentSelectionState();
}

class _HealthIssueLinkDocumentSelectionState
    extends State<HealthIssueLinkDocumentSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Link Document")),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              // title: Text("Link Document"),
              expandedHeight: 100,
              pinned: true,
              // automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: const SizedBox(height: 60),
                title: Text("healthIssue_linkDocument".tr()),
                centerTitle: true,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 22,
              ),
            ),
            SliverToBoxAdapter(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.documents.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showCustomNicoLoadingModalBottomSheet(
                        context: context,
                        future: linkDocumentToHealthIssue(widget.healthIssueId,
                            widget.documents.elementAt(index).documentId),
                        callback: (value) {
                          Navigator.pop(context, value);
                        },
                      );

                      // BuildContext? dialogContext;
                      // showModalBottomSheet(
                      //   context: context,
                      //   backgroundColor: Colors.transparent,
                      //   isDismissible: false,
                      //   builder: (buildContext) {
                      //     dialogContext = buildContext;
                      //     return Container(
                      //       margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                      //       padding: const EdgeInsets.all(16),
                      //       decoration: BoxDecoration(
                      //         color: Theme.of(context).primaryColor,
                      //         borderRadius: BorderRadius.circular(28),
                      //       ),
                      //       child: const SizedBox(
                      //         height: 60,
                      //         width: 60,
                      //         child: CustomLoadingIndicatior(),
                      //       ),
                      //     );
                      //   },
                      // );
                      // linkDocumentToHealthIssue(widget.healthIssueId,
                      //         widget.documents.elementAt(index).documentId)
                      //     .then((value) {
                      //   Navigator.pop(dialogContext!);
                      //   Navigator.pop(context, value);
                      // });
                    },
                    child: DocumentItemHealthIssue(
                      document: widget.documents.elementAt(index),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DocumentItemHealthIssue extends StatefulWidget {
  const DocumentItemHealthIssue({
    super.key,
    required this.document,
  });

  final Document document;

  @override
  State<DocumentItemHealthIssue> createState() =>
      _DocumentItemHealthIssueState();
}

class _DocumentItemHealthIssueState extends State<DocumentItemHealthIssue> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black, width: 0.2),
          ),
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
                    child: Center(
                        child: Text(getDocContTypeLabel(widget.document))),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
