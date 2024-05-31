import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:userapp/feature/language/language_selector.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/description_page/auto_translate_button.dart';
import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';

import '../../../../../../general/network_globals.dart';
import '../../../../../../general/utils_theme/custom_colors.dart';
import '../../../../../../general/widgets/auto_save_info.dart';
import '../../../../../language/m_language.dart';
import '../../../d_confirm_delete.dart';
import '../../../g_profile_detail_globals.dart';
import '../../../models/m_description.dart';
import '../../../u_profile_details.dart';
import '../../../widgets/custom_textformfield.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key, required this.petProfileDetails});

  // final List<Description> descriptions;
  // final int petProfileId;
  final PetProfileDetails petProfileDetails;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  Language? _currentLanguage;

  final TextEditingController _textEditingController = TextEditingController();

  void _updateDescription(String text) {
    // if (_currentLanguage != null) {
    //   EasyDebounce.debounce(
    //     'updateDescription+${_currentLanguage?.languageKey}',
    //     const Duration(milliseconds: 250),
    //     () {
    //       Description description =
    //           Description(text, _currentLanguage!, widget.petProfileId);
    //       // if (widget.descriptions.contains((element) =>
    //       //     element.language.languageKey == _currentLanguage!.languageKey)) {}
    //       if (widget.descriptions
    //           .where((element) =>
    //               element.language.languageKey == _currentLanguage!.languageKey)
    //           .isNotEmpty) {
    //         widget.descriptions
    //             .singleWhere((element) =>
    //                 element.language.languageKey ==
    //                 _currentLanguage!.languageKey)
    //             .text = text;
    //       } else {
    //         setState(() {
    //           widget.descriptions.add(description);
    //         });
    //       }
    //       upsertDescription(description);
    //     },
    //   );
    // }

    EasyDebounce.debounce(
      'updateDescription',
      const Duration(milliseconds: 250),
      () {
        setState(() {
          widget.petProfileDetails.description = text;
        });
        updatePetProfileCore(widget.petProfileDetails);
      },
    );
  }

  // void _setCurrentLanguage(Language? language) {
  //   setState(() {
  //     _currentLanguage = language;
  //   });
  //   if (_getCurrentDescription() != null) {
  //     _textEditingController.text = _getCurrentDescription()!.text;
  //   }
  // }

  // Description? _getCurrentDescription() {
  //   if (_currentLanguage != null &&
  //       widget.descriptions
  //           .where((element) =>
  //               element.language.languageKey == _currentLanguage!.languageKey)
  //           .isNotEmpty) {
  //     return widget.descriptions
  //         .where((element) =>
  //             element.language.languageKey == _currentLanguage!.languageKey)
  //         .first;
  //   } else {
  //     return null;
  //   }
  // }

  // void _removeDescriptionFromList(Description description) {
  //   setState(() {
  //     widget.descriptions.removeWhere((element) =>
  //         element.language.languageKey == description.language.languageKey);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.petProfileDetails.description;
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
                                    const Spacer(),
                                    Text(
                                      widget.languages
                                          .elementAt(index)
                                          .languageLabel,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                      textAlign: TextAlign.left,
                                    ),
                                    const Spacer(),
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
                print("Visible $isKeyboardVisible");
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
                                  const Spacer(),
                                  Text(
                                    getLanguageFromKey(
                                            context.locale.toString())!
                                        .languageLabel,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                    textAlign: TextAlign.left,
                                  ),
                                  const Spacer(),
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
              child: const Center(
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
