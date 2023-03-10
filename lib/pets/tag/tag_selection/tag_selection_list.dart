import 'package:flutter/material.dart';
import '../../profile_details/models/m_tag.dart';
import 'tag_selection_item.dart';

enum TagSelection {
  available,
  selected,
  inUse,
}

class TagSelectionList extends StatefulWidget {
  const TagSelectionList({
    super.key,
    required this.userTags,
    required this.currentTags,
    required this.returnTags,
  });

  final List<Tag> userTags;
  final List<Tag> currentTags;
  final Function(List<Tag>) returnTags;

  @override
  State<TagSelectionList> createState() => _TagSelectionListState();
}

class _TagSelectionListState extends State<TagSelectionList> {
  late final Map<Tag, bool> tagSelection;

  @override
  void initState() {
    super.initState();
    tagSelection = {
      for (Tag tag in widget.userTags)
        tag: getTagActiveness(tag, widget.currentTags)
    };

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.returnTags(getSelectedTagsFromMap(tagSelection)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tagSelection.length,
      itemBuilder: (BuildContext context, int index) {
        return TagSelectionItem(
          tag: tagSelection.keys.elementAt(index),
          tagSelection: getTagSelection(
              tagSelection.keys.elementAt(index),
              tagSelection[tagSelection.keys.elementAt(index)]!,
              widget.currentTags),
          toggleSelectedValue: () {
            //setStae gets called in Parent in returnTags
            tagSelection[tagSelection.keys.elementAt(index)] =
                !tagSelection[tagSelection.keys.elementAt(index)]!;
            widget.returnTags(getSelectedTagsFromMap(tagSelection));
          },
        );
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

TagSelection getTagSelection(Tag tag, bool isSelected, List<Tag> currentTags) {
  if ((tag.petProfileId != null) &&
      !isSelected &&
      !getTagActiveness(tag, currentTags)) {
    return TagSelection.inUse;
  } else if (isSelected) {
    return TagSelection.selected;
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
