import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/general/network_globals.dart';
import '../../general/utils_theme/custom_text_styles.dart';
import 'profile_details/models/m_pet_profile.dart';

class PetProfilePreview extends StatefulWidget {
  const PetProfilePreview({
    super.key,
    required this.petProfileDetails,
    required this.imageAlignmentOffset,
    required this.reloadFuture,
    required this.extendedPicture,
    required this.switchExtendedActions,
    required this.setPictureLink,
    required this.closeNavigationPeppi,
  });

  final PetProfileDetails petProfileDetails;
  final double imageAlignmentOffset;
  final VoidCallback reloadFuture;
  final bool extendedPicture;
  final VoidCallback switchExtendedActions;
  final Function(String) setPictureLink;

  final VoidCallback closeNavigationPeppi;

  @override
  State<PetProfilePreview> createState() => PetProfilePreviewState();
}

class PetProfilePreviewState extends State<PetProfilePreview> {
  double collardimension = 130;
  double collaroffset = 10;
  double marginhorizontal = 03.w;
  final double borderRadius = 36;

  //Extended Actions
  final Duration _duration = const Duration(milliseconds: 125);
  final Curve _curve = Curves.fastOutSlowIn;
  final double topOffset = 25;
  final double bottomOffset = 16;
  final int iconFlex = 10;
  final int labelFlex = 2;

  final PageController _controller = PageController();
  double _pageIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      closeNavigationPeppi();
      setState(() {
        _pageIndex = _controller.page ?? 0;
      });

      // widget.setPictureIndex((_controller.page ?? 0).round());

      if (_pageIndex > 0 && !widget.extendedPicture) {
        widget.switchExtendedActions.call();
      } else if (_pageIndex == 0 && widget.extendedPicture) {
        widget.switchExtendedActions.call();
      }

      resetPicture();
    });
  }

  bool _debounceNavgationPeppiTemp = false;

  void closeNavigationPeppi() {
    if (!_debounceNavgationPeppiTemp) {
      widget.closeNavigationPeppi();
      _debounceNavgationPeppiTemp = true;
    }
    EasyDebounce.debounce(
      'closeNavigationPeppi',
      const Duration(milliseconds: 80),
      () {
        _debounceNavgationPeppiTemp = false;
      },
    );
  }

  // @override
  // void didUpdateWidget(covariant PetProfilePreview oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   resetPicture();
  // }

  void resetPicture() {
    EasyDebounce.debounce(
      widget.petProfileDetails.profileId.toString(),
      const Duration(milliseconds: 2000),
      () {
        if (widget.extendedPicture) {
          _controller.animateTo(0,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 500));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  String getPictureLink(int position) {
    String pictureLink = widget.petProfileDetails.petPictures.isNotEmpty
        ? s3BaseUrl +
            widget.petProfileDetails.petPictures
                .elementAt(position)
                .petPictureLink
        : "https://picsum.photos/600/800";
    widget.setPictureLink(pictureLink);
    return pictureLink;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox.expand(
            child: Stack(
              children: [
                SizedBox.expand(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 24),
                      AnimatedOpacity(
                        duration: _duration,
                        curve: Curves.fastOutSlowIn,
                        opacity: !widget.extendedPicture ? 1 : 0,
                        child: Text(
                          widget.petProfileDetails.petName,
                          style: getCustomTextStyles(context).homePetName,
                        ),
                      ),
                      //For floatingappbar
                      const Spacer(
                        flex: 8,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: _controller,
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            widget.petProfileDetails.petPictures.isNotEmpty
                                ? widget.petProfileDetails.petPictures.length
                                : 1,
                        itemBuilder: (context, position) {
                          return Align(
                            alignment: const Alignment(0, -0.4),
                            child: AnimatedFractionallySizedBox(
                              heightFactor: widget.extendedPicture ? 0.8 : 0.7,
                              // heightFactor: 1,
                              widthFactor: widget.extendedPicture ? 0.8 : 0.7,
                              duration: _duration,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  boxShadow: kElevationToShadow[4],
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  child: AnimatedFractionallySizedBox(
                                    duration: _duration,
                                    heightFactor:
                                        widget.extendedPicture ? 1 : 1.2,
                                    alignment: Alignment(
                                      0,
                                      widget.imageAlignmentOffset,
                                    ),
                                    child: Image.network(
                                      getPictureLink(position),
                                      fit: BoxFit.cover,
                                      alignment: Alignment(
                                          0, widget.imageAlignmentOffset * 2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    //For floatingappbar
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
