import 'dart:ui';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/language/m_language.dart';
import 'package:userapp/pets/pet_profile_preview_extended_actions.dart';
import 'package:userapp/pets/profile_details/g_profile_detail_globals.dart';
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
      // viewportFraction: 0.87,
      // viewportFraction: 1,
      );

  double pageindex = 0;
  // late Color backgroundColor;

  int? activeExtendedActions;

  List<NetworkImage> bgList = [
    NetworkImage("https://picsum.photos/600/800"),
    NetworkImage("https://picsum.photos/800"),
  ];

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
    WidgetsBinding.instance.addPostFrameCallback((_) => precacheImages());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImages();
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

  void precacheImages() {
    for (var img in bgList) {
      precacheImage(img, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.fastOutSlowIn,
            switchOutCurve: Curves.fastOutSlowIn,
            child: Container(
              key: ValueKey(pageindex.round()),
              // height: double.infinity,
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
                                      reloadFuture: () =>
                                          widget.reloadFuture.call(),
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
                                      // dotCount: widget.petProfiles.length,
                                      // dotPosition: position.toDouble(),
                                      image: NetworkImage(
                                          (pageindex.round() == 0)
                                              ? "https://picsum.photos/600/800"
                                              : "https://picsum.photos/800"),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: ExtendedSettingsContainer(
              isActive: isInteger(pageindex),
              petProfileDetails:
                  widget.petProfiles.elementAt(pageindex.round()),
              reloadFuture: () {},
            ),
          ),
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

bool isInteger(double value) {
  print(value);
  return value == value.roundToDouble();
}
