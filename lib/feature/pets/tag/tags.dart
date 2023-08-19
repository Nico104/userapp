import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/tag/tag_single.dart';

import '../profile_details/models/m_tag.dart';
import 'empty_tag.dart';

class Tags extends StatelessWidget {
  const Tags({super.key, required this.tag, required this.collardimension});

  final List<Tag> tag;
  final double collardimension;

  @override
  Widget build(BuildContext context) {
    if (tag.isNotEmpty) {
      return Stack(
        children: _buildTags(tag, collardimension),
      );
    } else {
      return EmptyTag(
        dimension: collardimension,
      );
    }
  }
}

List<Widget> _buildTags(List<Tag> list, double collardimension) {
  List<Widget> tags = [];
  for (int i = 0; i < list.length; i++) {
    int index = list.length - 1 - i;
    Tag tag = list.elementAt(index);
    tags.add(
      Padding(
        padding: EdgeInsets.only(left: (30 * index).toDouble()),
        child: TagSingle(
          collardimension: collardimension,
          // tagPersonalisation: tag.collarTagPersonalisation,
          picturePath: tag.picturePath,
        ),
      ),
    );
  }
  return tags;
}
