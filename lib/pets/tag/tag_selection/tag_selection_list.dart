import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/tag/tag_selection/tag_selection_items/tag_selection_item_in_use.dart';
import '../../profile_details/models/m_tag.dart';
import 'tag_selection_items/tag_selection_item.dart';

enum TagSelection {
  available,
  selected,
  inUseByOtherPet,
}

class TagSelectionList extends StatefulWidget {
  const TagSelectionList({
    super.key,
    required this.userTags,
    required this.petProfile,
    required this.reloadUserTags,
  });

  final List<Tag> userTags;
  final PetProfileDetails petProfile;
  final VoidCallback reloadUserTags;

  @override
  State<TagSelectionList> createState() => _TagSelectionListState();
}

class _TagSelectionListState extends State<TagSelectionList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.userTags.length,
      itemBuilder: (BuildContext context, int index) {
        switch (getTagSelection(
          widget.userTags.elementAt(index),
          widget.petProfile.profileId,
        )) {
          case TagSelection.available:
            return TagSelectionItem(
              tag: widget.userTags.elementAt(index),
              tagSelection: getTagSelection(widget.userTags.elementAt(index),
                  widget.petProfile.profileId),
              petProfileId: widget.petProfile.profileId,
              reloadUserTags: widget.reloadUserTags,
            );
          case TagSelection.selected:
            return TagSelectionItem(
              tag: widget.userTags.elementAt(index),
              tagSelection: getTagSelection(widget.userTags.elementAt(index),
                  widget.petProfile.profileId),
              petProfileId: widget.petProfile.profileId,
              reloadUserTags: widget.reloadUserTags,
            );
          case TagSelection.inUseByOtherPet:
            return TagSelectionItemInUseByOtherPet(
              tag: widget.userTags.elementAt(index),
              petProfile: widget.petProfile,
              reloadUserTags: widget.reloadUserTags,
            );
        }
      },
    );
  }
}

bool getTagActiveness(Tag val, List<Tag> currentTags) {
  for (Tag tag in currentTags) {
    if (tag.collarTagId == val.collarTagId) {
      return true;
    }
  }
  return false;
}

int countSelected(Map<Tag, bool> tagSelection) {
  return tagSelection.entries.where((e) => e.value == true).length;
}

TagSelection getTagSelection(Tag tag, int petprofileId) {
  if (tag.petProfileId == petprofileId) {
    return TagSelection.selected;
  } else if (tag.petProfileId != null) {
    return TagSelection.inUseByOtherPet;
  } else {
    return TagSelection.available;
  }
}

List<Tag> getSelectedTagsFromMap(Map<Tag, bool> tagSelection) {
  List<Tag> selected = List.empty(growable: true);
  tagSelection.forEach((key, value) {
    if (value) {
      selected.add(key);
    }
  });
  return selected;
}
