import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/feature/pets/profile_details/contact/contacts_pet_list_page.dart';
import 'package:userapp/feature/pets/profile_details/pages/edit_detail_pages/contact_page/contact_page.dart';
import 'package:userapp/feature/pets/profile_details/pages/pet_page%20copy%202.dart';
import 'package:userapp/feature/pets/profile_details/pages/pet_page.dart';
import 'package:userapp/feature/pets/profile_details/pictures/upload_picture_dialog.dart';
import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';
import 'fabs/upload_document_fab.dart';
import 'fabs/upload_image_fab.dart';
import 'u_profile_details.dart';

class PetProfileDetailView extends StatefulWidget {
  const PetProfileDetailView({
    super.key,
    required this.petProfileDetails,
    // required this.reloadFuture,
    // required this.getProfileDetails,
  });

  final PetProfileDetails petProfileDetails;

  // final VoidCallback reloadFuture;

  // final PetProfileDetails Function() getProfileDetails;

  @override
  State<PetProfileDetailView> createState() => PetProfileDetailViewState();
}

class PetProfileDetailViewState extends State<PetProfileDetailView>
    with TickerProviderStateMixin {
  // void refresh() {
  //   print("Tags: " + widget.getProfileDetails().tag.length.toString());
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    //Tom update on Tab Swipe
    tabController.addListener(_tabListener);
  }

  void _tabListener() {
    setState(() {});
  }

  final double _borderRadius = 42;
  bool _showBottomNavBar = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TabBarView(
          controller: tabController,
          children: [
            PetPage2(
              // getProfileDetails: widget.getProfileDetails,
              petProfileDetails: widget.petProfileDetails,
              showBottomNavBar: (show) {
                if (mounted && show != _showBottomNavBar) {
                  setState(() {
                    _showBottomNavBar = show;
                  });
                }
              },
              // reloadFuture: widget.reloadFuture,
              setPetName: (newName) {
                setState(() {
                  widget.petProfileDetails.petName = newName;
                });
                updatePetProfileCore(widget.petProfileDetails);
              },
            ),
            // ContactPage(
            //   // petProfileDetails: widget.getProfileDetails(),
            //   petProfileDetails: widget.petProfileDetails,
            //   showBottomNavBar: (show) {
            //     if (mounted && show != _showBottomNavBar) {
            //       setState(() {
            //         _showBottomNavBar = show;
            //       });
            //     }
            //   },
            // ),
          ],
        ),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 12),
        //   child: AnimatedAlign(
        //     alignment: _showBottomNavBar
        //         ? const Alignment(0.0, 1.0)
        //         : const Alignment(0.0, 3.0),
        //     duration: const Duration(milliseconds: 250),
        //     curve: Curves.fastOutSlowIn,
        //     child: Padding(
        //       padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        //       child: Material(
        //         borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        //         elevation: 8,
        //         child: Container(
        //           // height: 110,
        //           // width: double.infinity,
        //           // height: 80,
        //           // blur: 7,
        //           // width: 100,
        //           // elevation: 2,
        //           // padding: const EdgeInsets.all(16),
        //           // borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        //           decoration: BoxDecoration(
        //             borderRadius:
        //                 BorderRadius.all(Radius.circular(_borderRadius)),
        //             // boxShadow: kElevationToShadow[4],
        //             // color: Theme.of(context).primaryColor.withOpacity(1),
        //             color: Colors.blue,
        //           ),
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               // const SizedBox(height: 20),
        //               Padding(
        //                 padding: const EdgeInsets.all(16),
        //                 child: Text(
        //                   "    Tabo is lost    ",
        //                   style: TextStyle(
        //                     fontWeight: FontWeight.w500,
        //                     fontSize: 22,
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ),
        //               // Row(
        //               //   mainAxisSize: MainAxisSize.min,
        //               //   children: [
        //               //     const SizedBox(width: 32),
        //               //     GestureDetector(
        //               //       onTap: () {
        //               //         tabController.animateTo(
        //               //           0,
        //               //           duration: const Duration(milliseconds: 80),
        //               //           curve: Curves.fastOutSlowIn,
        //               //         );
        //               //         setState(() {});
        //               //       },
        //               //       child: Container(
        //               //         //To trigger the Hit Box
        //               //         color: Colors.transparent,
        //               //         child: Center(
        //               //           child: Icon(
        //               //             CustomIcons.edit,
        //               //             color: tabController.index == 0
        //               //                 ? Colors.blue
        //               //                 : Colors.black,
        //               //             size: 32,
        //               //           ),
        //               //         ),
        //               //       ),
        //               //     ),
        //               //     const SizedBox(width: 32),
        //               //     GestureDetector(
        //               //       onTap: () {
        //               //         tabController.animateTo(
        //               //           1,
        //               //           duration: const Duration(milliseconds: 80),
        //               //           curve: Curves.fastOutSlowIn,
        //               //         );
        //               //         setState(() {});
        //               //       },
        //               //       child: Container(
        //               //         //To trigger the Hit Box
        //               //         color: Colors.transparent,
        //               //         child: Center(
        //               //           child: Icon(
        //               //             CustomIcons.call,
        //               //             color: tabController.index == 1
        //               //                 ? Colors.blue
        //               //                 : Colors.black,
        //               //             size: 32,
        //               //           ),
        //               //         ),
        //               //       ),
        //               //     ),
        //               //     const SizedBox(width: 32),
        //               //   ],
        //               // ),
        //               // const SizedBox(height: 20),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

Widget getPage(
    int index, Widget page1, Widget page2, Widget page3, Widget page4) {
  switch (index) {
    case 0:
      return page1;
    case 1:
      return page2;
    case 2:
      return page3;
    case 3:
      return page4;
    default:
      return page1;
  }
}
