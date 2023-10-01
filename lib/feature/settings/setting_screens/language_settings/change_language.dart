// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:userapp/feature/pets/profile_details/g_profile_detail_globals.dart';

// import '../../../../general/network_globals.dart';

// class ChangeLanguage extends StatefulWidget {
//   const ChangeLanguage({super.key});

//   @override
//   State<ChangeLanguage> createState() => _ChangeLanguageState();
// }

// class _ChangeLanguageState extends State<ChangeLanguage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("appBarLangaugeSettings".tr()),
//       ),
//       body: ListView.builder(
//         itemCount: availableLanguages.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(22),
//             child: Material(
//               elevation: 4,
//               borderRadius: BorderRadius.circular(16),
//               child: GestureDetector(
//                 onTap: () async {
//                   await context.setLocale(
//                       Locale(availableLanguages.elementAt(index).languageKey));
//                   //Wait otherwise Language doesnt update .tr()
//                   await Future.delayed(Duration(milliseconds: 125));
//                   setState(() {});
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     border: context.locale.toString() ==
//                             availableLanguages.elementAt(index).languageKey
//                         ? Border.all(color: Colors.black, width: 2)
//                         : null,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         AspectRatio(
//                           aspectRatio: 3 / 2,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: Image.network(s3BaseUrl +
//                                 availableLanguages
//                                     .elementAt(index)
//                                     .languageImagePath),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             availableLanguages.elementAt(index).languageLabel,
//                             style: Theme.of(context).textTheme.titleMedium,
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                       ],
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
