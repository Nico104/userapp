import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/profile_detail_view.dart';
import 'package:userapp/pets/profile_details/u_profile_details.dart';
import 'package:userapp/pets/tag/tags.dart';
import 'package:userapp/pets/tag/tag_selection/d_tag_selection.dart';
import 'package:userapp/styles/custom_icons_icons.dart';
import '../language/m_language.dart';
import '../pet_color/pet_colors.dart';
import '../styles/text_styles.dart';
import 'profile_details/models/m_pet_profile.dart';
import 'profile_details/models/m_tag.dart';

class PetProfilePreview extends StatefulWidget {
  const PetProfilePreview({
    super.key,
    required this.petProfileDetails,
    required this.imageAlignmentOffset,
    required this.reloadFuture,
    required this.extendedActions,
    required this.switchExtendedActions,
  });

  final PetProfileDetails petProfileDetails;
  final double imageAlignmentOffset;
  final VoidCallback reloadFuture;
  final bool extendedActions;
  final VoidCallback switchExtendedActions;

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          // onTap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => PetProfileDetailView(
          //       petProfileDetails: widget.petProfileDetails,
          //       reloadFuture: widget.reloadFuture,
          //     ),
          //   ),
          // ),
          onTap: () {
            widget.switchExtendedActions();
          },
          child: AnimatedContainer(
            duration: _duration,
            curve: _curve,
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(
              top: widget.extendedActions ? 0 : topOffset,
              left: widget.extendedActions ? 0 : marginhorizontal,
              right: widget.extendedActions ? 0 : marginhorizontal,
              //6 because its the shadow offset
              bottom: widget.extendedActions
                  ? 16
                  : collardimension / 2 + collaroffset + bottomOffset,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.28),
                    blurRadius: 6,
                    offset: const Offset(1, 3), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                  image: const NetworkImage("https://picsum.photos/600/800"),
                  fit: BoxFit.cover,
                  alignment: Alignment(widget.imageAlignmentOffset, 0),
                ),
              ),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: _duration,
                  curve: _curve,
                  height: widget.extendedActions ? 130 : 0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius)),
                    color: Colors.white,
                  ),
                  child: AnimatedOpacity(
                    duration: _duration,
                    curve: _curve,
                    opacity: widget.extendedActions ? 1 : 0,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              //To trigger the Hit Box
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: iconFlex,
                                    child: const Center(
                                      child: Icon(
                                        CustomIcons.share_thin,
                                        // Icons.share_rounded,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Share",
                                    style: extendedActions,
                                  ),
                                  Expanded(
                                      flex: labelFlex, child: const SizedBox()),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              //To trigger the Hit Box
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: iconFlex,
                                    child: const Center(
                                      child: Icon(
                                        CustomIcons.edit_square,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Edit",
                                    style: extendedActions,
                                  ),
                                  Expanded(
                                      flex: labelFlex, child: const SizedBox()),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              //To trigger the Hit Box
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: iconFlex,
                                    child: const Center(
                                      child: Icon(
                                        CustomIcons.qr_code_9,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Scans",
                                    style: extendedActions,
                                  ),
                                  Expanded(
                                      flex: labelFlex, child: const SizedBox()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        IgnorePointer(
          ignoring: widget.extendedActions,
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => TagSelectionDialog(
                  currentTags: widget.petProfileDetails.tag,
                ),
              ).then((value) async {
                if (value != null) {
                  if (value is List<Tag> &&
                      widget.petProfileDetails.profileId != null) {
                    await handleTagChange(value, widget.petProfileDetails.tag,
                        widget.petProfileDetails.profileId!);
                    widget.reloadFuture.call();
                  }
                }
              });
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomOffset),
              child: AnimatedOpacity(
                duration: _duration,
                curve: _curve,
                opacity: widget.extendedActions ? 0 : 1,
                child: Hero(
                  tag: 'collar${widget.petProfileDetails.profileId}',
                  child: Align(
                    // alignment: Alignment.bottomCenter,
                    alignment: Alignment(widget.imageAlignmentOffset * -0.2, 1),
                    child: Tags(
                        tag: widget.petProfileDetails.tag,
                        collardimension: collardimension),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
