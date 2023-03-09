import 'package:flutter/material.dart';
import 'package:userapp/pets/tag_selection/tag_selection_list.dart';
import '../../pet_color/pet_colors.dart';
import '../profile_details/models/m_tag.dart';
import '../tag/tag_single.dart';

class TagSelectionItem extends StatefulWidget {
  const TagSelectionItem({
    super.key,
    required this.tag,
    required this.toggleSelectedValue,
    required this.tagSelection,
  });

  final Tag tag;
  final Function() toggleSelectedValue;
  // final bool isSelected;
  final TagSelection tagSelection;

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
        if (widget.tagSelection != TagSelection.inUse) {
          widget.toggleSelectedValue();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TagSingle(
              tagPersonalisation: widget.tag.collarTagPersonalisation,
              collardimension: 95,
            ),
            const Spacer(),
            Text(widget.tag.collarTagId),
            const Spacer(flex: 8),
            getSelectionIcon(widget.tagSelection),
          ],
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
            color: dataEditTagSelectionAvtiveBorder,
            width: 3,
          ),
          color: dataEditTagSelectionActiveBackground,
        ),
        child: Icon(
          Icons.check,
          color: dataEditTagSelectionAvtiveBorder,
        ),
      );
    case TagSelection.inUse:
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
