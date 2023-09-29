// import 'package:easy_debounce/easy_debounce.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:userapp/feature/pets/profile_details/models/m_description.dart';
// import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
// import '../../language/d_translation_selection.dart';
// import '../../language/m_language.dart';
// import 'c_component_title.dart';
// import 'd_confirm_delete.dart';
// import 'widgets/custom_textformfield.dart';

// class PetDescriptionComponent extends StatefulWidget {
//   const PetDescriptionComponent({
//     super.key,
//     required this.descriptions,
//     required this.petProfileId,
//   });

//   final List<Description> descriptions;
//   final int petProfileId;

//   @override
//   State<PetDescriptionComponent> createState() =>
//       _PetDescriptionComponentState();
// }

// class _PetDescriptionComponentState extends State<PetDescriptionComponent> {
//   late Language _currentLanguage;

//   final FocusNode _descFocusNodes = FocusNode();
//   final FocusNode _newDescFocusNodes = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.descriptions.isNotEmpty) {
//       //TODO check if default language is in
//       _currentLanguage = widget.descriptions.first.language;
//     } else {
//       //TODO check if default language is in
//       _currentLanguage = Language('Deutsch', 'de', "d", false);
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _descFocusNodes.dispose();
//     _newDescFocusNodes.dispose();
//   }

//   Description? getDescriptionFromLanguage(Language language) {
//     for (Description description in widget.descriptions) {
//       if (description.language.languageKey == language.languageKey) {
//         return description;
//       }
//     }
//     return null;
//   }

//   Widget getDescriptionWidget() {
//     if (getDescriptionFromLanguage(_currentLanguage) != null) {
//       return DescriptionTranslation(
//         //Key needed so the widget switch to other value
//         key: ValueKey(_currentLanguage.languageKey),
//         //Pass by reference
//         description: getDescriptionFromLanguage(_currentLanguage)!,
//         removeDescriptionFromList: () {
//           setState(() {
//             widget.descriptions
//                 .remove(getDescriptionFromLanguage(_currentLanguage)!);
//           });
//           _newDescFocusNodes.requestFocus();
//         },
//         focusNode: _descFocusNodes,
//       );
//     } else {
//       return NewDescriptionTranslation(
//         petProfileId: widget.petProfileId,
//         language: _currentLanguage,
//         addNewDescriptionInList: (description) {
//           setState(() {
//             widget.descriptions.add(description);
//           });
//           _descFocusNodes.requestFocus();
//         },
//         focusNode: _newDescFocusNodes,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ComponentTitle(
//           text: "profileDetailsComponentTitleDescription".tr(),
//           suffix: GestureDetector(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (_) => TranslationPicker(
//                   currentTranslation: _currentLanguage,
//                   availableTranslations:
//                       isolateLanguagesFromDescription(widget.descriptions),
//                 ),
//               ).then((value) {
//                 if (value is Language) {
//                   print(value);
//                   setState(() {
//                     _currentLanguage = value;
//                   });
//                 }
//               });
//             },
//             child: Container(
//               width: 46,
//               height: 32,
//               color: Colors.redAccent,
//               child: Text(_currentLanguage.languageLabel),
//             ),
//           ),
//         ),
//         getDescriptionWidget(),
//       ],
//     );
//   }
// }

// class DescriptionTranslation extends StatelessWidget {
//   const DescriptionTranslation({
//     super.key,
//     required this.description,
//     required this.removeDescriptionFromList,
//     required this.focusNode,
//   });

//   final Description description;
//   final VoidCallback removeDescriptionFromList;
//   final FocusNode focusNode;

//   void _updateDescription() {
//     EasyDebounce.debounce(
//       'updateDescription',
//       const Duration(milliseconds: 250),
//       () {
//         if (description.text.isEmpty) {
//           deleteDescription(description)
//               .then((value) => removeDescriptionFromList());
//         } else {
//           upsertDescription(description);
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomTextFormField(
//       focusNode: focusNode,
//       initialValue: description.text,
//       hintText: "Enter Description",
//       maxLines: null,
//       keyboardType: TextInputType.multiline,
//       onChanged: (val) {
//         description.text = val;
//         _updateDescription();
//       },
//       confirmDeleteDialog:
//           const ConfirmDeleteDialog(label: "Description Translation"),
//     );
//   }
// }

// class NewDescriptionTranslation extends StatelessWidget {
//   const NewDescriptionTranslation({
//     super.key,
//     required this.addNewDescriptionInList,
//     required this.language,
//     required this.petProfileId,
//     required this.focusNode,
//   });

//   final Function(Description description) addNewDescriptionInList;
//   final Language language;
//   final int petProfileId;
//   final FocusNode focusNode;

//   void _addDescription(String text) {
//     EasyDebounce.debounce(
//       'newDescription',
//       const Duration(milliseconds: 500),
//       () {
//         if (text.isNotEmpty) {
//           Description newDescription =
//               Description(text, language, petProfileId);
//           upsertDescription(newDescription)
//               .then((value) => addNewDescriptionInList(newDescription));
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomTextFormField(
//       focusNode: focusNode,
//       hintText: "My Dog is Child friendly, loves to be kicked in his left ball",
//       maxLines: null,
//       keyboardType: TextInputType.multiline,
//       onChanged: (value) {
//         _addDescription(value);
//       },
//     );
//   }
// }
