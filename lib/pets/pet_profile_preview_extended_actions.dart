import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/styles/custom_icons_icons.dart';
import 'package:userapp/utils/widgets/blurry_container.dart';

import '../utils/util_methods.dart';
import 'profile_details/profile_detail_view.dart';

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
      _ExtendedSettingsContainerState();
}

class _ExtendedSettingsContainerState extends State<ExtendedSettingsContainer> {
  final double _borderRadius = 22;
  final int iconFlex = 10;
  final int labelFlex = 2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 125),
        opacity: widget.isActive ? 1 : 0,
        curve: Curves.easeInOutExpo,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          child: BlurryContainer(
            height: 110,
            width: double.infinity,
            blur: 7,
            color: Theme.of(context).primaryColor.withOpacity(0.64),
            elevation: 2,
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
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
                                size: 32,
                              ),
                            ),
                          ),
                          Text(
                            "Share",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Expanded(
                            flex: labelFlex,
                            child: const SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      navigatePerSlide(
                        context,
                        PetProfileDetailView(
                          petProfileDetails: widget.petProfileDetails,
                          reloadFuture: widget.reloadFuture,
                        ),
                      );
                    },
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
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Expanded(flex: labelFlex, child: const SizedBox()),
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
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Expanded(flex: labelFlex, child: const SizedBox()),
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
    );
  }
}
