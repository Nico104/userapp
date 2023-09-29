// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import '../../general/utils_theme/custom_colors.dart';
// import '../../general/utils_theme/custom_text_styles.dart';
// import 'c_language_selection.dart';
// import 'm_language.dart';

// class TranslationPicker extends StatelessWidget {
//   const TranslationPicker({
//     super.key,
//     required this.availableTranslations,
//     required this.currentTranslation,
//   });

//   final List<Language> availableTranslations;
//   final Language currentTranslation;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       elevation: 16,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Container(
//         width: 70.w,
//         constraints: BoxConstraints(maxHeight: 60.h),
//         child: Padding(
//           padding:
//               const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 32),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "selectTranslationTitle".tr(),
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               const SizedBox(height: 28),
//               availableTranslations.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: availableTranslations.length,
//                       shrinkWrap: true,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             AvailableTranslation(
//                               language: availableTranslations.elementAt(index),
//                               isActive: !(currentTranslation.languageKey ==
//                                   availableTranslations
//                                       .elementAt(index)
//                                       .languageKey),
//                             ),
//                             (index != availableTranslations.length - 1)
//                                 ? const Divider()
//                                 : const SizedBox(),
//                           ],
//                         );
//                       },
//                     )
//                   : Text(
//                       "Translations are a way for you to make Information of your furred friend available in multiple languages. Give it a go ;)",
//                       style: Theme.of(context).textTheme.labelSmall,
//                       textAlign: TextAlign.center,
//                     ),
//               const SizedBox(height: 28),
//               InkWell(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (_) => LanguagePickerDialogComponent(
//                       excludeLanguages: availableTranslations,
//                     ),
//                   ).then((value) {
//                     //if null just pop and dismiss all dialogs, if Language return Language
//                     Navigator.pop(context, value);
//                   });
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(12),
//                   child: Text(
//                     "newTranslationLabel".tr(),
//                     style: Theme.of(context).textTheme.labelMedium,
//                     textAlign: TextAlign.center,
//                   ),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.shade400),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AvailableTranslation extends StatelessWidget {
//   const AvailableTranslation({
//     super.key,
//     required this.language,
//     required this.isActive,
//   });

//   final Language language;
//   final bool isActive;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTap: () {
//         if (isActive) {
//           Navigator.pop(context, language);
//         }
//       },
//       child: Opacity(
//         opacity: isActive ? 1 : 0.5,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Spacer(),
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: NetworkImage("https://picsum.photos/60"),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 42),
//                 Text(language.languageLabel),
//                 const Spacer(
//                   flex: 5,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//           ],
//         ),
//       ),
//     );
//   }
// }
