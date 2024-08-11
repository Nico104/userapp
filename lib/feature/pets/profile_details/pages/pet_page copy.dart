// import 'dart:ui';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:easy_debounce/easy_debounce.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:sizer/sizer.dart';
// import 'package:userapp/feature/navigation_peppi/share_seppi.dart';
// import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
// import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
// import 'package:userapp/feature/pets/profile_details/visibility/visibility_menu.dart';

// import '../../../../general/utils_color/hex_color.dart';
// import '../../../../general/utils_custom_icons/custom_icons_icons.dart';
// import '../../../../general/utils_theme/custom_colors.dart';
// import '../../../../general/utils_general.dart';
// import '../../../../general/widgets/auto_save_info.dart';
// import '../../../../general/widgets/custom_nico_modal.dart';
// import '../../../../general/widgets/more_button.dart';
// import '../../../scans/scans_page.dart';
// import '../../../tag/tag_selection/tag_selection_page.dart';
// import '../../../tag/utils/u_tag.dart';
// import '../../u_pets.dart';
// import '../d_confirm_delete.dart';
// import '../models/m_tag.dart';
// import '../../../../general/widgets/custom_flexible_space_bar.dart';

// import 'edit_detail_pages/basic_information/basic_information_page.dart';
// import 'edit_detail_pages/contact_page/contact_page.dart';
// import 'edit_detail_pages/description_page/description_page.dart';
// import 'edit_detail_pages/document_page/document_page.dart';
// import 'edit_detail_pages/lost_page/lost_box.dart';
// import 'edit_detail_pages/medical_page/medical_page.dart';
// import 'edit_detail_pages/pictures_page/pictures_page.dart';

// class PetPage2 extends StatefulWidget {
//   const PetPage2({
//     super.key,
//     required this.petProfileDetails,
//     this.showAppbar = true,
//     this.showDescriptions = true,
//     this.openTagPageOnStart = false,
//   });

//   //? Maybe Variable and fetchFrromServer when needed Updated a la Contact
//   final PetProfileDetails petProfileDetails;

//   ///Only for Theme Selection Page
//   final bool showAppbar;

//   final bool showDescriptions;

//   final bool openTagPageOnStart;

//   @override
//   State<PetPage2> createState() => _PetPage2State();
// }

// class _PetPage2State extends State<PetPage2> with TickerProviderStateMixin {
//   late PetProfileDetails _petProfileDetails;

//   final double tagDimension = 160;

//   // bool _headerVisible = true;
//   bool _scrollTop = true;

//   final ScrollController _scrollController = ScrollController();

//   final GlobalKey<NestedScrollViewState> nestedScrolViewKey = GlobalKey();
//   final tabBarKey = GlobalKey();

//   late TabController tabController;

//   final PageController _controller = PageController();
//   double pageindex = 0;

//   @override
//   void initState() {
//     super.initState();

//     _petProfileDetails = widget.petProfileDetails;

//     tabController = TabController(
//         initialIndex: 0,
//         length: 3,
//         vsync: this,
//         animationDuration: const Duration(milliseconds: 250));

