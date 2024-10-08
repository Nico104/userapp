import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/models/m_social_media.dart';
import 'package:userapp/general/network_globals.dart';
import 'package:userapp/general/utils_color/hex_color.dart';
import 'package:userapp/feature/pets/profile_details/g_profile_detail_globals.dart'
    as globals;
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/general/utils_theme/theme_provider.dart';
import 'package:userapp/general/utils_theme/themes.dart';
import '../language/m_language.dart';
import '../navigation_peppi/pet_profile_preview_extended_actions.dart';
import 'my_pets_navbar/my_pets_navbar.dart';
import '../pets/new_pet_profile.dart';
import '../pets/page_transform.dart';
import '../pets/pet_profile_preview.dart';
// import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

class MyPets extends StatefulWidget {
  const MyPets({
    super.key,
    required this.petProfiles,
    // required this.setAppBarNotchColor,
    required this.availableLanguages,
    required this.reloadFuture,
    required this.availableCountries,
    required this.availableSocialMedias,
  });

  final List<PetProfileDetails> petProfiles;

  final List<Language> availableLanguages;
  final List<Country> availableCountries;
  final List<SocialMedia> availableSocialMedias;

  final VoidCallback reloadFuture;

  @override
  State<MyPets> createState() => _MyPetsState();
}

class _MyPetsState extends State<MyPets> {
  final PageController _controller = PageController();

  double pageindex = 0;
  int? activeExtendedPicture;

  late String newPetBG;

  final GlobalKey<ExtendedSettingsContainerState> _navigationPeppiKey =
      GlobalKey<ExtendedSettingsContainerState>();

  @override
  void initState() {
    super.initState();
    //InitAvailableLanguages and Countries
    globals.availableLanguages = List.from(widget.availableLanguages);
    globals.availableCountries = List.from(widget.availableCountries);
    globals.availableSocialMedias = List.from(widget.availableSocialMedias);

    newPetBG = getNewPetBG();

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
    if (activeExtendedPicture != null) {
      setState(() {
        activeExtendedPicture = null;
      });
    }
    _navigationPeppiKey.currentState?.resetNavigationPeppi();
  }

  // void precacheImages() {
  //   // for (var img in bgList) {
  //   //   precacheImage(img, context);
  //   // }
  // }

  String bglink = "";

  String getBGPictureLink() {
    EasyDebounce.debounce(
      'bgimage',
      Duration(milliseconds: 200),
      () {
        if (widget.petProfiles
            .elementAt(pageindex.round())
            .petPictures
            .isNotEmpty) {
          setState(() {
            bglink = s3BaseUrl +
                widget.petProfiles
                    .elementAt(pageindex.round())
                    .petPictures
                    .first
                    .petPictureLink;
          });
        } else {
          setState(() {
            bglink = getfallbackBGImageLink(pageindex.round());
          });
        }
      },
    );
    return bglink;
  }

  String getfallbackBGImageLink(int index) {
    return "${s3BaseUrl}utils/temp/placeholder/pet_placeholder_${(index % 2) + 1}.jpg";
  }

  String getNewPetBG() {
    var rng = Random();
    return "${s3BaseUrl}utils/new_pet_bg/new_pet_bg_${rng.nextInt(12) + 1}.jpg";
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     systemNavigationBarColor: Colors.transparent,
    //   ),
    // );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // value: SystemUiOverlayStyle(
      //   // statusBarColor: Colors.transparent,
      //   systemNavigationBarColor:
      //       Theme.of(context).primaryColor.withOpacity(0.01),
      //   // systemNavigationBarIconBrightness: Brightness.dark,
      // ),
      value: Theme.of(context).appBarTheme.systemOverlayStyle!.copyWith(
            systemNavigationBarColor:
                Theme.of(context).primaryColor.withOpacity(0.01),
          ),
      child: Scaffold(
        // appBar: AppBar(
        //   systemOverlayStyle: SystemUiOverlayStyle(
        //     systemNavigationBarColor: Colors.blue, // Navigation bar
        //     statusBarColor: Colors.pink, // Status bar
        //   ),
        // ),

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
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              widget.petProfiles
                                      .elementAt(pageindex.round())
                                      .petPictures
                                      .isNotEmpty
                                  ? s3BaseUrl +
                                      widget.petProfiles
                                          .elementAt(pageindex.round())
                                          .petPictures
                                          .first
                                          .petPictureLink
                                  : getfallbackBGImageLink(pageindex.round()),
                              scale: 1.2,
                            ),
                          ),
                        )
                      : BoxDecoration(
                          color: HexColor("ebebd3"),
                          image: DecorationImage(
                            image: NetworkImage(
                              newPetBG,
                            ),
                            fit: BoxFit.cover,
                            alignment: Alignment.bottomCenter,
                            scale: 1,
                          ),
                        ),
                  child: ClipRRect(
                    child: pageindex.round() < widget.petProfiles.length
                        ? BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 15,
                              sigmaY: 15,
                            ),
                            child: Container(
                              width: double.infinity,
                              color: Theme.of(context)
                                  .canvasColor
                                  .withOpacity(0.5),
                              // Theme.of(context)
                              //     .canvasColor
                              //     .withOpacity(0.0),
                            ),
                          )
                        // : null,
                        : BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 5,
                            ),
                            child: Container(
                              color: Theme.of(context)
                                  .canvasColor
                                  .withOpacity(0.3),
                            ),
                          ),
                  )),
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
                    MyPetsNavbar(
                      reloadFuture: widget.reloadFuture,
                      petProfileDetails: widget.petProfiles.isNotEmpty
                          ? widget.petProfiles.first
                          : getDummyPetProfile(),
                    ),
                    const SizedBox(height: 36),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Stack(
                          children: [
                            ScrollConfiguration(
                              behavior:
                                  ScrollConfiguration.of(context).copyWith(
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
                                      //TODO set pageindex 1 after coming back to home
                                      child: NewPetProfile(
                                        reloadFuture: widget.reloadFuture,
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
                                        closeNavigationPeppi:
                                            _closeExtendedActions,
                                        extendedPicture: isExtendedIndexActive(
                                            activeExtendedPicture, position),
                                        petProfileDetails: widget.petProfiles
                                            .elementAt(position),
                                        imageAlignmentOffset:
                                            -getAlignmentOffset(
                                                pageindex, position),
                                        // imageAlignmentOffset: 0,
                                        reloadFuture: () =>
                                            widget.reloadFuture.call(),
                                        switchExtendedActions: () {
                                          setState(() {
                                            if (activeExtendedPicture !=
                                                position) {
                                              activeExtendedPicture = position;
                                            } else {
                                              activeExtendedPicture = null;
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
                                        fallBackImageLink:
                                            getfallbackBGImageLink(
                                                pageindex.round()),
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
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ExtendedSettingsContainer(
                          key: _navigationPeppiKey,
                          isActive: isInteger(pageindex),
                          petProfileDetails:
                              widget.petProfiles.elementAt(pageindex.round()),
                          reloadFuture: () => widget.reloadFuture.call(),
                        ),
                      ),
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
