import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/profile_detail_view.dart';

import 'collar_tag_preview.dart';

class PetProfilePreview extends StatefulWidget {
  const PetProfilePreview({super.key, required this.index});

  final int index;

  @override
  State<PetProfilePreview> createState() => _PetProfilePreviewState();
}

class _PetProfilePreviewState extends State<PetProfilePreview> {
  double collarheight = 100;
  double collaroffset = 10;
  double collarelevation = 8;

  double marginhorizontal = 06.w;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PetProfileDetailView()),
          ),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  left: marginhorizontal,
                  right: marginhorizontal,
                  bottom: (math.sqrt(2 * math.pow(collarheight, 2))) / 2 +
                      collaroffset),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                    bottomLeft: Radius.circular(42),
                    bottomRight: Radius.circular(42)),
                child: Image.network(
                  "https://picsum.photos/600/800",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom:
                  (math.sqrt((2 * math.pow(collarheight, 2))) - collarheight) /
                          2 +
                      collarelevation * 2),
          child: Hero(
            tag: 'collartest' + widget.index.toString(),
            child: CollarTag(
              collarheight: collarheight,
              collarelevation: collarelevation,
            ),
          ),
        )
      ],
    );
  }
}
