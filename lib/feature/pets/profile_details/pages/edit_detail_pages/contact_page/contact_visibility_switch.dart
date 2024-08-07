import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

import '../../../models/m_pet_profile.dart';

class ContactVisibilitySwitch extends StatefulWidget {
  const ContactVisibilitySwitch({
    super.key,
    required this.petProfileDetails,
  });

  final PetProfileDetails petProfileDetails;

  @override
  State<ContactVisibilitySwitch> createState() =>
      _ContactVisibilitySwitchState();
}

class _ContactVisibilitySwitchState extends State<ContactVisibilitySwitch> {
  final double _borderRadius = 32;
  final double _height = 65;

  final _duration = const Duration(milliseconds: 125);

  // void setVisible() {
  //   widget.petProfileDetails.hide_contacts = false;
  //   setState(() {});
  //   updateContactVisibility(
  //       petProfileId: widget.petProfileDetails.profileId,
  //       contact_visbility: widget.petProfileDetails.hide_contacts);
  // }

  void hideContactVisibility(bool hide) {
    setState(() {
      widget.petProfileDetails.hide_contacts = hide;
    });
    print(widget.petProfileDetails.hide_contacts);
    updatePetProfileCore(widget.petProfileDetails);
  }

  // void setInvisible() {
  //   widget.petProfileDetails.hide_contacts = true;
  //   setState(() {});
  //   updateContactVisibility(
  //       petProfileId: widget.petProfileDetails.profileId,
  //       contact_visbility: widget.petProfileDetails.hide_contacts);
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Align(
        alignment: const Alignment(0.0, 1.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: GestureDetector(
            onPanUpdate: (details) {
              // Swiping in right direction.
              if (details.delta.dx > 0) {
                if (widget.petProfileDetails.hide_contacts) {
                  // setVisible();
                  hideContactVisibility(false);
                }
              }

              // Swiping in left direction.
              if (details.delta.dx < 0) {
                if (!widget.petProfileDetails.hide_contacts) {
                  // setInvisible();
                  hideContactVisibility(false);
                }
              }
            },
            onTap: () {
              if (widget.petProfileDetails.hide_contacts) {
                // setVisible();
                hideContactVisibility(false);
              } else {
                // setInvisible();
                hideContactVisibility(true);
              }
            },
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
              elevation: 6,
              child: Container(
                height: _height,
                width: 50.w,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_borderRadius)),
                  color: Theme.of(context).primaryColor.withOpacity(1),
                  // color: bgColor ?? getCustomColors(context).accent,
                ),
                child: AnimatedAlign(
                  duration: _duration,
                  curve: Curves.fastOutSlowIn,
                  alignment: !widget.petProfileDetails.hide_contacts
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: AnimatedContainer(
                      duration: _duration,
                      curve: Curves.fastOutSlowIn,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius)),
                        color: !widget.petProfileDetails.hide_contacts
                            ? getCustomColors(context).accent
                            : Colors.red.shade800,
                      ),
                      child: Center(
                          child: AnimatedSwitcher(
                        duration: _duration,
                        child: !widget.petProfileDetails.hide_contacts
                            ? Text(
                                "contactVisibilitySwitch_visible".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: Colors.white),
                              )
                            : Text(
                                "contactVisibilitySwitch_hidden".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                      )),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void handleShyButtonShown({required Function(bool) setShowShyButton}) {
  //hideBar
  // setState(() {
  //   _showUploadButton = false;
  // });
  setShowShyButton(false);
  EasyDebounce.debounce(
    'handleShyButton',
    const Duration(milliseconds: 200),
    () {
      //shwoNavbar
      // setState(() {
      //   _showUploadButton = true;
      // });
      setShowShyButton(true);
    },
  );
}
