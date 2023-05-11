import 'package:flutter/material.dart';
import 'package:userapp/pets/tag/tag_selection/tag_selection_list.dart';
import '../../../profile_details/models/m_tag.dart';
import '../../../profile_details/u_profile_details.dart';
import '../../tag_single.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        switch (widget.tagSelection) {
          case TagSelection.available:
            connectTagFromPetProfile(
                    widget.petProfileId, widget.tag.collarTagId)
                .then((value) => widget.reloadUserTags());
            break;
          case TagSelection.selected:
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
                  connectTagFromPetProfile(
                          widget.petProfileId, widget.tag.collarTagId)
                      .then((value) => widget.reloadUserTags());
                }
              }
            });
            break;
        }
      },
      child: Opacity(
        opacity: widget.tagSelection == TagSelection.available ? 0.45 : 1,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: kElevationToShadow[2],
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TagSingle(
                picturePath: widget.tag.picturePath,
                collardimension: 95,
              ),
              const Spacer(),
              Text(widget.tag.collarTagId),
              const Spacer(flex: 8),
              getSelectionIcon(widget.tagSelection),
            ],
          ),
        ),
      ),
    );
  }
}

Widget getSelectionIcon(TagSelection tagSelection) {
  switch (tagSelection) {
    case TagSelection.available:
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
          ),
          color: Colors.transparent,
        ),
      );
    case TagSelection.selected:
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: const Color(0xFF228B22),
            width: 3,
          ),
          color: const Color(0xFF50C878),
        ),
        child: const Icon(
          Icons.check,
          color: Color(0xFF228B22),
        ),
      );
    case TagSelection.inUseByOtherPet:
      return Container(
        // width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          color: Colors.transparent,
        ),
        child: const Padding(
          padding: EdgeInsets.all(4),
          child: Center(child: Text("in use rn")),
        ),
      );
  }
}
