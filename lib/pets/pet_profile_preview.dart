import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/profile_detail_view.dart';
import 'collar_tag_preview.dart';
import 'profile_details/models/m_pet_profile.dart';
import 'tag/tag_single.dart';

class PetProfilePreview extends StatefulWidget {
  const PetProfilePreview({
    super.key,
    required this.petProfileDetails,
    required this.imageAlignmentOffset,
  });

  final PetProfileDetails petProfileDetails;
  final double imageAlignmentOffset;

  @override
  State<PetProfilePreview> createState() => _PetProfilePreviewState();
}

class _PetProfilePreviewState extends State<PetProfilePreview> {
  double collardimension = 130;
  double collaroffset = 10;

  double marginhorizontal = 06.w;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetProfileDetailView(
                petProfileDetails: widget.petProfileDetails,
              ),
            ),
          ),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(
              left: marginhorizontal,
              right: marginhorizontal,
              bottom: collardimension / 2 + collaroffset,
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 3),
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(4, 4), // changes position of shadow
                ),
              ],
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/600/800"),
                fit: BoxFit.cover,
                alignment: Alignment(widget.imageAlignmentOffset, 0),
              ),
            ),
          ),
        ),
        Hero(
          tag: 'collar${widget.petProfileDetails.profileId}',
          child: Align(
            // alignment: Alignment.bottomCenter,
            alignment: Alignment(widget.imageAlignmentOffset * -0.1, 1),
            child: TagSingle(
              collardimension: collardimension,
              tagPersonalisation:
                  widget.petProfileDetails.tag.first.collarTagPersonalisation,
            ),
          ),
        )
      ],
    );
  }
}