//     _controller.addListener(() {
//       setState(() {
//         pageindex = _controller.page ?? 0;
//         // _closeExtendedActions();
//       });
//     });

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       if (widget.openTagPageOnStart) {
//         navigatePerSlide(
//           context,
//           TagSelectionPage(
//             petProfile: _petProfileDetails,
//           ),
//         );
//       }
//       _scrollController.addListener(() {
//         _initiateIsTopListener();
//         // _handleNavBarShown();

//         // _scrollController.position.userScrollDirection
//         debugPrint(_scrollController.position.userScrollDirection.toString());
//         _handleScrollTilt(_scrollController.position.userScrollDirection);
//       });
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   double _tiltAngle = 0;
//   // final double maxTilt = 0.02;
//   final double maxTilt = 0.0;

//   void _handleScrollTilt(ScrollDirection scrollDirection) {
//     //hideBar
//     // widget.showBottomNavBar(false);
//     if (scrollDirection == ScrollDirection.forward && _tiltAngle != -maxTilt) {
//       setState(() {
//         _tiltAngle = -maxTilt;
//       });
//     } else if (scrollDirection == ScrollDirection.reverse &&
//         _tiltAngle != maxTilt) {
//       setState(() {
//         _tiltAngle = maxTilt;
//       });
//     }
//     EasyDebounce.debounce(
//       '_handleScrollTilt',
//       const Duration(milliseconds: 350),
//       () {
//         if (_tiltAngle != 0) {
//           setState(() {
//             _tiltAngle = 0;
//           });
//         }
//       },
//     );
//   }

//   void _initiateIsTopListener() {
//     bool isTop = _scrollController.position.pixels == 0;
//     // print("top: $isTop");
//     if (isTop) {
//       if (!_scrollTop && mounted) {
//         setState(() {
//           _scrollTop = true;
//         });
//       }
//     } else {
//       if (_scrollTop && mounted) {
//         setState(() {
//           _scrollTop = false;
//         });
//       }
//     }
//   }

//   double getScrolledUnderElevation() {
//     if (_scrollTop) {
//       return 0;
//     } else if (!_scrollTop) {
//       return 8;
//     } else {
//       return 0;
//     }
//   }

//   // void refresh() {
//   //   if (mounted) {
//   //     setState(() {});
//   //   }
//   // }
//   void reloadPetProfileDetails() async {
//     _petProfileDetails = await getPet(_petProfileDetails.profileId);
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   Future<void> reloadTags() async {
//     List<Tag> newTags = await getUserProfileTags(_petProfileDetails.profileId);
//     setState(() {
//       _petProfileDetails.tag = newTags;
//     });
//   }

//   Widget _getMoreButton() {
//     return MoreButton(
//       moreOptions: [
//         ListTile(
//           leading: const Icon(CustomIcons.delete),
//           title: Text("petPage_Options_Delete"
//               .tr(namedArgs: {'name': widget.petProfileDetails.petName})),
//           onTap: () {
//             Navigator.pop(context);
//             showDialog(
//               context: context,
//               builder: (_) => ConfirmDeleteDialog(
//                 label: "petPage_confirmDeleteLabel".tr(),
//               ),
//             ).then((value) {
//               if (value != null) {
//                 if (value == true) {
//                   //TODO test delete from settings menu because of the refresh Profiles on pop()
//                   deletePetProfile(_petProfileDetails).then((value) {
//                     Navigator.pop(context);
//                   });
//                 }
//               }
//             });
//           },
//         ),
//         ListTile(
//           leading: const Icon(CustomIcons.share_thin),
//           title: Text("petPage_Options_Share".tr()),
//           onTap: () {
//             Navigator.pop(context);
//             showShare();
//           },
//         ),
//         ListTile(
//           leading: const Icon(CustomIcons.qr_code_9),
//           title: Text("petPage_Options_Scans".tr()),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ScansPage(
//                   petName: widget.petProfileDetails.petName,
//                   // scans: widget.petProfileDetails.petProfileScans,
//                   petProfileId: widget.petProfileDetails.profileId,
//                 ),
//               ),
//             );
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.visibility_outlined),
//           title: Text("Visibility Menu"),
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => VisibilityMenu(
//                   petProfileDetails: _petProfileDetails,
//                 ),
//               ),
//             );
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.help_outline),
//           title: Text("helpWithThisPage".tr()),
//           onTap: () {
//             //Todo Link to help website
//           },
//         ),
//       ],
//       child: const Icon(Icons.more_horiz),
//     );
//   }

//   void showShare() {
//     showCustomNicoModalBottomSheet(
//       context: context,
//       child: ShareSeppi(
//         closeShareSeppi: () {
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }

