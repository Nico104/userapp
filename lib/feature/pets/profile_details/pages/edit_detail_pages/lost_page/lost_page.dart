// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
// import 'package:userapp/general/widgets/shy_button.dart';
// import 'package:userapp/general/widgets/custom_scroll_view.dart';

// import '../../../c_component_padding.dart';
// import '../../../models/m_pet_profile.dart';
// import '../../../widgets/custom_textformfield.dart';

// class LostPage extends StatefulWidget {
//   const LostPage({
//     super.key,
//     required this.petProfileDetails,
//   });

//   @override
//   State<LostPage> createState() => _LostPageState();

//   final PetProfileDetails petProfileDetails;
// }

// class _LostPageState extends State<LostPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           CustomNicoScrollView(
//             title: Text("Tabo is Lost"),
//             body: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 16),
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Text(
//                     "Mark your lost pet as lost to help your community find them and prevent harm.",
//                     style: GoogleFonts.openSans(
//                       fontSize: 16,
//                       color: Colors.black87,
//                     ),
//                     // textAlign: TextAlign.center,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Text(
//                     "Add Information for People to see first",
//                     style: GoogleFonts.openSans(
//                       fontSize: 16,
//                       color: Colors.black87,
//                     ),
//                     // textAlign: TextAlign.center,
//                   ),
//                 ),
//                 PaddingComponent(
//                   child: CustomTextFormField(
//                     // focusNode: focusNode,
//                     // initialValue: petProfile.petIsLostText,
//                     // textEditingController: _textEditingController,
//                     hintText: "Tabo got together with an onther dog",
//                     maxLines: null,
//                     expands: false,
//                     keyboardType: TextInputType.multiline,
//                     autofocus: false,
//                     onChanged: (val) {
//                       // petProfile.petIsLostText = val;
//                     },
//                     showSuffix: false,
//                   ),
//                 ),
//                 SizedBox(height: 40.h),
//               ],
//             ),
//             onScroll: () {},
//           ),
//           ShyButton(
//             showUploadButton: true,
//             onTap: () {},
//             label: "Mark as Lost",
//           )
//         ],
//       ),
//     );
//   }
// }
