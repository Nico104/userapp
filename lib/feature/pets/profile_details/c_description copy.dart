// import 'package:easy_debounce/easy_debounce.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:userapp/pets/profile_details/models/m_description.dart';
// import 'package:userapp/styles/custom_icons_icons.dart';
// import 'package:userapp/theme/custom_colors.dart';
// import '../../language/m_language.dart';
// import 'c_component_title.dart';
// import '../../language/c_language_selection.dart';
// import 'widgets/custom_textformfield.dart';

// class PetDescriptionComponent extends StatefulWidget {
//   const PetDescriptionComponent({
//     super.key,
//     required this.descriptions,
//     // required this.addDescription,
//     // required this.removeDescription,
//   });

//   //Pictures
//   final List<Description> descriptions;

//   @override
//   State<PetDescriptionComponent> createState() =>
//       _PetDescriptionComponentState();
// }

// class _PetDescriptionComponentState extends State<PetDescriptionComponent> {
//   // final ValueSetter<Description> addDescription;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ComponentTitle(text: "profileDetailsComponentTitleDescription".tr()),
//         ListView.builder(
//           itemCount: widget.descriptions.length + 1,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (BuildContext context, int index) {
//             if (index == widget.descriptions.length) {
//               return NewDescriptionTranslation(
//                 descriptions: widget.descriptions,
//                 addNewDescription: (text, language) {
//                   setState(() {
//                     widget.descriptions.add(Description(text, language));
//                   });
//                 },
//               );
//             } else {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 8),
//                 child: DescriptionTranslation(
//                   //Pass by reference
//                   description: widget.descriptions.elementAt(index),
//                   descriptions: widget.descriptions,
//                   index: index,
//                 ),
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

// class DescriptionTranslation extends StatelessWidget {
//   const DescriptionTranslation({
//     super.key,
//     required this.index,
//     required this.description,
//     required this.descriptions,
//   });

//   final Description description;
//   final List<Description> descriptions;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: CustomTextFormField(
//             initialValue: description.text,
//             hintText: "Enter Description",
//             maxLines: null,
//             keyboardType: TextInputType.multiline,
//             onChanged: (val) {
//               description.text = val;
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 8, right: 16),
//           child: GestureDetector(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (_) => LanguagePickerDialogComponent(
//                   excludeLanguageCodes:
//                       isolateLanguageCodesFromDescription(descriptions),
//                 ),
//               ).then((value) {
//                 if (value != null) {
//                   if (value is Language) {
//                     description.language = value;
//                   }
//                 }
//               });
//             },
//             child: Container(
//               height: 50,
//               width: 60,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                     color: getCustomColors(context).lightBorder ??
//                         Colors.transparent,
//                     width: 1),
//                 color: Theme.of(context).primaryColor,
//               ),
//               child: Center(
//                   child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: NetworkImage("https://picsum.photos/60"),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               )),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// class NewDescriptionTranslation extends StatefulWidget {
//   const NewDescriptionTranslation({
//     super.key,
//     required this.addNewDescription,
//     required this.descriptions,
//   });

//   final List<Description> descriptions;
//   final Function(String text, Language language) addNewDescription;

//   @override
//   State<NewDescriptionTranslation> createState() =>
//       _NewDescriptionTranslationState();
// }

// class _NewDescriptionTranslationState extends State<NewDescriptionTranslation> {
//   String _text = "";

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: CustomTextFormField(
//             hintText:
//                 "My Dog is Child friendly, loves to be kicked in his left ball",
//             maxLines: null,
//             keyboardType: TextInputType.multiline,
//             onChanged: (val) {
//               EasyDebounce.debounce(
//                 'newDescriptionTranslation',
//                 const Duration(milliseconds: 500),
//                 () {
//                   setState(() {
//                     _text = val;
//                   });
//                 },
//               );
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 8, right: 16),
//           child: GestureDetector(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (_) => LanguagePickerDialogComponent(
//                   excludeLanguageCodes:
//                       isolateLanguageCodesFromDescription(widget.descriptions),
//                 ),
//               ).then((value) {
//                 if (value != null) {
//                   widget.addNewDescription(_text, value);
//                 }
//               });
//             },
//             child: Container(
//               height: 50,
//               width: 60,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: getCustomColors(context).lightBorder ??
//                       Colors.transparent,
//                   width: 1,
//                 ),
//                 color: Theme.of(context).primaryColor,
//               ),
//               child: const Center(
//                   child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: SizedBox.expand(
//                   child: FittedBox(
//                     child: Icon(CustomIcons.globe_5),
//                   ),
//                 ),
//               )),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
