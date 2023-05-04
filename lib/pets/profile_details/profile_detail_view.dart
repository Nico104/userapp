import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:userapp/pets/profile_details/c_pet_name.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/profile_details/pages/contact_page.dart';
import 'package:userapp/pets/profile_details/pages/documents_page.dart';
import 'package:userapp/pets/profile_details/pages/images_page.dart';
import 'package:userapp/pets/profile_details/pages/profile_info_page.dart';
import 'fabs/upload_document_fab.dart';
import 'fabs/upload_image_fab.dart';
import 'u_profile_details.dart';

import 'package:flutter/scheduler.dart' show timeDilation;

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

class PetProfileDetailViewState extends State<PetProfileDetailView> {
  final PageController _pageController = PageController();
  double pageindex = 0;

  final List<ScrollController> _scrollControllers =
      List.filled(4, ScrollController());

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        pageindex = _pageController.page ?? 0;
      });
    });

    // _petProfileDetails = widget.petProfileDetails.clone();
    if (widget.petProfileDetails.petName == null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          askForPetName(
              context,
              (value) => setState(() {
                    // _petProfileDetails.petName = value;
                    widget.petProfileDetails.petName = value;
                  }),
              null);
        },
      );
    }
  }

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder();
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;
  // EdgeInsets padding = const EdgeInsets.all(12);
  EdgeInsets padding = const EdgeInsets.all(0);

  // int _selectedItemPosition = 2;
  SnakeShape snakeShape = SnakeShape.indicator;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: snakeBarStyle,
          snakeShape: snakeShape,
          shape: bottomBarShape,
          padding: padding,
          elevation: 16,

          ///configuration for SnakeNavigationBar.color
          snakeViewColor: selectedColor,
          selectedItemColor:
              snakeShape == SnakeShape.indicator ? selectedColor : null,
          unselectedItemColor: Colors.blueGrey,

          ///configuration for SnakeNavigationBar.gradient
          //snakeViewGradient: selectedGradient,
          //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
          //unselectedItemGradient: unselectedGradient,

          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,

          // currentIndex: _index,
          currentIndex: pageindex.round(),
          // onTap: (index) => setState(() => _index = index),
          onTap: (value) {
            // _pageController.animateToPage(value,
            //     duration: const Duration(milliseconds: 125),
            //     curve: Curves.fastOutSlowIn);
            print(value);
            _pageController.jumpToPage(value);
            _scrollControllers.elementAt(value).animateTo(0,
                duration: const Duration(milliseconds: 125),
                curve: Curves.fastOutSlowIn);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'tickets'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'calendar'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.safety_check), label: 'microphone'),
          ],
        ),
        // appBar: AppBar(
        //   title: Text('appBarTitleProfileDetails'.tr()),
        //   // scrolledUnderElevation: 16,
        //   elevation: isScrollTop ? 0 : 16,
        //   bottom: _enableTopTabBar && pageindex == 0
        //       ? TabBar(
        //           dividerColor: Colors.grey.shade400,
        //           indicatorColor: Colors.black,
        //           tabs: const [
        //             Tab(icon: Icon(Icons.directions_car)),
        //             Tab(icon: Icon(Icons.directions_bike)),
        //           ],
        //           onTap: (value) {
        //             setState(() {
        //               _imageView = value;
        //             });
        //           },
        //         )
        //       : null,
        // ),
        floatingActionButton: getFloatingActionButton(pageindex.round()),
        // floatingActionButton: SaveFloatingActionButton(
        //   petProfileDetails: _petProfileDetails,
        //   oldPetProfileDetails: widget.petProfileDetails,
        //   reloadFuture: () => widget.reloadFuture.call(),
        // ),
        extendBodyBehindAppBar: false,
        extendBody: false,
        resizeToAvoidBottomInset: true,
        // body: ListView(
        //   shrinkWrap: true,
        //   // controller: _scrollSontroller,
        //   children: [
        //     const SizedBox(height: 28),
        //     AnimatedSwitcher(
        //       duration: const Duration(milliseconds: 0),
        //       transitionBuilder: (Widget child, Animation<double> animation) {
        //         return SlideTransition(
        //           position: Tween(
        //             begin: const Offset(1, 0),
        //             end: const Offset(0, 0),
        //           ).animate(animation),
        //           child: child,
        //         );
        //       },
        //       child: getPage(_index, getImagesPage(), getProfileInfoPage(),
        //           getContactPage(), getDocumentsPage()),
        //     ),
        //     PageView(
        //       controller: _pageController,
        //       children: [
        //         getImagesPage(),
        //         getProfileInfoPage(),
        //         getContactPage(),
        //         getDocumentsPage(),
        //       ],
        //     ),
        //     const SizedBox(
        //       height: 16,
        //     )
        //     //Wait for connection to Server for important info, maybe you can reuse the Description Model
        //   ],
        // ),
        body: PageView(
          controller: _pageController,
          children: [
            // getImagesPage(),
            ProfileDetailsImagePage(
              scrollController: _scrollControllers.elementAt(0),
              getProfileDetails: widget.getProfileDetails,
              removePetPicture: (index) async {
                await deletePicture(
                    widget.getProfileDetails().petPictures.elementAt(index));
                //TODO update UI
                //hekps against 403 from server
                widget.reloadFuture.call();
                Future.delayed(Duration(milliseconds: 100))
                    .then((value) => refresh());
              },
            ),
            ProfileInfoPage(
              scrollController: _scrollControllers.elementAt(1),
              petProfileDetails: widget.petProfileDetails,
            ),
            ContactPage(
              scrollController: _scrollControllers.elementAt(2),
              petProfileDetails: widget.petProfileDetails,
            ),
            DocumentsPage(
              scrollController: _scrollControllers.elementAt(3),
              petProfileDetails: widget.petProfileDetails,
            ),
          ],
        ),
      ),
    );
  }

  Widget? getFloatingActionButton(int index) {
    switch (index) {
      case 0:
        return UploadImageFab(
          addPetPicture: (value) async {
            await uploadPicture(
              widget.petProfileDetails.profileId!,
              value,
              () {
                print("uplaoded");
                // setState(() {});
                // await Future.delayed(Duration(seconds: 8));
                widget.reloadFuture.call();
                //TODO update UI
                //hekps against 403 from server
                Future.delayed(Duration(milliseconds: 850))
                    .then((value) => refresh());
              },
            );
          },
        );
      case 3:
        return UploadDocumentFab(
          addDocument: (value, filename, documentType, contentType) async {
            await uploadDocuments(
              widget.petProfileDetails.profileId!,
              value,
              filename,
              documentType,
              contentType,
              () {
                print("uplaoded");
                // setState(() {});
                // await Future.delayed(Duration(seconds: 8));
                widget.reloadFuture.call();
                //TODO update UI
                //hekps against 403 from server
                Future.delayed(Duration(milliseconds: 850))
                    .then((value) => refresh());
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



/*
Widget getImagesPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('appBarTitleProfileDetails'.tr()),
        // scrolledUnderElevation: 16,
        elevation: isScrollTop ? 0 : 16,
        bottom: _enableTopTabBar
            ? TabBar(
                dividerColor: Colors.grey.shade400,
                indicatorColor: Colors.black,
                tabs: const [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
                onTap: (value) {
                  setState(() {
                    _imageView = value;
                  });
                },
              )
            : null,
      ),
      body: SingleChildScrollView(
        controller: _scrollControllers.elementAt(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PaddingComponent(
              ignoreLeftPadding: true,
              child: Center(
                child: Container(
                  width: 90.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: kElevationToShadow[4],
                    image: const DecorationImage(
                      image: NetworkImage("https://picsum.photos/512"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // SnakeNavigationBar.color(
            //   behaviour: _snakeBarStyle,
            //   snakeShape: _snakeShape,
            //   shape: _bottomBarShape,
            //   padding: _padding,
            //   elevation: 4,

            //   ///configuration for SnakeNavigationBar.color
            //   snakeViewColor: _selectedColor,
            //   selectedItemColor:
            //       _snakeShape == SnakeShape.indicator ? _selectedColor : null,
            //   unselectedItemColor: Colors.blueGrey,

            //   ///configuration for SnakeNavigationBar.gradient
            //   //snakeViewGradient: selectedGradient,
            //   //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
            //   //unselectedItemGradient: unselectedGradient,

            //   // showUnselectedLabels: _showUnselectedLabels,
            //   // showSelectedLabels: _showSelectedLabels,

            //   currentIndex: _index,
            //   // onTap: (index) => setState(() => _index = index),
            //   items: const [
            //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            //     BottomNavigationBarItem(
            //         icon: Icon(Icons.safety_check), label: 'microphone'),
            //   ],
            // ),
            VisibilityDetector(
              key: const Key('scoll-edit-tabs'),
              onVisibilityChanged: (visibilityInfo) {
                var visiblePercentage = visibilityInfo.visibleFraction * 100;
                debugPrint(
                    'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
                if (visiblePercentage == 100 || pageindex != 0) {
                  setState(() {
                    _enableTopTabBar = false;
                  });
                } else {
                  setState(() {
                    _enableTopTabBar = true;
                  });
                }
              },
              child: TabBar(
                dividerColor: Colors.grey.shade400,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
                onTap: (value) {
                  setState(() {
                    _imageView = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            PaddingComponent(
              ignoreLeftPadding: true,
              child: PetPicturesComponent(
                petPictures: widget.getProfileDetails().petPictures,
                removePetPicture: (index) async {
                  await deletePicture(
                      widget.getProfileDetails().petPictures.elementAt(index));
                  //TODO update UI
                  //hekps against 403 from server
                  widget.reloadFuture.call();
                  Future.delayed(Duration(milliseconds: 100))
                      .then((value) => refresh());
                },
                imageView: _imageView,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getProfileInfoPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('appBarTitleProfileDetails'.tr()),
        scrolledUnderElevation: 8,
      ),
      body: SingleChildScrollView(
        controller: _scrollControllers.elementAt(1),
        child: Column(
          key: const ValueKey("PetInfo"),
          mainAxisSize: MainAxisSize.min,
          children: [
            PaddingComponent(
              child: PetNameComponent(
                petProfileId: _petProfileDetails.profileId,
                petName: _petProfileDetails.petName,
                setPetName: (value) {
                  setState(() {
                    _petProfileDetails.petName = value;
                    widget.petProfileDetails.petName = value;
                  });
                  updatePetProfileCore(widget.petProfileDetails);
                },
                gender: _petProfileDetails.petGender,
                tag: _petProfileDetails.tag,
                setTags: (value) => setState(() {
                  _petProfileDetails.tag = value;
                }),
                collardimension: 120,
              ),
            ),
            PaddingComponent(
              child: OnelineSimpleInput(
                flex: 7,
                value: _petProfileDetails.petChipId ?? "",
                emptyValuePlaceholder: "977200000000000",
                title: "profileDetailsComponentTitleChipNumber".tr(),
                saveValue: (val) async {
                  _petProfileDetails.petChipId = val;
                  widget.petProfileDetails.petChipId = val;
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            PaddingComponent(
              child: PetGenderComponent(
                gender: _petProfileDetails.petGender,
                setGender: (value) {
                  setState(() {
                    _petProfileDetails.petGender = value;
                    widget.petProfileDetails.petGender = value;
                  });
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            PaddingComponent(
              child: PetImportantInformation(
                //Pass by reference
                imortantInformations:
                    _petProfileDetails.petImportantInformation,
              ),
            ),
            PaddingComponent(
              child: PetDescriptionComponent(
                //Pass by reference
                descriptions: _petProfileDetails.petDescription,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getContactPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('appBarTitleProfileDetails'.tr()),
        scrolledUnderElevation: 8,
      ),
      body: SingleChildScrollView(
        // controller: _scrollControllers.elementAt(2),
        child: Column(
          key: const ValueKey("Contact"),
          mainAxisSize: MainAxisSize.min,
          children: [
            PaddingComponent(
              child: OnelineSimpleInput(
                flex: 6,
                value: widget.petProfileDetails.petOwnerName ?? "",
                emptyValuePlaceholder: "Schlongus Longus",
                title: "profileDetailsComponentTitleOwnersName".tr(),
                saveValue: (val) async {
                  widget.petProfileDetails.petOwnerName = val;
                  print(widget.petProfileDetails.petOwnerName);
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            PaddingComponent(
              child: OnelineSimpleInput(
                flex: 8,
                value: widget.petProfileDetails.petOwnerLivingPlace ?? "",
                emptyValuePlaceholder: "Mainstreet 20A, Vienna, Austria",
                title: "profileDetailsComponentTitleHomeAddress".tr(),
                saveValue: (val) async {
                  widget.petProfileDetails.petOwnerLivingPlace = val;
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            PaddingComponent(
              child: PetPhoneNumbersComponent(
                phoneNumbers: _petProfileDetails.petOwnerTelephoneNumbers,
                petProfileId: _petProfileDetails.profileId,
              ),
            ),
            PaddingComponent(
              child: SocialMediaComponent(
                title: "profileDetailsComponentTitleSocialMedia".tr(),
                facebook: widget.petProfileDetails.petOwnerFacebook ?? "",
                saveFacebook: (val) async {
                  print(widget.petProfileDetails.petOwnerFacebook);
                  widget.petProfileDetails.petOwnerFacebook = val;
                  print(widget.petProfileDetails.petOwnerFacebook);
                  updatePetProfileCore(widget.petProfileDetails);
                },
                instagram: widget.petProfileDetails.petOwnerInstagram ?? "",
                saveInstagram: (val) async {
                  widget.petProfileDetails.petOwnerInstagram = val;
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            const SizedBox(
              height: 120,
            )
          ],
        ),
      ),
    );
  }

  Widget getDocumentsPage() {
    List<Document> allergies = _petProfileDetails.petDocuments
        .where((i) => i.documentLink.contains('allergies'))
        .toList();

    List<Document> dewormers = _petProfileDetails.petDocuments
        .where((i) => i.documentLink.contains('dewormers'))
        .toList();

    List<Document> health = _petProfileDetails.petDocuments
        .where((i) => i.documentLink.contains('health'))
        .toList();

    List<Document> medicine = _petProfileDetails.petDocuments
        .where((i) => i.documentLink.contains('medicine'))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('appBarTitleProfileDetails'.tr()),
        scrolledUnderElevation: 8,
      ),
      body: SingleChildScrollView(
        controller: _scrollControllers.elementAt(3),
        child: Column(
          key: const ValueKey("Documents"),
          mainAxisSize: MainAxisSize.min,
          children: [
            PaddingComponent(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 28),
                  const ComponentTitle(text: "Allergies"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: allergies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(allergies.elementAt(index).documentName),
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  const ComponentTitle(text: "Dewormers"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: dewormers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(dewormers.elementAt(index).documentName),
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  const ComponentTitle(text: "Health"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: health.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(health.elementAt(index).documentName),
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  const ComponentTitle(text: "Medicine"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: medicine.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(medicine.elementAt(index).documentName),
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  */