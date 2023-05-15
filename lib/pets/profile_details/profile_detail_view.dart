import 'package:flutter/material.dart';
// import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/profile_details/pages/pet_page.dart';
import 'package:userapp/pets/profile_details/pictures/upload_picture_dialog.dart';
import 'package:userapp/styles/custom_icons_icons.dart';
import 'fabs/upload_document_fab.dart';
import 'fabs/upload_image_fab.dart';
import 'u_profile_details.dart';

class PetProfileDetailView extends StatefulWidget {
  const PetProfileDetailView({
    super.key,
    required this.petProfileDetails,
    required this.reloadFuture,
    required this.getProfileDetails,
  });

  final PetProfileDetails petProfileDetails;

  final VoidCallback reloadFuture;

  final PetProfileDetails Function() getProfileDetails;

  @override
  State<PetProfileDetailView> createState() => PetProfileDetailViewState();
}

class PetProfileDetailViewState extends State<PetProfileDetailView>
    with TickerProviderStateMixin {
  void refresh() {
    print("Tags: " + widget.getProfileDetails().tag.length.toString());
    if (mounted) {
      setState(() {});
    }
  }

  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  final double _borderRadius = 42;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TabBarView(
          controller: tabController,
          children: [
            PetPage(
              getProfileDetails: widget.getProfileDetails,
            ),
            Container(
              color: Colors.blue,
              width: 100.w,
              height: 100.h,
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              // height: 110,
              // width: double.infinity,
              // height: 80,
              // blur: 7,
              // width: 100,
              // elevation: 2,
              // padding: const EdgeInsets.all(16),
              // borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
                boxShadow: kElevationToShadow[4],
                color: Theme.of(context).primaryColor.withOpacity(1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 32),
                      GestureDetector(
                        onTap: () {
                          tabController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 80),
                            curve: Curves.fastOutSlowIn,
                          );
                          setState(() {});
                        },
                        child: Container(
                          //To trigger the Hit Box
                          color: Colors.transparent,
                          child: Center(
                            child: Icon(
                              CustomIcons.edit,
                              color: tabController.index == 0
                                  ? Colors.blue
                                  : Colors.black,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                      GestureDetector(
                        onTap: () {
                          tabController.animateTo(
                            1,
                            duration: const Duration(milliseconds: 80),
                            curve: Curves.fastOutSlowIn,
                          );
                          setState(() {});
                        },
                        child: Container(
                          //To trigger the Hit Box
                          color: Colors.transparent,
                          child: Center(
                            child: Icon(
                              CustomIcons.call,
                              color: tabController.index == 1
                                  ? Colors.blue
                                  : Colors.black,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget? getFloatingActionButton(int index) {
    switch (index) {
      case 0:
        return UploadImageFab(
          addPetPicture: (value) async {
            //Loading Dialog Thingy
            BuildContext? dialogContext;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                dialogContext = context;
                return const UploadPictureDialog();
              },
            );
            await uploadPicture(
              widget.petProfileDetails.profileId,
              value,
              () async {
                print("uplaoded");
                widget.reloadFuture.call();
                //TODO update UI
                //hekps against 403 from server
                await Future.delayed(const Duration(milliseconds: 2000))
                    .then((value) => refresh());
                //Close Loading Dialog Thingy
                Navigator.pop(dialogContext!);
              },
            );
          },
        );
      case 3:
        return UploadDocumentFab(
          addDocument: (value, filename, documentType, contentType) async {
            // Loading Dialog Thingy
            BuildContext? dialogContext;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                dialogContext = context;
                return const UploadPictureDialog();
              },
            );
            await uploadDocuments(
              widget.petProfileDetails.profileId,
              value,
              filename,
              documentType,
              contentType,
              () async {
                print("uplaoded");
                widget.reloadFuture.call();
                //TODO update UI
                //hekps against 403 from server
                await Future.delayed(const Duration(milliseconds: 2000))
                    .then((value) => refresh());
                //Close Loading Dialog Thingy
                Navigator.pop(dialogContext!);
              },
            );
          },
        );
      default:
        return null;
    }
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
