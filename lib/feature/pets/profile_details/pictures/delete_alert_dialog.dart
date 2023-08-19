// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:userapp/theme/custom_colors.dart';
// import '../../../theme/custom_text_styles.dart';

// ///Lets USer choose between camera and gallery
// ///returns 1 if Camera has been chosen or 0 if Gallery has been chosen
// class DeleteImageAlertDialog extends StatefulWidget {
//   const DeleteImageAlertDialog({
//     super.key,
//   });

//   @override
//   State<DeleteImageAlertDialog> createState() => _DeleteImageAlertDialogState();
// }

// class _DeleteImageAlertDialogState extends State<DeleteImageAlertDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(14),
//       ),
//       elevation: 0,
//       child: SizedBox(
//         width: 80.w,
//         child: Padding(
//           padding:
//               const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "Delete Picture",
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               const SizedBox(height: 28),
//               Text(
//                 "Fur real? You're going to delete this cute pic?",
//                 style: Theme.of(context).textTheme.labelMedium,
//               ),
//               const SizedBox(height: 28),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   //Todo switch with Cancel and Confirm Widgets
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
//                       style: getCustomTextStyles(context)
//                           .dataEditDialogButtonCancelStyle,
//                     ),
//                   ),
//                   OutlinedButton(
//                     onPressed: () => Navigator.pop(context, 1),
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
//                       //TODO put delete Color
//                       backgroundColor: getCustomColors(context).accent,
//                       side: const BorderSide(width: 1, color: Colors.black),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       "Delete",
//                       style: getCustomTextStyles(context)
//                           .dataEditDialogButtonSaveStyle,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
