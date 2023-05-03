import 'dart:typed_data';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/c_pet_name.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../pet_color/u_pet_colors.dart';
import '../../styles/text_styles.dart';
import '../../theme/custom_colors.dart';
import 'c_component_padding.dart';
import 'c_component_title.dart';
import 'c_description.dart';
import 'c_edit_pages.dart';
import 'c_important_information.dart';
import 'c_one_line_simple_input.dart';
import 'c_pet_gender.dart';
import 'c_phone_number.dart';
import 'fabs/upload_document_fab.dart';
import 'fabs/upload_image_fab.dart';
import 'models/m_document.dart';
import 'pictures/c_pictures.dart';
import 'c_section_title.dart';
import 'c_social_media.dart';
import 'save_button/save_floating_action_button.dart';
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
  //TODO prob. not needed
  late PetProfileDetails _petProfileDetails;
  List<Uint8List> newPictures = List<Uint8List>.empty(growable: true);

  bool isScrollTop = true;
  final _scrollSontroller = ScrollController();

  int _index = 0;
  bool _enableTopTabBar = false;

  void refresh() {
    print("refresh");
    if (mounted) {
      print("mounted");
      setState(() {});
      print("${widget.getProfileDetails().petPictures.length} Pictures22");
    }
  }

  @override
  void initState() {
    super.initState();

    _petProfileDetails = widget.petProfileDetails.clone();
    if (widget.petProfileDetails.petName == null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          askForPetName(
              context,
              (value) => setState(() {
                    _petProfileDetails.petName = value;
                  }),
              null);
        },
      );
    }

    // Setup Scroll Listener dfor AppBarDivider
    _scrollSontroller.addListener(() {
      bool isTop = _scrollSontroller.position.pixels == 0;
      if (isTop) {
        if (!isScrollTop) {
          setState(() {
            isScrollTop = true;
          });
        }
      } else {
        if (isScrollTop) {
          setState(() {
            isScrollTop = false;
          });
        }
      }
    });
  }

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
      // borderRadius: BorderRadius.all(Radius.circular(25)),
      );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;
  // EdgeInsets padding = const EdgeInsets.all(12);
  EdgeInsets padding = const EdgeInsets.all(0);

  // int _selectedItemPosition = 2;
  SnakeShape snakeShape = SnakeShape.indicator;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.black;
  // Color unselectedColor = Colors.blueGrey;

  // Gradient selectedGradient =
  // const LinearGradient(colors: [Colors.red, Colors.amber]);
  // Gradient unselectedGradient =
  // const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  // Color? containerColor;
  // List<Color> containerColors = [
  //   const Color(0xFFFDE1D7),
  //   const Color(0xFFE4EDF5),
  //   const Color(0xFFE7EEED),
  //   const Color(0xFFF4E4CE),
  // ];

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

          currentIndex: _index,
          onTap: (index) => setState(() => _index = index),
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
        appBar: AppBar(
          title: Text('appBarTitleProfileDetails'.tr()),
          flexibleSpace: !isScrollTop
              ? ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      color: Colors.transparent,
                      height: double.infinity,
                    ),
                  ),
                )
              : null,
          bottom: _enableTopTabBar
              ? TabBar(
                  tabs: const [
                    Tab(icon: Icon(Icons.directions_car)),
                    Tab(icon: Icon(Icons.directions_transit)),
                    Tab(icon: Icon(Icons.directions_bike)),
                    Tab(icon: Icon(Icons.directions_bike)),
                  ],
                  onTap: (value) {
                    // print(value);
                    setState(() {
                      _index = value;
                    });
                  },
                )
              : null,
        ),
        floatingActionButton: getFloatingActionButton(_index),
        // floatingActionButton: SaveFloatingActionButton(
        //   petProfileDetails: _petProfileDetails,
        //   oldPetProfileDetails: widget.petProfileDetails,
        //   reloadFuture: () => widget.reloadFuture.call(),
        // ),
        extendBodyBehindAppBar: false,
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: ListView(
          shrinkWrap: true,
          controller: _scrollSontroller,
          children: [
            const SizedBox(height: 28),
            // Row(
            //   children: [
            //     //Name and Tag
            //     Expanded(
            //       child: PaddingComponent(
            //         child: PetNameComponent(
            //           petProfileId: _petProfileDetails.profileId,
            //           petName: _petProfileDetails.petName,
            //           setPetName: (value) => setState(() {
            //             _petProfileDetails.petName = value;
            //           }),
            //           gender: _petProfileDetails.petGender,
            //           tag: _petProfileDetails.tag,
            //           setTags: (value) => setState(() {
            //             _petProfileDetails.tag = value;
            //           }),
            //           collardimension: 120,
            //         ),
            //       ),
            //     ),
            //     PaddingComponent(
            //       ignoreLeftPadding: true,
            //       child: Center(
            //         child: Container(
            //           width: 20.w,
            //           height: 20.w,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(14),
            //             boxShadow: kElevationToShadow[4],
            //             image: const DecorationImage(
            //               image: NetworkImage("https://picsum.photos/512"),
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            //Pages
            // VisibilityDetector(
            //   key: const Key('scoll-edit-tabs'),
            //   onVisibilityChanged: (visibilityInfo) {
            //     var visiblePercentage = visibilityInfo.visibleFraction * 100;
            //     debugPrint(
            //         'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
            //     if (visiblePercentage == 100) {
            //       setState(() {
            //         _enableTopTabBar = false;
            //       });
            //     } else {
            //       setState(() {
            //         _enableTopTabBar = true;
            //       });
            //     }
            //   },
            //   child: TabBar(
            //     tabs: const [
            //       Tab(icon: Icon(Icons.image)),
            //       Tab(icon: Icon(Icons.info_outline)),
            //       Tab(icon: Icon(Icons.phone)),
            //       Tab(icon: Icon(Icons.edit_document)),
            //     ],
            //     indicatorColor: getCustomColors(context).accent,
            //     onTap: (value) {
            //       // print(value);
            //       setState(() {
            //         _index = value;
            //       });
            //     },
            //   ),
            // ),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 0),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween(
                    begin: const Offset(1, 0),
                    end: const Offset(0, 0),
                  ).animate(animation),
                  child: child,
                );
              },
              child: getPage(_index, getImagesPage(), getProfileInfoPage(),
                  getContactPage(), getDocumentsPage()),
            ),
            const SizedBox(
              height: 16,
            )
            //Wait for connection to Server for important info, maybe you can reuse the Description Model
          ],
        ),
      ),
    );
  }

  Widget getImagesPage() {
    ShapeBorder? _bottomBarShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );
    SnakeBarBehaviour _snakeBarStyle = SnakeBarBehaviour.pinned;
    EdgeInsets _padding = const EdgeInsets.all(0);

    // int _selectedItemPosition = 2;
    SnakeShape _snakeShape = SnakeShape.circle;

    bool _showSelectedLabels = false;
    bool _showUnselectedLabels = false;

    Color _selectedColor = Colors.black;

    return Column(
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
        TabBar(
          dividerColor: Colors.grey.shade400,
          indicatorColor: Colors.black,
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_bike)),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        PaddingComponent(
          ignoreLeftPadding: true,
          child: PetPicturesComponent(
            imageHeight: 178,
            imageWidth: 178,
            imageBorderRadius: 14,
            imageSpacing: 20,
            petPictures: widget.getProfileDetails().petPictures,
            setPetPictures: (value) => _petProfileDetails.petPictures,
            newPetPictures: newPictures,
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
        ),
      ],
    );
  }

  Widget getProfileInfoPage() {
    return Column(
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
            imortantInformations: _petProfileDetails.petImportantInformation,
          ),
        ),
        PaddingComponent(
          child: PetDescriptionComponent(
            //Pass by reference
            descriptions: _petProfileDetails.petDescription,
          ),
        ),
      ],
    );
  }

  Widget getContactPage() {
    return Column(
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
      ],
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

    return Column(
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
    );
  }

  Widget? getFloatingActionButton(int index) {
    switch (index) {
      case 0:
        return UploadImageFab(
          addPetPicture: (value) async {
            await uploadPicture(
              _petProfileDetails.profileId!,
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
              _petProfileDetails.profileId!,
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
