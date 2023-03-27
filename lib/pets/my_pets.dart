import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:userapp/language/m_language.dart';
import 'package:userapp/pets/profile_details/g_profile_detail_globals.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import '../pet_color/u_pet_colors.dart';
import '../styles/text_styles.dart';
import 'my_pets_navbar.dart';
import 'new_pet_profile.dart';
import 'page_transform.dart';
import 'pet_profile_preview.dart';
import 'tag/new_tag/d_assign_tag.dart';
// import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;

class MyPets extends StatefulWidget {
  const MyPets({
    super.key,
    required this.petProfiles,
    // required this.setAppBarNotchColor,
    required this.availableLanguages,
    required this.reloadFuture,
  });

  final List<PetProfileDetails> petProfiles;
  // final ValueSetter<Color> setAppBarNotchColor;

  final List<Language> availableLanguages;

  final VoidCallback reloadFuture;

  @override
  State<MyPets> createState() => _MyPetsState();
}

class _MyPetsState extends State<MyPets> {
  final PageController _controller = PageController(
    viewportFraction: 0.87,
  );

  double pageindex = 0;
  // late Color backgroundColor;

  int? activeExtendedActions;

  // late List<GlobalKey<PetProfilePreviewState>> pageKeys;

  @override
  void initState() {
    super.initState();
    //InitAvailableLanguages
    availableLanguages = List.from(widget.availableLanguages);

    _controller.addListener(() {
      setState(() {
        pageindex = _controller.page ?? 0;
        // backgroundColor = getColor(widget.petProfiles, pageindex);
        _closeExtendedActions();
        // print(pageindex);
      });
      // widsget.setAppBarNotchColor(getColor(widget.petProfiles, pageindex));
    });

    // backgroundColor = getColor(widget.petProfiles, pageindex);
    // WidgetsBinding.instance.addPostFrameCallback((_) =>
    //     widget.setAppBarNotchColor(getColor(widget.petProfiles, pageindex)));
  }

  @override
  void didUpdateWidget(covariant MyPets oldWidget) {
    super.didUpdateWidget(oldWidget);
    availableLanguages = List.from(widget.availableLanguages);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColor,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.fastOutSlowIn,
            switchOutCurve: Curves.fastOutSlowIn,
            child: Container(
              key: ValueKey(pageindex.round()),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage((pageindex.round() == 0)
                      ? "https://picsum.photos/600/800"
                      : "https://picsum.photos/800"),
                  fit: BoxFit.cover,
                  scale: 1.2,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 15,
                  sigmaY: 15,
                ),
                child: Container(
                  color: Colors.white.withOpacity(0.50),
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
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: const Alignment(0, -0.5),
                      // margin: const EdgeInsets.only(bottom: 24, top: 24),
                      child: SizedBox(
                        // height: 80.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              //? Only for web testin needed, not for app!
                              child: ScrollConfiguration(
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
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.petProfiles.length + 1,
                                  itemBuilder: (context, position) {
                                    if (position == widget.petProfiles.length) {
                                      return PetProfilePreviewPageTransform(
                                        page: pageindex,
                                        position: position,
                                        maxRotation: 15,
                                        minScaling: 0.9,
                                        child: NewPetProfile(
                                          reloadFuture: () =>
                                              widget.reloadFuture.call(),
                                        ),
                                      );
                                    } else {
                                      return PetProfilePreviewPageTransform(
                                        page: pageindex,
                                        position: position,
                                        maxRotation: 15,
                                        minScaling: 0.9,
                                        child: PetProfilePreview(
                                          extendedActions:
                                              isExtendedIndexActive(
                                                  activeExtendedActions,
                                                  position),
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
                                              if (activeExtendedActions !=
                                                  position) {
                                                activeExtendedActions =
                                                    position;
                                              } else {
                                                activeExtendedActions = null;
                                              }
                                            });
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // (activeExtendedActions == null)
                  //     ? AnimatedSwitcher(
                  //         duration: const Duration(milliseconds: 80),
                  //         // transitionBuilder:
                  //         //     (Widget child, Animation<double> animation) {
                  //         //   // return SlideTransition(
                  //         //   //   child: child,
                  //         //   //   position: Tween<Offset>(
                  //         //   //           begin: Offset(0.0, -0.5), end: Offset(0.0, 0.0))
                  //         //   //       .animate(animation),
                  //         //   // );
                  //         //   return FadeTransition(
                  //         //     key: ValueKey<Key?>(child.key),
                  //         //     opacity: animation,
                  //         //     child: child,
                  //         //   );
                  //         // },
                  //         child: Text(
                  //           getPetName(widget.petProfiles, pageindex.round()),
                  //           key: ValueKey<String>(getPetName(
                  //               widget.petProfiles, pageindex.round())),
                  //           style: homePetName,
                  //         ),
                  //       )
                  //     : const SizedBox(),
                  // AnimatedSize(
                  //   duration: const Duration(milliseconds: 125),
                  //   curve: Curves.fastOutSlowIn,
                  //   child: SizedBox(
                  //     width:
                  //         (activeExtendedActions == pageindex.round()) ? 0 : null,
                  //     height:
                  //         (activeExtendedActions == pageindex.round()) ? 0 : null,
                  //     child: AnimatedSwitcher(
                  //       duration: const Duration(milliseconds: 80),
                  //       // transitionBuilder:
                  //       //     (Widget child, Animation<double> animation) {
                  //       //   // return SlideTransition(
                  //       //   //   child: child,
                  //       //   //   position: Tween<Offset>(
                  //       //   //           begin: Offset(0.0, -0.5), end: Offset(0.0, 0.0))
                  //       //   //       .animate(animation),
                  //       //   // );
                  //       //   return FadeTransition(
                  //       //     key: ValueKey<Key?>(child.key),
                  //       //     opacity: animation,
                  //       //     child: child,
                  //       //   );
                  //       // },
                  //       child: Text(
                  //         getPetName(widget.petProfiles, pageindex.round()),
                  //         key: ValueKey<String>(
                  //             getPetName(widget.petProfiles, pageindex.round())),
                  //         style: homePetName,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 28,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String getPetName(List<PetProfileDetails> petProfiles, index) {
  if (index < petProfiles.length) {
    return petProfiles.elementAt(index).petName ?? "";
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
