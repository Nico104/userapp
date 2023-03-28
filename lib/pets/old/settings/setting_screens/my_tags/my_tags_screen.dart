// import 'package:flutter/material.dart';
// import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
// import '../../../pet_color/hex_color.dart';
// import '../../../pets/profile_details/models/m_tag.dart';
// import '../../../pets/tag/tag_single.dart';
// import '../../../pets/u_pets.dart';
// import '../../../styles/text_styles.dart';

// class MyTagsSettings extends StatefulWidget {
//   const MyTagsSettings({super.key});

//   @override
//   State<MyTagsSettings> createState() => _MyTagsSettingsState();
// }

// class _MyTagsSettingsState extends State<MyTagsSettings> {
//   double _appBarDividerHeight = 0;

//   final double _appBarDividerHeightActivated = 2.5;
//   final double _appBarElevationActivated = 4;

//   final _scrollSontroller = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollSontroller.addListener(() {
//       bool isTop = _scrollSontroller.position.pixels == 0;
//       if (isTop) {
//         if (_appBarDividerHeight != 0) {
//           setState(() {
//             _appBarDividerHeight = 0;
//           });
//         }
//       } else {
//         if (_appBarDividerHeight == 0) {
//           setState(() {
//             _appBarDividerHeight = _appBarDividerHeightActivated;
//           });
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "My Tags",
//           style: settingsScreenTitle,
//           textAlign: TextAlign.center,
//         ),
//         centerTitle: true,
//         iconTheme: const IconThemeData(
//           color: Colors.black,
//         ),
//         backgroundColor: HexColor("50ffaf"),
//         scrolledUnderElevation: _appBarElevationActivated,
//         elevation: 0,
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(_appBarDividerHeight),
//           child: Container(
//             color: Colors.black,
//             height: _appBarDividerHeight,
//           ),
//         ),
//       ),
//       backgroundColor: HexColor("50ffaf"),
//       body: FutureBuilder<List<List<dynamic>>>(
//         future: Future.wait([
//           fetchUserTags(),
//           fetchUserPets(),
//         ]),
//         builder: (BuildContext context,
//             AsyncSnapshot<List<List<dynamic>>> snapshot) {
//           if (snapshot.hasData) {
//             List<Tag> tags = snapshot.data?.first as List<Tag>;
//             List<PetProfileDetails> petProfiles =
//                 snapshot.data?.last as List<PetProfileDetails>;
//             return ListView.builder(
//               controller: _scrollSontroller,
//               //+1 to give initialPadding
//               itemCount: tags.length + 1,
//               itemBuilder: (BuildContext context, int index) {
//                 if (index == 0) {
//                   return Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: const [
//                       SizedBox(height: 42),
//                     ],
//                   );
//                 } else {
//                   int position = index - 1;
//                   PetProfileDetails? petProfileDetails = getPetAssignedToTag(
//                       petProfiles, tags.elementAt(position));
//                   return Container(
//                     padding: const EdgeInsets.all(16),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TagSingle(
//                           tagPersonalisation:
//                               tags.elementAt(position).collarTagPersonalisation,
//                           collardimension: 95,
//                         ),
//                         const Spacer(),
//                         (petProfileDetails != null)
//                             ? Text("${petProfileDetails.petName}'s")
//                             : const SizedBox(),
//                         // const Spacer(flex: 8),
//                         // getSelectionIcon(widget.tagSelection),
//                       ],
//                     ),
//                   );
//                 }
//               },
//             );
//           } else if (snapshot.hasError) {
//             print(snapshot);
//             //Error
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.error_outline,
//                     color: Colors.red,
//                     size: 60,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 16),
//                     child: Text('Error: ${snapshot.error}'),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             //Loading
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   SizedBox(
//                     width: 60,
//                     height: 60,
//                     child: CircularProgressIndicator(),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 16),
//                     child: Text('Awaiting result...'),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// PetProfileDetails? getPetAssignedToTag(
//     List<PetProfileDetails> userPets, Tag tag) {
//   if (tag.petProfileId != null) {
//     for (PetProfileDetails petProfileDetails in userPets) {
//       if (petProfileDetails.profileId == tag.petProfileId) {
//         return petProfileDetails;
//       }
//     }
//   }
//   return null;
// }
