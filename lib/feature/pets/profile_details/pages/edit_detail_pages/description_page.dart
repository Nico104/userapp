import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../general/network_globals.dart';
import '../../../../language/m_language.dart';
import '../../d_confirm_delete.dart';
import '../../models/m_description.dart';
import '../../widgets/custom_textformfield.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage(
      {super.key, required this.descriptions, required this.petProfileId});

  final List<Description> descriptions;
  final int petProfileId;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    print(getLanguageFromKey(context.locale.toString()));
    return Scaffold(
      appBar: AppBar(
        title: Text("Description"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: isolateLanguagesFromDescription(widget.descriptions)
                    .isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        isolateLanguagesFromDescription(widget.descriptions)
                                .length +
                            1,
                    itemBuilder: (context, index) {
                      if (index ==
                          isolateLanguagesFromDescription(widget.descriptions)
                              .length) {
                        return Container(
                          child: Text(
                            "Add Language",
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // context.setLocale(Locale(availableLanguages
                                //     .elementAt(index)
                                //     .languageKey));
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: IntrinsicWidth(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            s3BaseUrl +
                                                isolateLanguagesFromDescription(
                                                        widget.descriptions)
                                                    .elementAt(index)
                                                    .languageImagePath,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Spacer(),
                                          Text(
                                            isolateLanguagesFromDescription(
                                                    widget.descriptions)
                                                .elementAt(index)
                                                .languageLabel,
                                            style: GoogleFonts.openSans(
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // context.setLocale(Locale(availableLanguages
                                //     .elementAt(index)
                                //     .languageKey));
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: IntrinsicWidth(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            s3BaseUrl +
                                                getLanguageFromKey(context
                                                        .locale
                                                        .toString())!
                                                    .languageImagePath,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Spacer(),
                                          Text(
                                            getLanguageFromKey(
                                                    context.locale.toString())!
                                                .languageLabel,
                                            style: GoogleFonts.openSans(
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
                        child: AspectRatio(
                          aspectRatio: 2 / 3,
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            elevation: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextFormField(
                // focusNode: focusNode,
                // initialValue: description.text,
                hintText: "Enter Description",
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                autofocus: true,
                onChanged: (val) {
                  // description.text = val;
                  // _updateDescription();
                },
                confirmDeleteDialog:
                    const ConfirmDeleteDialog(label: "Description Translation"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
