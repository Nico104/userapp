import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/auto_translate/u_auto_translate.dart';

import '../../../../../../general/network_globals.dart';
import '../../../../../language/m_language.dart';
import '../../../models/m_description.dart';

class AutoTranslateDialog extends StatefulWidget {
  const AutoTranslateDialog({
    super.key,
    required this.descriptions,
    required this.targetLanguage,
  });

  final List<Description> descriptions;
  final Language targetLanguage;

  @override
  State<AutoTranslateDialog> createState() => _AutoTranslateDialogState();
}

class _AutoTranslateDialogState extends State<AutoTranslateDialog> {
  late List<Language> languages;

  @override
  void initState() {
    super.initState();
    languages = isolateLanguagesFromDescription(widget.descriptions);
    // languages = [];
  }

  double _width = 80.w;
  bool _showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: const Alignment(0, 0.85),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 16,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 125),
        width: _width,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 125),
            child: !_showLoading
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          "autoTranslateDialog_chooseWhichTranslationtoAutoTranslate"
                              .tr()),
                      const SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: languages.length,
                        itemBuilder: (context2, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IgnorePointer(
                              ignoring:
                                  languages.elementAt(index).languageKey ==
                                      widget.targetLanguage.languageKey,
                              child: Opacity(
                                opacity:
                                    languages.elementAt(index).languageKey ==
                                            widget.targetLanguage.languageKey
                                        ? 0.3
                                        : 1,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      _width = 40.w;
                                      _showLoading = true;
                                    });
                                    translateDeepL(
                                      target_lang:
                                          widget.targetLanguage.languageKey,
                                      source_lang: languages
                                          .elementAt(index)
                                          .languageKey,
                                      // text:
                                      //     widget.descriptions.elementAt(index).text,
                                      text: widget.descriptions
                                          .singleWhere((element) =>
                                              element.language.languageKey ==
                                              languages
                                                  .elementAt(index)
                                                  .languageKey)
                                          .text,
                                    ).then((value) =>
                                        Navigator.pop(context, value));
                                  },
                                  child: Row(
                                    children: [
                                      Spacer(flex: 1),
                                      Expanded(
                                        flex: 5,
                                        child: AspectRatio(
                                          aspectRatio: 3 / 2,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(s3BaseUrl +
                                                languages
                                                    .elementAt(index)
                                                    .languageImagePath),
                                          ),
                                        ),
                                      ),
                                      Spacer(flex: 10),
                                      Text(
                                        languages
                                            .elementAt(index)
                                            .languageLabel,
                                        style: Theme.of(context2)
                                            .textTheme
                                            .titleMedium,
                                        textAlign: TextAlign.left,
                                      ),
                                      Spacer(flex: 1),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
