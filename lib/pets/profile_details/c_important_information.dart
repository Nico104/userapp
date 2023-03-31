import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/models/m_description.dart';
import 'package:userapp/pets/profile_details/models/m_important_information.dart';
import 'package:userapp/styles/custom_icons_icons.dart';

import '../../language/m_language.dart';
import '../../styles/text_styles.dart';
import '../../theme/custom_colors.dart';
import 'c_component_title.dart';
import '../../language/c_language_selection.dart';
import 'widgets/custom_textformfield.dart';

class PetImportantInformation extends StatefulWidget {
  const PetImportantInformation({
    super.key,
    required this.imortantInformations,
    // required this.addDescription,
    // required this.removeDescription,
  });

  //Pictures
  final List<ImportantInformation> imortantInformations;

  @override
  State<PetImportantInformation> createState() =>
      _PetImportantInformationState();
}

class _PetImportantInformationState extends State<PetImportantInformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ComponentTitle(text: "Important Information"),
        ListView.builder(
          itemCount: widget.imortantInformations.length + 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index == widget.imortantInformations.length) {
              return NewImportantInformationTranslation(
                importantInformation: widget.imortantInformations,
                addImportantInformation: (text, language) {
                  setState(() {
                    widget.imortantInformations
                        .add(ImportantInformation(text, language));
                  });
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ImportantInformationTranslation(
                  //Pass by reference
                  importantInformation:
                      widget.imortantInformations.elementAt(index),
                  importantInformations: widget.imortantInformations,
                  index: index,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class ImportantInformationTranslation extends StatelessWidget {
  const ImportantInformationTranslation({
    super.key,
    required this.index,
    required this.importantInformation,
    required this.importantInformations,
  });

  final ImportantInformation importantInformation;
  final List<ImportantInformation> importantInformations;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomTextFormFieldActive(
            initialValue: importantInformation.text,
            hintText: "Enter Description",
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (val) {
              importantInformation.text = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => LanguagePickerDialogComponent(
                  excludeLanguageCodes:
                      isolateLanguageCodesFromImportantInformation(
                          importantInformations),
                ),
              ).then((value) {
                if (value != null) {
                  if (value is Language) {
                    importantInformation.language = value;
                  }
                }
              });
            },
            child: Container(
              height: 50,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: getCustomColors(context).lightBorder ??
                        Colors.transparent,
                    width: 1),
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/60"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )),
            ),
          ),
        )
      ],
    );
  }
}

class NewImportantInformationTranslation extends StatefulWidget {
  const NewImportantInformationTranslation({
    super.key,
    required this.addImportantInformation,
    required this.importantInformation,
  });

  final List<ImportantInformation> importantInformation;
  final Function(String text, Language language) addImportantInformation;

  @override
  State<NewImportantInformationTranslation> createState() =>
      _NewImportantInformationTranslationState();
}

class _NewImportantInformationTranslationState
    extends State<NewImportantInformationTranslation> {
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomTextFormFieldActive(
            hintText: "Enter Description",
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (val) {
              EasyDebounce.debounce(
                'newDescriptionTranslation',
                const Duration(milliseconds: 500),
                () {
                  setState(() {
                    _text = val;
                  });
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => LanguagePickerDialogComponent(
                  excludeLanguageCodes:
                      isolateLanguageCodesFromImportantInformation(
                          widget.importantInformation),
                ),
              ).then((value) {
                if (value != null) {
                  widget.addImportantInformation(_text, value);
                }
              });
            },
            child: Container(
              height: 50,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: getCustomColors(context).lightBorder ??
                      Colors.transparent,
                  width: 1,
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: const Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox.expand(
                  child: FittedBox(
                    child: Icon(CustomIcons.globe_5),
                  ),
                ),
              )),
            ),
          ),
        )
      ],
    );
  }
}
