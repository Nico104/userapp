import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/feature/pets/u_pets.dart';
import 'package:userapp/feature/tag/tag_selection/tag_selection_list.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';
import 'package:userapp/general/widgets/loading_indicator.dart';
import '../../../../general/network_globals.dart';
import '../../../pets/profile_details/models/m_tag.dart';
import '../../../pets/profile_details/u_profile_details.dart';
import '../d_change_profile.dart';

class TagSelectionItem extends StatefulWidget {
  const TagSelectionItem({
    super.key,
    required this.tag,
    // required this.toggleSelectedValue,
    required this.tagSelection,
    required this.petProfile,
    required this.reloadUserTags,
  });

  final Tag tag;
  final TagSelection tagSelection;
  final PetProfileDetails petProfile;

  final VoidCallback reloadUserTags;

  @override
  State<TagSelectionItem> createState() => _TagSelectionItemState();
}

class _TagSelectionItemState extends State<TagSelectionItem> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.tagSelection == TagSelection.selected;
  }

  void _select() {
    setState(() {
      _isSelected = true;
    });
  }

  void _unselect() {
    setState(() {
      _isSelected = false;
    });
  }

  Widget getSubtitle() {
    switch (widget.tagSelection) {
      case TagSelection.available:
        return Wrap(
          children: [
            Text(
              "Available. ",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: getCustomColors(context).accentHighContrast,
                  ),
            ),
            Text(
              "Not in use",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        );

      case TagSelection.selected:
        return Wrap(
          children: [
            Text(
              "In Use. Active for ",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Text(
              widget.petProfile.petName,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: getCustomColors(context).accentHighContrast,
                  ),
            ),
          ],
        );

      case TagSelection.inUseByOtherPet:
        return Text(
          "In Use. Active for ...",
          style: Theme.of(context).textTheme.labelSmall,
        );
      // Using 2nd file class for Profile Loading
      // return FutureBuilder<PetProfileDetails>(
      //   future: getPet(widget.tag.petProfileId!),
      //   builder: (BuildContext context,
      //       AsyncSnapshot<PetProfileDetails> snapshot) {
      //     if (snapshot.hasData) {
      //       return Text(
      //         "In Use. Active for ${snapshot.data!.petName}",
      //         style: Theme.of(context).textTheme.labelSmall,
      //       );
      //     } else if (snapshot.hasError) {
      //       return Text(
      //         "In Use. Active for ...",
      //         style: Theme.of(context).textTheme.labelSmall,
      //       );
      //     } else {
      //       return Text(
      //         "In Use. Active for ...",
      //         style: Theme.of(context).textTheme.labelSmall,
      //       );
      //     }
      //   },
      // );
    }
  }

  BoxDecoration getContainerDecoration() {
    switch (widget.tagSelection) {
      case TagSelection.available:
        return BoxDecoration(
          color: Theme.of(context).primaryColor,
          // color: HexColor("F8C8DC").withOpacity(0.35),
          borderRadius: BorderRadius.circular(8),
          boxShadow: kElevationToShadow[1],
          border: Border.all(color: Colors.black45, width: 0.5),
        );

      case TagSelection.selected:
        return BoxDecoration(
          color: Theme.of(context).primaryColor,
          // color: HexColor("F8C8DC").withOpacity(0.35),
          borderRadius: BorderRadius.circular(8),
          boxShadow: kElevationToShadow[0],
          border: Border.all(color: Colors.black38, width: 1.5),
        );

      case TagSelection.inUseByOtherPet:
        return BoxDecoration();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        switch (widget.tagSelection) {
          case TagSelection.available:
            _select();
            connectTagFromPetProfile(
                    widget.petProfile.profileId, widget.tag.collarTagId)
                .then((value) => widget.reloadUserTags());
            break;
          case TagSelection.selected:
            _unselect();
            disconnectTagFromPetProfile(
                    widget.petProfile.profileId, widget.tag.collarTagId)
                .then((value) => widget.reloadUserTags());
            break;
          case TagSelection.inUseByOtherPet:
            showDialog(
              context: context,
              builder: (_) => TagChangeProfileAlertDialog(
                currentPetName: widget.tag.petProfileId.toString(),
                newPetName: widget.petProfile.profileId.toString(),
              ),
            ).then((value) {
              if (value != null && value is bool) {
                if (value == true) {
                  _select();
                  connectTagFromPetProfile(
                          widget.petProfile.profileId, widget.tag.collarTagId)
                      .then((value) => widget.reloadUserTags());
                }
              }
            });
            break;
        }
      },
      child: ClipRRect(
        child: Transform.scale(
          scale: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: getContainerDecoration(),
              child: Row(
                children: [
                  // const Spacer(
                  //   flex: 1,
                  // ),
                  const SizedBox(height: 32),

                  // const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.tag.model.tagModel_Label,
                        // "Tailfur 1 - Heart",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      getSubtitle(),
                    ],
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 2),
                    child: Opacity(
                      opacity: 0.9,
                      child: TagImage(
                        picturePath: widget.tag.model.picturePath,
                      ),
                      // child: Image.network(
                      //   s3BaseUrl + widget.tag.picturePath,
                      //   width: 100,
                      //   height: 100,
                      //   fit: BoxFit.contain,
                      //   color: Colors.black,
                      // ),
                    ),
                  ),

                  // const SizedBox(height: 16),
                  // const Spacer(
                  //   flex: 5,
                  // ),
                  // getSelectionIcon(widget.tagSelection),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TagImage extends StatelessWidget {
  const TagImage({
    super.key,
    required this.picturePath,
  });

  final String picturePath;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: 100,
      height: 100,
      fit: BoxFit.contain,
      imageUrl: s3BaseUrl + picturePath,
      placeholder: (context, url) => const CustomLoadingIndicatior(),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        size: 50,
      ),
    );
  }
}

Widget getSelectionIcon(TagSelection tagSelection) {
  switch (tagSelection) {
    case TagSelection.available:
      return Chip(
        label: Text("tagSelectionChip_Select".tr()),
        elevation: 2,
      );
    case TagSelection.selected:
      return Chip(
        label: Text("tagSelectionChip_Active".tr()),
        elevation: 2,
        backgroundColor: Colors.green,
      );
    case TagSelection.inUseByOtherPet:
      return Chip(
        label: Text("tagSelectionChip_InUse".tr()),
        elevation: 2,
        backgroundColor: Colors.green,
      );
  }
}
