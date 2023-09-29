import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/feature/language/language_selector.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/description_page/auto_translate_button.dart';
import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';
import 'package:userapp/general/utils_general.dart';

import '../../../../../../general/network_globals.dart';
import '../../../../../../general/utils_theme/custom_colors.dart';
import '../../../../../../general/widgets/auto_save_info.dart';
import '../../../../../auto_translate/u_auto_translate.dart';
import '../../../../../language/m_language.dart';
import '../../../d_confirm_delete.dart';
import '../../../g_profile_detail_globals.dart';
import '../../../models/m_description.dart';
import '../../../u_profile_details.dart';
import '../../../widgets/custom_textformfield.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage(
      {super.key, required this.descriptions, required this.petProfileId});

  final List<Description> descriptions;
  final int petProfileId;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  Language? _currentLanguage;

  final TextEditingController _textEditingController = TextEditingController();

  void _updateDescription(String text) {
    if (_currentLanguage != null) {
      EasyDebounce.debounce(
        'updateDescription+${_currentLanguage?.languageKey}',
        const Duration(milliseconds: 250),
        () {
          Description description =
              Description(text, _currentLanguage!, widget.petProfileId);
          // if (widget.descriptions.contains((element) =>
          //     element.language.languageKey == _currentLanguage!.languageKey)) {}
          if (widget.descriptions
              .where((element) =>
                  element.language.languageKey == _currentLanguage!.languageKey)
              .isNotEmpty) {
            widget.descriptions
                .singleWhere((element) =>
                    element.language.languageKey ==
                    _currentLanguage!.languageKey)
                .text = text;
          } else {
            setState(() {
              widget.descriptions.add(description);
            });
          }
          upsertDescription(description);
        },
      );
    }
  }

  void _setCurrentLanguage(Language? language) {
    setState(() {
      _currentLanguage = language;
    });
    if (_getCurrentDescription() != null) {
      _textEditingController.text = _getCurrentDescription()!.text;
    }
  }

  Description? _getCurrentDescription() {
    if (_currentLanguage != null &&
        widget.descriptions
            .where((element) =>
                element.language.languageKey == _currentLanguage!.languageKey)
            .isNotEmpty) {
      return widget.descriptions
          .where((element) =>
              element.language.languageKey == _currentLanguage!.languageKey)
          .first;
    } else {
      return null;
    }
  }

  void _removeDescriptionFromList(Description description) {
    setState(() {
      widget.descriptions.removeWhere((element) =>
          element.language.languageKey == description.language.languageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("descriptionPage_Description".tr()),
      ),
      // resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: TranslationSelectionRow(
              // languages: widget.descriptions,
              languages: isolateLanguagesFromDescription(widget.descriptions),
              currentLanguage: _currentLanguage,
              setCurrentLanguage: (p0) {
                // setState(() {
                //   _currentLanguage = p0;
                // });
                _setCurrentLanguage(p0);
              },
              returnChosenLanguage: (p0) {
                //Create New Description
                Description description =
                    Description("", p0, widget.petProfileId);
                upsertDescription(description);
                setState(() {
                  widget.descriptions.add(description);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "descriptionPage_DeutscheUbersetzung".tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text("What are Description Translations?"),
                  ],
                ),
                Spacer(),
                _currentLanguage != null
                    ? IgnorePointer(
                        ignoring: widget.descriptions.length < 2,
                        child: Opacity(
                          opacity: widget.descriptions.length < 2 ? 0.3 : 1,
                          child: AutoTranslateButton(
                            descriptions: widget.descriptions,
                            targetLanguage: _currentLanguage!,
                            returnTranslation: (translation) {
                              _textEditingController.text = translation;
                              _updateDescription(translation);
                            },
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(width: 8),
                IgnorePointer(
                  ignoring: _getCurrentDescription() == null,
                  child: Opacity(
                    opacity: _getCurrentDescription() == null ? 0.3 : 1,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => ConfirmDeleteDialog(
                            label:
                                "descriptionPage_whatAreDescriptionTranslations"
                                    .tr(),
                          ),
                        ).then(
                          (value) {
                            if (value != null) {
                              if (value == true) {
                                Description description =
                                    _getCurrentDescription()!;
                                deleteDescription(description).then((value) =>
                                    _removeDescriptionFromList(description));
                                _textEditingController.clear();
                                setState(() {
                                  _setCurrentLanguage(getLanguageFromKey(
                                      context.locale.toString())!);
                                });
                              }
                            }
                          },
                        );
                      },
                      icon: const Icon(CustomIcons.delete),
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
                // initialValue: _getCurrentDescription()?.text,
                textEditingController: _textEditingController,
                hintText: "descriptionPage_enterdescription".tr(),
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                autofocus: true,
                onChanged: (val) {
                  // description.text = val;
                  // _updateDescription();
                  _updateDescription(val);
                },
                // confirmDeleteDialog:
                //     const ConfirmDeleteDialog(label: "Description Translation"),
                showSuffix: false,
              ),
            ),
          ),
          const AutoSaveInfo(),
        ],
      ),
    );
  }
}

class TranslationSelectionRow extends StatefulWidget {
  const TranslationSelectionRow({
    super.key,
    required this.languages,
    required this.setCurrentLanguage,
    required this.returnChosenLanguage,
    required this.currentLanguage,
  });

