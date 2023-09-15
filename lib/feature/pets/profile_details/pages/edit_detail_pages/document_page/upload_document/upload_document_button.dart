// import 'dart:typed_data';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/document_page/document_page.dart';
// import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/document_page/upload_document/upload_document_page.dart';

// import '../../../../../../../general/utils_general.dart';
// import '../../../../../../../general/utils_theme/custom_colors.dart';
// import '../../../../pictures/upload_picture_dialog.dart';
// import '../../../../u_profile_details.dart';

// class UploadDocumentButton extends StatelessWidget {
//   const UploadDocumentButton({
//     super.key,
//     required bool showUploadButton,
//     required this.profileId,
//     required this.reloadDocuments,
//   }) : _showUploadButton = showUploadButton;

//   final bool _showUploadButton;
//   final int profileId;
//   final VoidCallback reloadDocuments;

//   final double _borderRadius = 32;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: AnimatedAlign(
//         alignment: _showUploadButton
//             ? const Alignment(0.0, 1.0)
//             : const Alignment(0.0, 3.0),
//         duration: const Duration(milliseconds: 250),
//         curve: Curves.fastOutSlowIn,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//           child: InkWell(
//             borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
//             onTap: () {
//               pickDocument().then((value) => {
//                     if (value != null)
//                       {
//                         navigatePerSlide(
//                           context,
//                           DocumentUploadPage(
//                             pickedDocument: value,
//                             addDocument: (value, filename, contentType) async {
//                               // Loading Dialog Thingy
//                               BuildContext? dialogContext;
//                               showDialog(
//                                 context: context,
//                                 barrierDismissible: false,
//                                 builder: (BuildContext context) {
//                                   dialogContext = context;
//                                   return const UploadPictureDialog();
//                                 },
//                               );
//                               await uploadDocuments(
//                                 profileId,
//                                 value,
//                                 filename,
//                                 contentType,
//                                 () async {
//                                   // widget.reloadFuture.call();
//                                   //hekps against 403 from server
//                                   await Future.delayed(
//                                           const Duration(milliseconds: 2000))
//                                       .then((value) => reloadDocuments());
//                                   //Close Loading Dialog Thingy
//                                   Navigator.pop(dialogContext!);
//                                 },
//                               );
//                             },
//                           ),
//                         )
//                       }
//                   });
//               //   showDialog(
//               //     context: context,
//               //     builder: (_) => DocumentDialog(
//               //       pickedDocument: value,
//               //       addDocument: (value, filename, documentType,
//               //           contentType) async {
//               //         // Loading Dialog Thingy
//               //         BuildContext? dialogContext;
//               //         showDialog(
//               //           context: context,
//               //           barrierDismissible: false,
//               //           builder: (BuildContext context) {
//               //             dialogContext = context;
//               //             return const UploadPictureDialog();
//               //           },
//               //         );
//               //         await uploadDocuments(
//               //           _petProfileDetails.profileId,
//               //           value,
//               //           filename,
//               //           documentType,
//               //           contentType,
//               //           () async {
//               //             // widget.reloadFuture.call();
//               //             //hekps against 403 from server
//               //             await Future.delayed(
//               //                     const Duration(milliseconds: 2000))
//               //                 .then((value) =>
//               //                     reloadPetProfileDetails());
//               //             //Close Loading Dialog Thingy
//               //             Navigator.pop(dialogContext!);
//               //           },
//               //         );
//               //       },
//               //     ),
//               //   )
//               // }
//             },
//             child: Material(
//               borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
//               elevation: 6,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius:
//                       BorderRadius.all(Radius.circular(_borderRadius)),
//                   // color: Theme.of(context).primaryColor.withOpacity(1),
//                   color: getCustomColors(context).accent,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // const SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             Icons.image,
//                             color: Colors.white,
//                           ),
//                           SizedBox(width: 8),
//                           Text(
//                             "Upload Picture",
//                             style: GoogleFonts.openSans(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 18,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Future<PickedDocument?> pickDocument() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     withData: true,
//     type: FileType.custom,
//     // allowedExtensions: ["jpg", "jpeg", 'png', 'pdf', 'doc', 'mp3', 'm4a'],
//     allowedExtensions: ["jpg", "jpeg", 'png', 'pdf'],
//     allowMultiple: false,
//   );

//   print("Result: " + result.toString());

//   if (result != null && result.files.isNotEmpty) {
//     String fileExtension = result.files.first.extension!;
//     Uint8List fileBytes = result.files.first.bytes!;

//     String fileName = result.files.first.name.split('.').first;
//     print("File Name: " + fileName);
//     return PickedDocument(fileExtension, fileBytes, fileName);
//   }
//   return null;
// }

// class PickedDocument {
//   final String fileExtension;
//   final String fileName;
//   final Uint8List fileBytes;

//   PickedDocument(this.fileExtension, this.fileBytes, this.fileName);
// }
