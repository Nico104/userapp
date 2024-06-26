import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/feature/pets/profile_details/pages/pet_page.dart';
import 'package:userapp/feature/scans/scans_page.dart';

import '../../general/utils_theme/custom_colors.dart';
import 'navigation_peppi_content.dart';

class ExtendedSettingsContainer extends StatefulWidget {
  const ExtendedSettingsContainer({
    super.key,
    required this.isActive,
    required this.petProfileDetails,
    required this.reloadFuture,
  });

  final bool isActive;
  final PetProfileDetails petProfileDetails;
  final VoidCallback reloadFuture;

  @override
  State<ExtendedSettingsContainer> createState() =>
      ExtendedSettingsContainerState();
}

class ExtendedSettingsContainerState extends State<ExtendedSettingsContainer> {
  final double _borderRadius = 42;
  final int iconFlex = 10;
  final int labelFlex = 2;

  final double bottomPaddingDefaultValue = 16;
  late double bottomPadding;

  double draghandleOpacity = 1;

  double _width = 0;

  bool _share = false;
  bool _scans = false;

  @override
  void initState() {
    super.initState();
    bottomPadding = bottomPaddingDefaultValue;
  }

  void resetNavigationPeppi() {
    setState(() {
      _share = false;
      _scans = false;
    });
  }

  void resetHandle() {
    print("reset");
    setState(() {
      bottomPadding = bottomPaddingDefaultValue;
      draghandleOpacity = 1;
      _width = 0;
    });
    resetNavigationPeppi();
  }

  void swipeContainerUpByPercent(double upPercentageLevel,
      [bool ignoreImage = false]) {
    //Speed if Change
    double newPadding = bottomPaddingDefaultValue +
        (35.h - bottomPaddingDefaultValue) * upPercentageLevel;
    double newdraghandleopacity = (1 - upPercentageLevel);
    if (newdraghandleopacity < 0) {
      newdraghandleopacity = 0;
    } else if (newdraghandleopacity > 1) {
      newdraghandleopacity = 1;
    }

    double newWidth = 0;
    if (upPercentageLevel < 1) {
      newWidth = 30.w + 70.w * upPercentageLevel;
    } else {
      newWidth = 90.w;
    }

    print(bottomPadding);

    //Extend of Change
    double maxPositivePadding = 50.h;
    double maxNegativePaddingChnage =
        bottomPaddingDefaultValue - bottomPaddingDefaultValue * (3 / 4);
    if (newPadding < maxNegativePaddingChnage) {
      newPadding = maxNegativePaddingChnage;
    } else if (newPadding > maxPositivePadding) {
      print(
          "newBottomPadding bigger than $maxPositivePadding set to $maxPositivePadding");
      newPadding = maxPositivePadding;
    }
    setState(() {
      bottomPadding = newPadding;
      _width = newWidth;
      if (!ignoreImage) {
        draghandleOpacity = newdraghandleopacity;
      }
    });
  }

  final Duration _duration = const Duration(milliseconds: 125);

  void goToDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PetPage2(
          petProfileDetails: widget.petProfileDetails,
          // showDescriptions: false,
        ),
      ),
    ).then((value) => widget.reloadFuture.call());
    resetHandle();
  }

  void goToScans() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScansPage(
          petName: widget.petProfileDetails.petName,
          // scans: widget.petProfileDetails.petProfileScans,
          petProfileId: widget.petProfileDetails.profileId,
        ),
      ),
    );
    resetHandle();
  }

  void goToShare() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     // builder: (context) => ShareImageGenerator(
    //     //   petProfileDetails: widget.petProfileDetails,
    //     // ),
    //     builder: (context) => SharePetProfilePage(
    //       petProfileDetails: widget.petProfileDetails,
    //     ),
    //   ),
    // );
    // Share.share(
    //   'check out my dope ass dog https://example.com',
    //   subject: 'Look at my dope ass dog!',
    // );
    resetHandle();
    setState(() {
      _share = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: AnimatedOpacity(
        duration: _duration,
        opacity: widget.isActive ? 1 : 0,
        curve: Curves.easeInOutExpo,
        child: IgnorePointer(
          ignoring: !widget.isActive,
          child: GestureDetector(
            onTap: () async {
              swipeContainerUpByPercent(0.2, true);
              await Future.delayed(const Duration(milliseconds: 40));
              swipeContainerUpByPercent(-0.2, true);
              await Future.delayed(const Duration(milliseconds: 125));
              resetHandle();
            },
            onVerticalDragEnd: (details) {
              print("Drag end");
              double velocity = details.primaryVelocity ?? 0;
              print("$velocity- Velocity");
              if (velocity < 0) {
                goToDetails();
              } else {
                resetHandle();
              }
            },
            onVerticalDragUpdate: (details) {
              int sensitivity = 2;

              if (details.delta.dy > sensitivity ||
                  details.delta.dy < -sensitivity) {
                double upPercentageLevel =
                    -details.localPosition.dy / (SizerUtil.height / 2);

                swipeContainerUpByPercent(upPercentageLevel);
              }
            },
            child: Container(
              // height: 110,
              // width: double.infinity,
              // height: 80,
              // blur: 7,
              // width: 100,
              // elevation: 2,
              padding: const EdgeInsets.all(8),
              // borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
                boxShadow: kElevationToShadow[4],
                color: Theme.of(context).primaryColor.withOpacity(1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 10.w,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: getCustomColors(context).accent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ActionButtons(
                    goToDetails: () => goToDetails(),
                    goToScans: () => goToScans(),
                    goToShare: () => goToShare(),
                    scans: _scans,
                    share: _share,
                    resetNavigationPeppi: resetNavigationPeppi,
                    reloadFuture: widget.reloadFuture,
                    petProfileDetails: widget.petProfileDetails,
                  ),
                  AnimatedContainer(
                    duration: (bottomPadding <= bottomPaddingDefaultValue)
                        ? Duration(
                            milliseconds: ((2 * bottomPaddingDefaultValue) -
                                    bottomPadding * 2)
                                .round())
                        : const Duration(milliseconds: 0),
                    height: bottomPadding,
                    width: _width,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
