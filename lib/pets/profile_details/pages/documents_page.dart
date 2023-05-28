import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import '../c_component_padding.dart';
import '../c_component_title.dart';
import '../documents/documents_list_item.dart';
import '../models/m_document.dart';

class DocumentsTab extends StatefulWidget {
  const DocumentsTab({
    super.key,
    required this.documents,
  });

  final List<Document> documents;

  @override
  State<DocumentsTab> createState() => _DocumentsTabState();
}

class _DocumentsTabState extends State<DocumentsTab> {
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
  void didUpdateWidget(covariant DocumentsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    //Needed since docuemnts dont get accessed directly so updating it has effect
    setDocumentCategories();
  }

  void setDocumentCategories() {
    // allergies = widget.documents
    //     .where((i) => i.documentLink.contains('allergies'))
    //     .toList();

    // dewormers = widget.documents
    //     .where((i) => i.documentLink.contains('dewormers'))
    //     .toList();

    // health = widget.documents
    //     .where((i) => i.documentLink.contains('health'))
    //     .toList();

    // medicine = widget.documents
    //     .where((i) => i.documentLink.contains('medicine'))
    //     .toList();

    allergies = widget.documents
        .where((i) => i.documentType.toLowerCase() == 'allergies')
        .toList();

    dewormers = widget.documents
        .where((i) => i.documentType.toLowerCase() == 'dewormers')
        .toList();

    health = widget.documents
        .where((i) => i.documentType.toLowerCase() == 'health')
        .toList();

    medicine = widget.documents
        .where((i) => i.documentType.toLowerCase() == 'medicine')
        .toList();
  }

  int? _acitveTile;

