import 'dart:ui';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/language/m_language.dart';
import 'package:userapp/network_globals.dart';
import 'package:userapp/pets/pet_profile_preview_extended_actions.dart';
import 'package:userapp/pets/profile_details/g_profile_detail_globals.dart'
    as globals;
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/theme/custom_text_styles.dart';
import 'my_pets_navbar.dart';
import 'new_pet_profile.dart';
import 'page_transform.dart';
import 'pet_profile_preview.dart';
// import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

class MyPets extends StatefulWidget {
  const MyPets({
    super.key,
    required this.petProfiles,
    // required this.setAppBarNotchColor,
    required this.availableLanguages,
    required this.reloadFuture,
    required this.availableCountries,
  });

  final List<PetProfileDetails> petProfiles;

  final List<Language> availableLanguages;
  final List<Country> availableCountries;

  final VoidCallback reloadFuture;

  @override
  State<MyPets> createState() => _MyPetsState();
}

class _MyPetsState extends State<MyPets> {
  final PageController _controller = PageController();

  double pageindex = 0;
  // late Color backgroundColor;

  int? activeExtendedActions;

  // int _pictureIndex = 0;

  // List<NetworkImage> bgList = [
  //   NetworkImage("https://picsum.photos/600/800"),
  //   NetworkImage("https://picsum.photos/800"),
  // ];

  @override
  void initState() {
    super.initState();
    //InitAvailableLanguages and Countries
    globals.availableLanguages = List.from(widget.availableLanguages);
    globals.availableCountries = List.from(widget.availableCountries);

    _controller.addListener(() {
      setState(() {
        pageindex = _controller.page ?? 0;
        _closeExtendedActions();
      });
    });
  }

  @override
  void didUpdateWidget(covariant MyPets oldWidget) {
    super.didUpdateWidget(oldWidget);
    globals.availableLanguages = List.from(widget.availableLanguages);
    globals.availableCountries = List.from(widget.availableCountries);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _closeExtendedActions() {
    if (activeExtendedActions != null) {
      setState(() {
        activeExtendedActions = null;
      });
    }
  }

  // void precacheImages() {
  //   // for (var img in bgList) {
  //   //   precacheImage(img, context);
  //   // }
  // }

  String getBGPictureLink() {
    if (widget.petProfiles
        .elementAt(pageindex.round())
        .petPictures
        .isNotEmpty) {
      return s3BaseUrl +
          widget.petProfiles
              .elementAt(pageindex.round())
              .petPictures
              .first
              .petPictureLink;
    } else {
      //TODO reserve doggo pic
      return "https://picsum.photos/600/800";
    }
  }

  // String _bgPictureLink = "https://picsum.photos/600/800";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 80),
            switchInCurve: Curves.fastOutSlowIn,
            switchOutCurve: Curves.fastOutSlowIn,
            child: Container(
              key: ValueKey(pageindex.round()),
              // height: double.infinity,
              width: double.infinity,
              decoration: pageindex.round() < widget.petProfiles.length
                  ? BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          getBGPictureLink(),
                          // _bgPictureLink,
                        ),
                        fit: BoxFit.cover,
                        scale: 1.2,
                      ),
                    )
                  : null,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 15,
                  sigmaY: 15,
                ),
                child: Container(
                  color: Theme.of(context).canvasColor.withOpacity(0.60),
                  // color: Theme.of(context).canvasColor.withOpacity(0.0),
                ),
              ),
            ),
          ),
          SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _closeExtendedActions();
              },
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  const MyPetsNavbar(),
                  const SizedBox(height: 36),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                              dragDevices: {
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse,
                              },
                            ),
                            child: PageView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: _controller,
                              pageSnapping: true,
                              scrollDirection: Axis.vertical,
                              itemCount: widget.petProfiles.length + 1,
                              itemBuilder: (context, position) {
                                if (position == widget.petProfiles.length) {
                                  return PetProfilePreviewPageTransform(
                                    page: pageindex,
                                    position: position,
                                    maxRotation: 35,
                                    minScaling: 0.1,
                                    minOpacity: 0,
                                    child: NewPetProfile(
                                        // reloadFuture: () =>
                                        //     widget.reloadFuture.call(),
                                        ),
                                  );
                                } else {
                                  return PetProfilePreviewPageTransform(
                                    page: pageindex,
                                    position: position,
                                    maxRotation: 25,
                                    minScaling: 0.65,
                                    minOpacity: 0,
                                    child: PetProfilePreview(
                                      extendedActions: isExtendedIndexActive(
                                          activeExtendedActions, position),
                                      petProfileDetails: widget.petProfiles
                                          .elementAt(position),
                                      imageAlignmentOffset: -getAlignmentOffset(
                                          pageindex, position),
                                      // imageAlignmentOffset: 0,
                                      reloadFuture: () =>
                                          widget.reloadFuture.call(),
                                      switchExtendedActions: () {
                                        setState(() {
                                          if (activeExtendedActions !=
                                              position) {
                                            activeExtendedActions = position;
                                          } else {
                                            activeExtendedActions = null;
                                          }
                                        });
                                      },
                                      setPictureLink: (bgPictureLink) {
                                        // if (_bgPictureLink != bgPictureLink) {
                                        //   // print("PicturIndex: " +
                                        //   //     pictueIndex.toString());
                                        //   EasyDebounce.debounce(
                                        //     'emailLogwwinPage',
                                        //     const Duration(milliseconds: 250),
                                        //     () {
                                        //       WidgetsBinding.instance
                                        //           .addPostFrameCallback((_) {
                                        //         setState(() {
                                        //           _bgPictureLink =
                                        //               bgPictureLink;
                                        //         });
                                        //       });
                                        //     },
                                        //   );
                                        // }
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          // isExtendedIndexActive(
                          //         activeExtendedActions, pageindex.round())
                          //     ? Align(
                          //         alignment: const Alignment(1, 1),
                          //         child: DotsIndicator(
                          //           dotsCount: widget.petProfiles.length,
                          //           position: pageindex,
                          //           decorator: const DotsDecorator(
                          //             color: Colors.black87, // Inactive color
                          //             activeColor: Colors.redAccent,
                          //           ),
                          //         ),
                          //       )
                          //     : const SizedBox.shrink(),
                          //Blurs outgoung profile
                          ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                height: 5,
                                width: double.infinity,
                                color: Colors.transparent,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          pageindex.round() < widget.petProfiles.length
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: ExtendedSettingsContainer(
                    isActive: isInteger(pageindex),
                    petProfileDetails:
                        widget.petProfiles.elementAt(pageindex.round()),
                    reloadFuture: () => widget.reloadFuture.call(),
                  ),
                )
              : const SizedBox.shrink(),
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Text(
          //     "Taco",
          //     style: getCustomTextStyles(context).homePetName,
          //   ),
          // ),
        ],
      ),
    );
  }
}

String getPetName(List<PetProfileDetails> petProfiles, index) {
  if (index < petProfiles.length) {
    return petProfiles.elementAt(index).petName;
  } else {
    return "";
  }
}

bool isExtendedIndexActive(int? extendedActions, int index) {
  if (extendedActions == null) {
    return false;
  } else {
    if (extendedActions == index) {
      return true;
    } else {
      return false;
    }
  }
}

bool isInteger(double value) {
  print(value);
  return value == value.roundToDouble();
}