  final List<Language> languages;
  final Function(Language?) setCurrentLanguage;
  final Function(Language) returnChosenLanguage;
  final Language? currentLanguage;

  @override
  State<TranslationSelectionRow> createState() =>
      _TranslationSelectionRowState();
}

class _TranslationSelectionRowState extends State<TranslationSelectionRow> {
  // Language? _currentLanguage;

  // void _setCurrentLanguage(Language language) {
  //   setState(() {
  //     _currentLanguage = language;
  //   });
  //   widget.setCurrentLanguage(language);
  // }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.languages.isNotEmpty) {
        widget.setCurrentLanguage(widget.languages.first);
      } else {
        widget
            .setCurrentLanguage(getLanguageFromKey(context.locale.toString())!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.languages.isNotEmpty) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.languages.length + 1,
        itemBuilder: (context, index) {
          if (index == widget.languages.length) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: AddNewTranslation(
                unavailableLanguages: widget.languages,
                returnChosenLanguage: widget.returnChosenLanguage,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
            child: GestureDetector(
              onTap: () {
                widget.setCurrentLanguage(widget.languages.elementAt(index));
              },
              child: KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
                  if (!isKeyboardVisible) {
                    return Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              widget.languages.elementAt(index).languageKey ==
                                      widget.currentLanguage?.languageKey
                                  ? Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    )
                                  : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: IntrinsicWidth(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      s3BaseUrl +
                                          widget.languages
                                              .elementAt(index)
                                              .languageImagePath,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    Text(
                                      widget.languages
                                          .elementAt(index)
                                          .languageLabel,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
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
                    );
                  } else {
                    return Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(4),
                      child: AspectRatio(
                        aspectRatio: 3 / 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border:
                                widget.languages.elementAt(index).languageKey ==
                                        widget.currentLanguage?.languageKey
                                    ? Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      )
                                    : null,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              s3BaseUrl +
                                  widget.languages
                                      .elementAt(index)
                                      .languageImagePath,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      );
    } else {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
            child: KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                print("Visible " + isKeyboardVisible.toString());
                if (!isKeyboardVisible) {
                  return Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: getLanguageFromKey(context.locale.toString())!
                                    .languageKey ==
                                widget.currentLanguage?.languageKey
                            ? Border.all(
                                color: Colors.black,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    s3BaseUrl +
                                        getLanguageFromKey(
                                                context.locale.toString())!
                                            .languageImagePath,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Text(
                                    getLanguageFromKey(
                                            context.locale.toString())!
                                        .languageLabel,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
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
                  );
                } else {
                  return Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(4),
                    child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: getLanguageFromKey(context.locale.toString())!
                                      .languageKey ==
                                  widget.currentLanguage?.languageKey
                              ? Border.all(
                                  color: Colors.black,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            s3BaseUrl +
                                getLanguageFromKey(context.locale.toString())!
                                    .languageImagePath,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
            child: AddNewTranslation(
              unavailableLanguages: widget.languages,
              returnChosenLanguage: widget.returnChosenLanguage,
            ),
          ),
        ],
      );
    }
  }
}

class AddNewTranslation extends StatelessWidget {
  const AddNewTranslation({
    super.key,
    required this.unavailableLanguages,
    required this.returnChosenLanguage,
  });

  final List<Language> unavailableLanguages;
  final Function(Language) returnChosenLanguage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LanguageSelector(
              unavailableLanguages: unavailableLanguages,
              availableLanguages: availableLanguages,
              title: "descriptionPage_chooseDescriptionLanguage".tr(),
            ),
          ),
        ).then((value) {
          if (value is Language) {
            returnChosenLanguage(value);
          }
        });
      },
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return AspectRatio(
          aspectRatio: isKeyboardVisible ? 1 : 2 / 3,
          child: Material(
            borderRadius: BorderRadius.circular(8),
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).primaryColor,
                border: Border.all(
                  width: 0.3,
                  color:
                      getCustomColors(context).hardBorder ?? Colors.transparent,
                  // strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

// class SelectNewTranslationLanguage extends StatefulWidget {
//   const SelectNewTranslationLanguage(
//       {super.key, required this.unavailableLanguages});

//   final List<Language> unavailableLanguages;

//   @override
//   State<SelectNewTranslationLanguage> createState() =>
//       _SelectNewTranslationLanguageState();
// }

// class _SelectNewTranslationLanguageState
//     extends State<SelectNewTranslationLanguage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Choose Description Language"),
//       ),
//       body: ListView.builder(
//         itemCount: availableLanguages.length,
//         itemBuilder: (context, index) {
//           bool available = !listContainsLanguage(
//             widget.unavailableLanguages,
//             availableLanguages.elementAt(index),
//           );
//           return Padding(
//             padding: const EdgeInsets.all(22),
//             child: Material(
//               elevation: 4,
//               borderRadius: BorderRadius.circular(16),
//               child: Opacity(
//                 opacity: available ? 1 : 0.34,
//                 child: IgnorePointer(
//                   ignoring: !available,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(
//                         context,
//                         availableLanguages.elementAt(index),
//                       );
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             AspectRatio(
//                               aspectRatio: 3 / 2,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(16),
//                                 child: Image.network(s3BaseUrl +
//                                     availableLanguages
//                                         .elementAt(index)
//                                         .languageImagePath),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 availableLanguages
//                                     .elementAt(index)
//                                     .languageLabel,
//                                 style: Theme.of(context).textTheme.titleMedium,
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
