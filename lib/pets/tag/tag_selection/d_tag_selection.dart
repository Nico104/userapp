// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:userapp/pets/u_pets.dart';

// // import '../../../../../pet_color/pet_colors.dart';
// import '../../../../../styles/text_styles.dart';
// import '../../profile_details/models/m_tag.dart';
// import 'tag_selection_list.dart';

// class TagSelectionDialog extends StatefulWidget {
//   const TagSelectionDialog({
//     super.key,
//     required this.currentTags,
//   });

//   final List<Tag> currentTags;

//   @override
//   State<TagSelectionDialog> createState() => _TagSelectionDialogState();
// }

// class _TagSelectionDialogState extends State<TagSelectionDialog> {
//   List<Tag> selectedTags = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(14),
//         side: const BorderSide(color: Colors.black, width: 2.5),
//       ),
//       elevation: 0,
//       child: Container(
//         width: 80.w,
//         constraints: BoxConstraints(maxHeight: 70.h),
//         child: Padding(
//           padding:
//               const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "Select Finma's",
//                 // style: pickerDialogTitleStyle,
//               ),
//               const SizedBox(height: 28),
//               Expanded(
//                 child: FutureBuilder<List<Tag>>(
//                   future: fetchUserTags(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<List<Tag>> snapshot) {
//                     if (snapshot.hasData) {
//                       return TagSelectionList(
//                         userTags: snapshot.data!,
//                         currentTags: widget.currentTags,
//                         returnTags: (tags) {
//                           setState(() {
//                             selectedTags = List.from(tags);
//                           });
//                         },
//                       );
//                     } else if (snapshot.hasError) {
//                       print(snapshot);
//                       //Error
//                       return Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(
//                               Icons.error_outline,
//                               color: Colors.red,
//                               size: 60,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 16),
//                               child: Text('Error: ${snapshot.error}'),
//                             ),
//                           ],
//                         ),
//                       );
//                     } else {
//                       //Loading
//                       return Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             SizedBox(
//                               width: 60,
//                               height: 60,
//                               child: CircularProgressIndicator(),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(top: 16),
//                               child: Text('Awaiting result...'),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),
//               const SizedBox(height: 28),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   OutlinedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
//                       side: const BorderSide(width: 1, color: Colors.grey),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       "Cancel",
//                       // style: dataEditDialogButtonCancelStyle,
//                     ),
//                   ),
//                   OutlinedButton(
//                     onPressed: () {
//                       if (selectedTags.isNotEmpty) {
//                         Navigator.pop(context, selectedTags);
//                       }
//                     },
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
//                       // backgroundColor: (selectedTags.isNotEmpty)
//                       //     ? dataEditDialogButtonSave
//                       //     : Colors.white,
//                       side: BorderSide(
//                           width: 1,
//                           color: (selectedTags.isNotEmpty)
//                               ? Colors.black
//                               : Colors.grey),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       "Save ahead",
//                       // style: (selectedTags.isNotEmpty)
//                       //     ? dataEditDialogButtonSaveStyle
//                       //     : dataEditDialogButtonCancelStyle,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
