import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/tag/tag_selection/tag_selection_list.dart';
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
    required this.petProfileId,
    required this.reloadUserTags,
  });

  final Tag tag;
  final TagSelection tagSelection;
  final int petProfileId;

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        switch (widget.tagSelection) {
          case TagSelection.available:
            _select();
            connectTagFromPetProfile(
                    widget.petProfileId, widget.tag.collarTagId)
                .then((value) => widget.reloadUserTags());
            break;
          case TagSelection.selected:
            _unselect();
            disconnectTagFromPetProfile(
                    widget.petProfileId, widget.tag.collarTagId)
                .then((value) => widget.reloadUserTags());
            break;
          case TagSelection.inUseByOtherPet:
            showDialog(
              context: context,
              builder: (_) => TagChangeProfileAlertDialog(
                currentPetName: widget.tag.petProfileId.toString(),
                newPetName: widget.petProfileId.toString(),
              ),
            ).then((value) {
              if (value != null && value is bool) {
                if (value == true) {
                  _select();
                  connectTagFromPetProfile(
                          widget.petProfileId, widget.tag.collarTagId)
                      .then((value) => widget.reloadUserTags());
                }
              }
            });
            break;
        }
      },
      child: ClipRRect(
        child: Opacity(
          opacity: !_isSelected ? 0.8 : 1,
          child: Transform.scale(
            // scale: _isSelected ? 0.8 : 1,
            scale: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 0,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    // color: HexColor("F8C8DC").withOpacity(0.35),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      // const Spacer(
                      //   flex: 1,
                      // ),
                      const SizedBox(height: 32),

                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4, right: 2),
                            child: Opacity(
                              opacity: 0.2,
                              child: TagImage(widget: widget),
                              // child: Image.network(
                              //   s3BaseUrl + widget.tag.picturePath,
                              //   width: 100,
                              //   height: 100,
                              //   fit: BoxFit.contain,
                              //   color: Colors.black,
                              // ),
                            ),
                          ),
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: TagImage(widget: widget),
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      // const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Finma 1 - Heart",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.tag.collarTagId,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      // const SizedBox(height: 16),
                      const Spacer(
                        flex: 5,
                      ),
                      getSelectionIcon(widget.tagSelection),
                      const SizedBox(height: 32),
                    ],
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

class TagImage extends StatelessWidget {
  const TagImage({
    super.key,
    required this.widget,
  });

  final TagSelectionItem widget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: 100,
      height: 100,
      fit: BoxFit.contain,
      imageUrl: s3BaseUrl + widget.tag.picturePath,
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