  bool _isExpanded(int index) {
    if (_acitveTile != null && _acitveTile == index) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        key: const ValueKey("Documents"),
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 36),
          PaddingComponent(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const SizedBox(height: 28),
                // const ComponentTitle(text: "Allergies"),
                // ListView.builder(
                //   key: Key(allergies.length.toString()),
                //   shrinkWrap: true,
                //   itemCount: allergies.length,
                //   itemBuilder: (context, index) {
                //     return DocumentItem(
                //       document: allergies.elementAt(index),
                //       removeDocumentFromList: () {
                //         setState(() {
                //           allergies.removeAt(index);
                //         });
                //       },
                //     );
                //   },
                // ),
                // ExpansionTileCard(
                //   title: Text("Allergies"),
                //   children: List<Widget>.generate(
                //     allergies.length,
                //     (index) => DocumentItem(
                //       document: allergies.elementAt(index),
                //       removeDocumentFromList: () {
                //         setState(
                //           () {
                //             allergies.removeAt(index);
                //           },
                //         );
                //       },
                //     ),
                //   ),
                // ),
                Material(
                  borderRadius: BorderRadius.circular(14),
                  elevation: _isExpanded(0) ? 8 : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: const EdgeInsets.all(12),
                    // margin: const EdgeInsets.all(16),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        // key: PageStorageKey(
                        //     "${DateTime.now().millisecondsSinceEpoch}"),
                        // initiallyExpanded: _isExpanded(0),
                        title: const Text(
                          "Allergies",
                          style: TextStyle(color: Colors.black),
                        ),
                        // childrenPadding:
                        //     const EdgeInsets.fromLTRB(8, 16, 8, 16),
                        children: List<Widget>.generate(
                          allergies.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DocumentItem(
                              document: allergies.elementAt(index),
                              docTypeKey: 'allergies',
                              removeDocumentFromList: () {
                                setState(
                                  () {
                                    allergies.removeAt(index);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        onExpansionChanged: (value) {
                          if (value) {
                            setState(() {
                              _acitveTile = 0;
                            });
                          } else {
                            setState(() {
                              _acitveTile = null;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // ExpansionTile(
                //   title: const Text("Dewormers"),
                //   children: List<Widget>.generate(
                //     dewormers.length,
                //     (index) => DocumentItem(
                //       document: dewormers.elementAt(index),
                //       removeDocumentFromList: () {
                //         setState(
                //           () {
                //             dewormers.removeAt(index);
                //           },
                //         );
                //       },
                //     ),
                //   ),
                // ),
                Material(
                  borderRadius: BorderRadius.circular(14),
                  elevation: _isExpanded(1) ? 8 : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: const EdgeInsets.all(12),
                    // margin: const EdgeInsets.all(16),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        // key: PageStorageKey(
                        //     "${DateTime.now().millisecondsSinceEpoch}"),
                        // initiallyExpanded: _isExpanded(1),
                        title: const Text(
                          "Dewormers",
                          style: TextStyle(color: Colors.black),
                        ),
                        // childrenPadding:
                        //     const EdgeInsets.fromLTRB(8, 16, 8, 16),
                        children: List<Widget>.generate(
                          dewormers.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DocumentItem(
                              document: dewormers.elementAt(index),
                              docTypeKey: 'dewormers',
                              removeDocumentFromList: () {
                                setState(
                                  () {
                                    dewormers.removeAt(index);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        onExpansionChanged: (value) {
                          if (value) {
                            setState(() {
                              _acitveTile = 1;
                            });
                          } else {
                            setState(() {
                              _acitveTile = null;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // ExpansionTile(
                //   title: const Text("Health"),
                //   children: List<Widget>.generate(
                //     health.length,
                //     (index) => DocumentItem(
                //       document: health.elementAt(index),
                //       removeDocumentFromList: () {
                //         setState(
                //           () {
                //             health.removeAt(index);
                //           },
                //         );
                //       },
                //     ),
                //   ),
                // ),
                Material(
                  borderRadius: BorderRadius.circular(14),
                  elevation: _isExpanded(2) ? 8 : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: const EdgeInsets.all(12),
                    // margin: const EdgeInsets.all(16),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        // key: PageStorageKey(
                        //     "${DateTime.now().millisecondsSinceEpoch}"),
                        // initiallyExpanded: _isExpanded(2),
                        title: const Text(
                          "Health",
                          style: TextStyle(color: Colors.black),
                        ),
                        // childrenPadding:
                        //     const EdgeInsets.fromLTRB(8, 16, 8, 16),
                        children: List<Widget>.generate(
                          health.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DocumentItem(
                              document: health.elementAt(index),
                              docTypeKey: 'health',
                              removeDocumentFromList: () {
                                setState(
                                  () {
                                    health.removeAt(index);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        onExpansionChanged: (value) {
                          if (value) {
                            setState(() {
                              _acitveTile = 2;
                            });
                          } else {
                            setState(() {
                              _acitveTile = null;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // ExpansionTile(
                //   title: const Text("Medicine"),
                //   children: List<Widget>.generate(
                //     medicine.length,
                //     (index) => DocumentItem(
                //       document: medicine.elementAt(index),
                //       removeDocumentFromList: () {
                //         setState(
                //           () {
                //             medicine.removeAt(index);
                //           },
                //         );
                //       },
                //     ),
                //   ),
                // ),
                Material(
                  borderRadius: BorderRadius.circular(14),
                  elevation: _isExpanded(3) ? 8 : 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: const EdgeInsets.all(12),
                    // margin: const EdgeInsets.all(16),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        // key: PageStorageKey(
                        //     "${DateTime.now().millisecondsSinceEpoch}"),
                        // initiallyExpanded: _isExpanded(3),
                        title: const Text(
                          "Medicine",
                          style: TextStyle(color: Colors.black),
                        ),
                        // childrenPadding:
                        //     const EdgeInsets.fromLTRB(8, 16, 8, 16),
                        children: List<Widget>.generate(
                          medicine.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DocumentItem(
                              document: medicine.elementAt(index),
                              docTypeKey: 'medicine',
                              removeDocumentFromList: () {
                                setState(
                                  () {
                                    medicine.removeAt(index);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        onExpansionChanged: (value) {
                          if (value) {
                            setState(() {
                              _acitveTile = 3;
                            });
                          } else {
                            setState(() {
                              _acitveTile = null;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),
                // const ComponentTitle(text: "Dewormers"),
                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: dewormers.length,
                //   itemBuilder: (context, index) {
                //     return DocumentItem(
                //       document: dewormers.elementAt(index),
                //       removeDocumentFromList: () {
                //         setState(() {
                //           dewormers.removeAt(index);
                //         });
                //       },
                //     );
                //   },
                // ),
                // const SizedBox(height: 28),
                // const ComponentTitle(text: "Health"),
                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: health.length,
                //   itemBuilder: (context, index) {
                //     return DocumentItem(
                //       document: health.elementAt(index),
                //       removeDocumentFromList: () {
                //         setState(() {
                //           health.removeAt(index);
                //         });
                //       },
                //     );
                //   },
                // ),
                // const SizedBox(height: 28),
                // const ComponentTitle(text: "Medicine"),
                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: medicine.length,
                //   itemBuilder: (context, index) {
                //     return DocumentItem(
                //       document: medicine.elementAt(index),
                //       removeDocumentFromList: () {
                //         setState(() {
                //           medicine.removeAt(index);
                //         });
                //       },
                //     );
                //   },
                // ),
                // const SizedBox(height: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