//   static Matrix4 _pmat(num pv) {
//     return Matrix4(
//       1.0,
//       0.0,
//       0.0,
//       0.0,
//       0.0,
//       1.0,
//       0.0,
//       0.0,
//       0.0,
//       0.0,
//       1.0,
//       pv * 0.001,
//       0.0,
//       0.0,
//       0.0,
//       1.0,
//     );
//   }

//   Matrix4 perspective = _pmat(1.0);

// // [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// // turn can be placed in a [Scaffold.body].
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ScrollConfiguration(
//         behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
//         child: CustomScrollView(
//           controller: _scrollController,
//           physics: const BouncingScrollPhysics(),
//           slivers: <Widget>[
//             widget.showAppbar
//                 ? SliverAppBar(
//                     pinned: true,
//                     stretch: true,
//                     expandedHeight: 140.0,
//                     actions: [
//                       _getMoreButton(),
//                       const SizedBox(width: 16),
//                     ],
//                     // automaticallyImplyLeading: false,
//                     flexibleSpace: MyFlexibleSpaceBar(
//                       titlePaddingTween: EdgeInsetsTween(
//                           begin: const EdgeInsets.only(left: 16.0, bottom: 16),
//                           end: const EdgeInsets.only(left: 72.0, bottom: 16)),
//                       title: Text('petProfileTitle'.tr(
//                           namedArgs: {'value1': _petProfileDetails.petName})),
//                       // titlePadding: EdgeInsets.all(0), centerTitle: false,
//                       // centerTitle: true,
//                       // background: FlutterLogo(),
//                     ),
//                   )
//                 : const SliverToBoxAdapter(child: SizedBox.shrink()),
//             SliverToBoxAdapter(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 28),
//                   Row(
//                     children: [
//                       const GridSpacing(),
//                       Expanded(
//                         child: Column(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 navigatePerSlide(
//                                   context,
//                                   VisibilityMenu(
//                                     petProfileDetails: widget.petProfileDetails,
//                                   ),
//                                 );
//                               },
//                               child: AspectRatio(
//                                 aspectRatio: 1,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: Theme.of(context).primaryColor,
//                                     // color: Colors.blue,
//                                     // color: _petProfileDetails.petIsLost
//                                     //     ? HexColor("#A52A2A")
//                                     //     : HexColor("#958164"),
//                                     // border: Border.all(
//                                     //   width: 0,
//                                     //   color:
//                                     //       getCustomColors(context).hardBorder ??
//                                     //           Colors.transparent,
//                                     //   // strokeAlign: BorderSide.strokeAlignOutside,
//                                     // ),
//                                     borderRadius: BorderRadius.circular(18),
//                                     boxShadow: kElevationToShadow[6],
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(18),
//                                     child: Stack(
//                                       children: [
//                                         Align(
//                                           alignment: Alignment(-1.5, 0.6),
//                                           child: Image.asset(
//                                             "assets/details_illustartions/privacy.png",
//                                             scale: 1.5,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(16),
//                                           child: AutoSizeText(
//                                             "Privacy".tr(),
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .titleLarge,
//                                             maxLines: 1,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const GridSpacing(),
//                             GestureDetector(
//                               onTap: () {
//                                 navigatePerSlide(
//                                   context,
//                                   ContactPage(
//                                     petProfileDetails: widget.petProfileDetails,
//                                   ),
//                                 );
//                               },
//                               child: Material(
//                                 borderRadius: BorderRadius.circular(18),
//                                 elevation: 4,
//                                 child: Container(
//                                   height: (100.w - 3 * 16) + 16,
//                                   decoration: BoxDecoration(
//                                     color: getCustomColors(context).surface,
//                                     border: Border.all(
//                                       width: 0.3,
//                                       color:
//                                           getCustomColors(context).hardBorder ??
//                                               Colors.transparent,
//                                       // strokeAlign: BorderSide.strokeAlignOutside,rr
//                                     ),
//                                     borderRadius: BorderRadius.circular(18),
//                                     // boxShadow: kElevationToShadow[3],
//                                   ),
//                                   // padding: const EdgeInsets.all(8.0),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(18),
//                                     child: Stack(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 8.0),
//                                           child: Align(
//                                             alignment: Alignment.bottomRight,
//                                             child: Image.asset(
//                                                 "assets/details_illustartions/contact_1_cut.png"),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(16),
//                                           child: AutoSizeText(
//                                             "petPage_Contact".tr(),
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .titleLarge,
//                                             maxLines: 1,
//                                           ),
//                                         ),
//                                         Align(
//                                           alignment:
//                                               // const Alignment(-1, -0.5),
//                                               Alignment.bottomLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(16),
//                                             child: Row(
//                                               children: [
//                                                 widget.showDescriptions
//                                                     ? Expanded(
//                                                         flex: 5,
//                                                         child: (widget
//                                                                 .petProfileDetails
//                                                                 .petContacts
//                                                                 .isEmpty)
//                                                             ? Text(
//                                                                 "Keine Kontakte vorhanden"
//                                                                     .tr(),
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .justify,
//                                                                 style: Theme.of(
//                                                                         context)
//                                                                     .textTheme
//                                                                     .displaySmall,
//                                                               )
//                                                             // : Text(
//                                                             //     "petPage_ContactInfo"
//                                                             //         .tr(),
//                                                             //     style: Theme.of(
//                                                             //             context)
//                                                             //         .textTheme
//                                                             //         .displaySmall,
//                                                             //   ),
//                                                             : Text(
//                                                                 "${widget.petProfileDetails.petContacts.length} Kontakte"
//                                                                     .tr(),
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .justify,
//                                                                 style: Theme.of(
//                                                                         context)
//                                                                     .textTheme
//                                                                     .displaySmall,
//                                                               ),
//                                                       )
//                                                     : const SizedBox.shrink(),
//                                                 const Spacer(
//                                                   flex: 4,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const GridSpacing(),
//                       Expanded(
//                         child: Column(
//                           children: [
//                             const GridSpacing(),
//                             AspectRatio(
//                               aspectRatio: 1,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Navigator.of(context)
//                                       .push(
//                                     PageRouteBuilder(
//                                       opaque: false,
//                                       barrierDismissible: true,
//                                       pageBuilder:
//                                           (BuildContext context, _, __) {
//                                         return LostBox(
//                                           petProfile: _petProfileDetails,
//                                           goToVisibilityMenu: () {
//                                             navigatePerSlide(
//                                                 context,
//                                                 // ContactPage(
//                                                 //   petProfileDetails: widget
//                                                 //       .petProfileDetails,
//                                                 // ),
//                                                 VisibilityMenu(
//                                                     petProfileDetails: widget
//                                                         .petProfileDetails));
//                                           },
//                                         );
//                                         // return LostPage(
//                                         //     petProfileDetails:
//                                         //         _petProfileDetails);
//                                       },
//                                     ),
//                                   )
//                                       .then((value) {
//                                     setState(() {});
//                                   });
//                                 },
//                                 child: Hero(
//                                   tag: "lost${_petProfileDetails.profileId}",
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       // color: Theme.of(context).primaryColor,
//                                       // color: Colors.blue,
//                                       color: _petProfileDetails.petIsLost
//                                           ? HexColor("#A52A2A")
//                                           : HexColor("#958164"),
//                                       // border: Border.all(
//                                       //   width: 0,
//                                       //   color:
//                                       //       getCustomColors(context).hardBorder ??
//                                       //           Colors.transparent,
//                                       //   // strokeAlign: BorderSide.strokeAlignOutside,
//                                       // ),
//                                       borderRadius: BorderRadius.circular(18),
//                                       boxShadow: kElevationToShadow[6],
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(18),
//                                       child: Stack(
//                                         children: [
//                                           Align(
//                                             alignment: Alignment.bottomLeft,
//                                             child: Image.asset(
//                                               "assets/details_illustartions/lost_dog_1_cut.png",
//                                               scale: 2.5,
//                                             ),
//                                           ),
//                                           Column(
//                                             children: [
//                                               const GridSpacing(),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.end,
//                                                 children: [
//                                                   Expanded(
//                                                     child: AutoSizeText(
//                                                       "petPage_Lost".tr(),
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .titleLarge
//                                                           ?.copyWith(
//                                                               decoration: !_petProfileDetails
//                                                                       .petIsLost
//                                                                   ? TextDecoration
//                                                                       .lineThrough
//                                                                   : null,
//                                                               decorationColor:
//                                                                   Colors.white
//                                                                       .withOpacity(
//                                                                           0.9),
//                                                               decorationThickness:
//                                                                   6,
//                                                               color:
//                                                                   Colors.white),
//                                                       textAlign:
//                                                           TextAlign.right,
//                                                       maxLines: 1,
//                                                     ),
//                                                   ),
//                                                   const GridSpacing(),
//                                                 ],
//                                               ),
//                                               const SizedBox(height: 4),
//                                               widget.showDescriptions
//                                                   ? Expanded(
//                                                       child: Row(
//                                                         children: [
//                                                           const Spacer(
//                                                             flex: 1,
//                                                           ),
//                                                           Expanded(
//                                                             flex: 2,
//                                                             child: AutoSizeText(
//                                                               stepGranularity:
//                                                                   0.5,
//                                                               "petPage_LostInfo"
//                                                                   .tr(),
//                                                               style: Theme.of(
//                                                                       context)
//                                                                   .textTheme
//                                                                   .displaySmall
//                                                                   ?.copyWith(
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400,
//                                                                     color: Colors
//                                                                         .white
//                                                                         .withOpacity(
//                                                                             0.54),
//                                                                   ),
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .right,
//                                                             ),
//                                                           ),
//                                                           const GridSpacing(),
//                                                         ],
//                                                       ),
//                                                     )
//                                                   : const SizedBox.shrink(),
//                                               const GridSpacing(),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const GridSpacing(),
//                             GestureDetector(
//                               onTap: () {
//                                 navigatePerSlide(
//                                   context,
//                                   TagSelectionPage(
//                                     petProfile: _petProfileDetails,
//                                   ),
//                                 );
//                               },
//                               child: AspectRatio(
//                                 aspectRatio: 1,
//                                 child: Material(
//                                   borderRadius: BorderRadius.circular(18),
//                                   elevation: 4,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: getCustomColors(context).surface,
//                                       border: Border.all(
//                                         width: 0.5,
//                                         color: getCustomColors(context)
//                                                 .hardBorder ??
//                                             Colors.transparent,
//                                         // strokeAlign: BorderSide.strokeAlignOutside,
//                                       ),
//                                       borderRadius: BorderRadius.circular(18),
//                                       // boxShadow: kElevationToShadow[3],
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(18),
//                                       child: Stack(
//                                         children: [
//                                           Align(
//                                             alignment: Alignment.topRight,
//                                             child: Image.asset(
//                                               "assets/details_illustartions/gem_gold_1_cut.png",
//                                               scale: 8,
//                                             ),
//                                           ),
//                                           Align(
//                                             alignment: Alignment.bottomLeft,
//                                             child: Image.asset(
//                                               "assets/details_illustartions/gem_jade_1_cut.png",
//                                               scale: 9,
//                                             ),
//                                           ),
//                                           Align(
//                                             alignment:
//                                                 const Alignment(-1, -0.3),
//                                             child: Image.asset(
//                                               "assets/details_illustartions/heart_pink_1_cut.png",
//                                               scale: 8,
//                                             ),
//                                           ),
//                                           Align(
//                                             alignment: Alignment.bottomRight,
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(16),
//                                               child: AutoSizeText(
//                                                 "petPage_Tags".tr(),
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .titleLarge,
//                                                 textAlign: TextAlign.right,
//                                                 maxLines: 1,
//                                               ),
//                                             ),
//                                           ),
//                                           Align(
//                                             alignment: const Alignment(1, 0.6),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(16),
//                                               child: Row(
//                                                 children: [
//                                                   const Spacer(
//                                                     flex: 5,
//                                                   ),
//                                                   widget.showDescriptions
//                                                       ? Expanded(
//                                                           flex: 5,
//                                                           // child: Text(
//                                                           //   "petPage_TagsInfo"
//                                                           //       .tr(),
//                                                           //   style: Theme.of(
//                                                           //           context)
//                                                           //       .textTheme
//                                                           //       .displaySmall,
//                                                           //   textAlign:
//                                                           //       TextAlign.right,
//                                                           // ),
//                                                           child: (widget
//                                                                   .petProfileDetails
//                                                                   .tag
//                                                                   .isEmpty)
//                                                               ? Text(
//                                                                   "Keine Tags aktiv"
//                                                                       .tr(),
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .displaySmall,
//                                                                 )
//                                                               : Text(
//                                                                   "${widget.petProfileDetails.tag.length} Tag aktiv"
//                                                                       .tr(),
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .displaySmall,
//                                                                 ),
//                                                         )
//                                                       : const SizedBox.shrink(),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const GridSpacing(),
//                             GestureDetector(
//                               onTap: () {
//                                 navigatePerSlide(
//                                   context,
//                                   PicturesPage(
//                                     petProfileId: _petProfileDetails.profileId,
//                                     initialPetPictures:
//                                         _petProfileDetails.petPictures,
//                                   ),
//                                   callback: () => reloadPetProfileDetails(),
//                                 );
//                               },
//                               child: AspectRatio(
//                                 aspectRatio: 1,
//                                 child: Material(
//                                   borderRadius: BorderRadius.circular(18),
//                                   elevation: 4,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       // color: getCustomColors(context).surface,
//                                       color: Colors.yellow,
//                                       border: Border.all(
//                                         width: 0.3,
//                                         color: getCustomColors(context)
//                                                 .hardBorder ??
//                                             Colors.transparent,
//                                         strokeAlign:
//                                             BorderSide.strokeAlignOutside,
//                                       ),
//                                       borderRadius: BorderRadius.circular(18),
//                                       // boxShadow: kElevationToShadow[3],
//                                       image: const DecorationImage(
//                                         image: AssetImage(
//                                             "assets/details_illustartions/dog_picture_tmp.png"),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(18),
//                                       child: Align(
//                                         alignment: Alignment.bottomLeft,
//                                         child: ClipRRect(
//                                           borderRadius: const BorderRadius.only(
//                                             topRight: Radius.circular(18),
//                                           ),
//                                           child: BackdropFilter(
//                                             filter: ImageFilter.blur(
//                                                 sigmaX: 15, sigmaY: 15),
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 color: Theme.of(context)
//                                                     .primaryColor
//                                                     .withOpacity(0.5),
//                                                 borderRadius:
//                                                     const BorderRadius.only(
//                                                   topRight: Radius.circular(18),
//                                                 ),
//                                                 // border: Border.all(
//                                                 //   width: 0.3,
//                                                 //   color: getCustomColors(context)
//                                                 //           .hardBorder ??
//                                                 //       Colors.transparent,
//                                                 //   strokeAlign:
//                                                 //       BorderSide.strokeAlignOutside,
//                                                 // ),
//                                               ),
//                                               padding: const EdgeInsets.all(16),
//                                               child: AutoSizeText(
//                                                 "petPage_Pictures".tr(),
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .titleLarge,
//                                                 maxLines: 1,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const GridSpacing(),
//                     ],
//                   ),
//                   const GridSpacing(),
//                   Row(
//                     children: [
//                       const GridSpacing(),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             navigatePerSlide(
//                               context,
//                               BasicInformationPage(
//                                 petProfileDetails: _petProfileDetails,
//                                 reloadPetProfileDetails: () {
//                                   reloadPetProfileDetails();
//                                 },
//                                 setGender: (value) {
//                                   _petProfileDetails.petGender = value;
//                                   updatePetProfileCore(_petProfileDetails);
//                                 },
//                               ),
//                             );
//                           },
//                           child: AspectRatio(
//                             aspectRatio: 2 / 1,
//                             child: Material(
//                               borderRadius: BorderRadius.circular(18),
//                               elevation: 4,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: getCustomColors(context).surface,
//                                   border: Border.all(
//                                     width: 0.3,
//                                     color:
//                                         getCustomColors(context).hardBorder ??
//                                             Colors.transparent,
//                                     // strokeAlign: BorderSide.strokeAlignOutside,
//                                   ),
//                                   borderRadius: BorderRadius.circular(18),
//                                   // boxShadow: kElevationToShadow[3],
//                                 ),
//                                 // padding: const EdgeInsets.all(8.0),
//                                 child: Stack(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 16),
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(18),
//                                         child: Align(
//                                           alignment: Alignment.bottomRight,
//                                           child: Image.asset(
//                                               "assets/details_illustartions/basic_cat_1_cut.png"),
//                                         ),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: const Alignment(-0.5, 0.99),
//                                       child: Image.asset(
//                                         "assets/details_illustartions/basic_dog_1_cut.png",
//                                         scale: 1.5,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(16),
//                                       child: AutoSizeText(
//                                         "petPage_BasicInformation".tr(),
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleLarge,
//                                         maxLines: 1,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const GridSpacing(),
//                     ],
//                   ),
//                   const GridSpacing(),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const GridSpacing(),
//                       Expanded(
//                         child: Column(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 navigatePerSlide(
//                                   context,
//                                   DescriptionPage(
//                                     // descriptions:
//                                     //     _petProfileDetails.petDescription,
//                                     // petProfileId: _petProfileDetails.profileId,
//                                     petProfileDetails: _petProfileDetails,
//                                   ),
//                                 );
//                               },
//                               child: AspectRatio(
//                                 aspectRatio: 1,
//                                 child: Material(
//                                   borderRadius: BorderRadius.circular(18),
//                                   elevation: 4,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: getCustomColors(context).surface,
//                                       border: Border.all(
//                                         width: 0.3,
//                                         color: getCustomColors(context)
//                                                 .hardBorder ??
//                                             Colors.transparent,
//                                         // strokeAlign: BorderSide.strokeAlignOutside,
//                                       ),
//                                       borderRadius: BorderRadius.circular(18),
//                                       // boxShadow: kElevationToShadow[3],
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(18),
//                                       child: Stack(
//                                         children: [
//                                           Align(
//                                             alignment: Alignment.bottomLeft,
//                                             child: Image.asset(
//                                               "assets/details_illustartions/description_dog_1.png",
//                                               scale: 1.5,
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(16),
//                                             child: AutoSizeText(
//                                               "petPage_Description".tr(),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .titleLarge,
//                                               maxLines: 1,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const GridSpacing(),
//                             GestureDetector(
//                               onTap: () {
//                                 navigatePerSlide(
//                                   context,
//                                   DocumentPage(
//                                     initialDocuments:
//                                         _petProfileDetails.petDocuments,
//                                     petProfileId: _petProfileDetails.profileId,
//                                   ),
//                                   callback: () => reloadPetProfileDetails(),
//                                 );
//                               },
//                               child: AspectRatio(
//                                 aspectRatio: 1,
//                                 child: Material(
//                                   borderRadius: BorderRadius.circular(18),
//                                   elevation: 4,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: getCustomColors(context).surface,
//                                       border: Border.all(
//                                         width: 0.3,
//                                         color: getCustomColors(context)
//                                                 .hardBorder ??
//                                             Colors.transparent,
//                                         // strokeAlign: BorderSide.strokeAlignOutside,
//                                       ),
//                                       borderRadius: BorderRadius.circular(18),
//                                       // boxShadow: kElevationToShadow[3],
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(18),
//                                       child: Stack(
//                                         children: [
//                                           Align(
//                                             alignment:
//                                                 const Alignment(-0.95, 0.99),
//                                             child: Image.asset(
//                                               "assets/details_illustartions/documents_cat_1_cut.png",
//                                               scale: 1.4,
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(16),
//                                             child: AutoSizeText(
//                                               "petPage_Documents".tr(),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .titleLarge,
//                                               maxLines: 1,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const GridSpacing(),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             navigatePerSlide(
//                               context,
//                               MedicalPage(
//                                 petProfileDetails: _petProfileDetails,
//                               ),
//                             );
//                           },
//                           child: AspectRatio(
//                             aspectRatio: 1 / 2 - 8 / 100.w,
//                             child: Material(
//                               borderRadius: BorderRadius.circular(18),
//                               elevation: 4,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: getCustomColors(context).surface,
//                                   border: Border.all(
//                                     width: 0.5,
//                                     color:
//                                         getCustomColors(context).hardBorder ??
//                                             Colors.transparent,
//                                     // strokeAlign: BorderSide.strokeAlignOutside,
//                                   ),
//                                   borderRadius: BorderRadius.circular(18),
//                                   // boxShadow: kElevationToShadow[3],
//                                 ),
//                                 // padding: const EdgeInsets.all(8.0),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(18),
//                                   child: Stack(
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 8.0),
//                                         child: Align(
//                                           alignment: Alignment.bottomRight,
//                                           child: Image.asset(
//                                               "assets/details_illustartions/medical_1_cut.png"),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(16),
//                                         child: AutoSizeText(
//                                           "petPage_Medical".tr(),
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .titleLarge,
//                                           maxLines: 1,
//                                         ),
//                                       ),
//                                       //? Medical Info
//                                       // Align(
//                                       //   alignment: const Alignment(-1, -0.5),
//                                       //   child: Padding(
//                                       //     padding: const EdgeInsets.all(16),
//                                       //     child: Row(
//                                       //       children: [
//                                       //         widget.showDescriptions
//                                       //             ? Expanded(
//                                       //                 flex: 5,
//                                       //                 child: Text(
//                                       //                   "petPage_MedicalInfo"
//                                       //                       .tr(),
//                                       //                   style: Theme.of(context)
//                                       //                       .textTheme
//                                       //                       .displaySmall,
//                                       //                 ),
//                                       //               )
//                                       //             : const SizedBox.shrink(),
//                                       //         const Spacer(
//                                       //           flex: 5,
//                                       //         ),
//                                       //       ],
//                                       //     ),
//                                       //   ),
//                                       // ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const GridSpacing(),
//                     ],
//                   ),
//                   const GridSpacing(),
//                   const GridSpacing(),
//                   const AutoSaveInfo(),
//                   // const SizedBox(height: 90),
//                   const GridSpacing(),
//                   const GridSpacing(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class GridSpacing extends StatelessWidget {
//   const GridSpacing({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox(width: 16, height: 16);
//   }
// }

// class TabElement extends StatelessWidget {
//   const TabElement({
//     super.key,
//     required this.isActive,
//     required this.label,
//   });

//   final bool isActive;
//   final String label;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(
//           height: 16,
//         ),
//         Text(label),
//         const SizedBox(
//           height: 16,
//         ),
//         Container(
//           width: double.infinity,
//           height: 5,
//           decoration: BoxDecoration(
//             color: isActive ? Colors.pink : Colors.transparent,
//           ),
//         ),
//       ],
//     );
//   }
// }
