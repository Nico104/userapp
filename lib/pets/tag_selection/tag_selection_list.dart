import 'package:flutter/material.dart';
import '../../pet_color/pet_colors.dart';
import '../profile_details/models/m_tag.dart';
import '../tag/tag_single.dart';

class TagSelectionList extends StatefulWidget {
  const TagSelectionList(
      {super.key, required this.userTags, required this.currentTags});

  final List<Tag> userTags;
  final List<Tag> currentTags;

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
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tagSelection.length,
      itemBuilder: (BuildContext context, int index) {
        Tag tag = tagSelection.keys.elementAt(index);
        bool isSelected = tagSelection[tagSelection.keys.elementAt(index)]!;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  tagSelection[tagSelection.keys.elementAt(index)] =
                      !tagSelection[tagSelection.keys.elementAt(index)]!;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TagSingle(
                      tagPersonalisation: tag.collarTagPersonalisation,
                      collardimension: 95,
                    ),
                    const Spacer(),
                    Text(tag.collarTagId),
                    const Spacer(flex: 8),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: isSelected
                              ? dataEditTagSelectionAvtiveBorder
                              : Colors.grey.shade300,
                          width: isSelected ? 3 : 2,
                        ),
                        color: isSelected
                            ? dataEditTagSelectionActiveBackground
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: dataEditTagSelectionAvtiveBorder,
                            )
                          : const SizedBox(),
                    )
                  ],
                ),
              ),
            ),
          ],
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
