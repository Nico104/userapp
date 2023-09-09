import 'package:flutter/material.dart';
import 'package:userapp/feature/tag/tag_selection/tag_selection_list.dart';
import '../../../pets/profile_details/models/m_tag.dart';
import '../../../pets/profile_details/u_profile_details.dart';
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
      child: Opacity(
        opacity: _isSelected ? 0.45 : 1,
        child: Transform.scale(
          scale: _isSelected ? 0.8 : 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    TagSingle(
                      picturePath: widget.tag.picturePath,
                      collardimension: 115,
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    Text(
                      widget.tag.collarTagId,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
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
