import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import '../../language/d_translation_selection.dart';
import '../../language/m_language.dart';
import 'c_component_title.dart';
import 'd_confirm_delete.dart';
import 'models/m_important_information.dart';
import 'widgets/custom_textformfield.dart';

class PetImportantInformationComponent extends StatefulWidget {
  const PetImportantInformationComponent({
    super.key,
    required this.importantInformation,
    required this.petProfileId,
  });

  final List<ImportantInformation> importantInformation;
  final int petProfileId;

  @override
  State<PetImportantInformationComponent> createState() =>
      _PetImportantInformationComponentState();
}

class _PetImportantInformationComponentState
    extends State<PetImportantInformationComponent> {
  late Language _currentLanguage;

  // bool autofocus = false;

  // late List<FocusNode> focusNodes;
  final FocusNode _impInfoFocusNodes = FocusNode();
  final FocusNode _newImpInfoFocusNodes = FocusNode();

  // void generateFocusNodes() {
  //   focusNodes = List.generate(
  //       widget.importantInformation.length, (index) => FocusNode());
  // }

  @override
  void initState() {
    super.initState();
    if (widget.importantInformation.isNotEmpty) {
      //TODO check if default language is in
      _currentLanguage = widget.importantInformation.first.language;
    } else {
      //TODO check if default language is in
      _currentLanguage = Language('Deutsch', 'de', "", false);
    }
    // generateFocusNodes();
  }

  @override
  void dispose() {
    super.dispose();
    _impInfoFocusNodes.dispose();
    _newImpInfoFocusNodes.dispose();
  }

  ImportantInformation? getImportantInformationFromLanguage(Language language) {
    for (ImportantInformation info in widget.importantInformation) {
      if (info.language.languageKey == language.languageKey) {
        return info;
      }
    }
    return null;
  }

  Widget getImportantInformationWidget() {
    if (getImportantInformationFromLanguage(_currentLanguage) != null) {
      return ImportantInformationTranslation(
        //Key needed so the widget switch to other value
        key: ValueKey(_currentLanguage.languageKey),
        //Pass by reference
        importantInformation:
            getImportantInformationFromLanguage(_currentLanguage)!,
        removeImportantInformationFromList: () {
          setState(() {
            widget.importantInformation
                .remove(getImportantInformationFromLanguage(_currentLanguage)!);
            // autofocus = true;
          });
          // generateFocusNodes();
          // if (focusNodes.isNotEmpty) {
          //   focusNodes.last.requestFocus();
          // } else {
          //   newImpInfoFocusNodes.requestFocus();
          // }
          _newImpInfoFocusNodes.requestFocus();
        },
        focusNode: _impInfoFocusNodes,
        // autofocus: autofocus,
      );
    } else {
      return NewImportantInformationTranslation(
        petProfileId: widget.petProfileId,
        language: _currentLanguage,
        addNewImportantInformationInList: (description) {
          setState(() {
            widget.importantInformation.add(description);
            // autofocus = true;
          });
          // generateFocusNodes();
          // focusNodes.last.requestFocus();
          _impInfoFocusNodes.requestFocus();
        },
        focusNode: _newImpInfoFocusNodes,
        // autofocus: autofocus,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComponentTitle(
          text: "profileDetailsComponentTitleImportantInformation".tr(),
          suffix: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => TranslationPicker(
                  currentTranslation: _currentLanguage,
                  availableTranslations:
                      isolateLanguagesFromImportantInformation(
                          widget.importantInformation),
                ),
              ).then((value) {
                if (value is Language) {
                  setState(() {
                    _currentLanguage = value;
                  });
                }
              });
            },
            child: Container(
              width: 46,
              height: 32,
              color: Colors.redAccent,
              child: Text(_currentLanguage.languageLabel),
            ),
          ),
        ),
        getImportantInformationWidget(),
      ],
    );
  }
}

class ImportantInformationTranslation extends StatelessWidget {
  const ImportantInformationTranslation({
    super.key,
    required this.importantInformation,
    required this.removeImportantInformationFromList,
    required this.focusNode,
  });

  final ImportantInformation importantInformation;
  final VoidCallback removeImportantInformationFromList;
  // final bool autofocus;
  final FocusNode focusNode;

  void _updateImportantInformation() {
    EasyDebounce.debounce(
      'updateImportantInformation',
      const Duration(milliseconds: 250),
      () {
        if (importantInformation.text.isEmpty) {
          deleteImportantInformation(importantInformation)
              .then((value) => removeImportantInformationFromList());
        } else {
          upsertImportantInformation(importantInformation);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      // autofocus: autofocus,
      focusNode: focusNode,
      initialValue: importantInformation.text,
      hintText: "Enter ImportantInformation",
      maxLines: null,
      keyboardType: TextInputType.multiline,
      onChanged: (val) {
        importantInformation.text = val;
        _updateImportantInformation();
      },
      confirmDeleteDialog:
          const ConfirmDeleteDialog(label: "Important Information Translation"),
    );
  }
}

class NewImportantInformationTranslation extends StatelessWidget {
  const NewImportantInformationTranslation({
    super.key,
    required this.addNewImportantInformationInList,
    required this.language,
    required this.petProfileId,
    required this.focusNode,
  });

  final Function(ImportantInformation description)
      addNewImportantInformationInList;
  final Language language;
  final int petProfileId;
  // final bool autofocus;
  final FocusNode focusNode;

  void _addImportantInformation(String text) {
    EasyDebounce.debounce(
      'newImportantInformation',
      const Duration(milliseconds: 500),
      () {
        if (text.isNotEmpty) {
          ImportantInformation newImportantInformation =
              ImportantInformation(text, language, petProfileId);
          upsertImportantInformation(newImportantInformation).then((value) =>
              addNewImportantInformationInList(newImportantInformation));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      // autofocus: autofocus,
      focusNode: focusNode,
      hintText: "My Dog is Child friendly, loves to be kicked in his left ball",
      maxLines: null,
      keyboardType: TextInputType.multiline,
      onChanged: (value) {
        _addImportantInformation(value);
      },
    );
  }
}
