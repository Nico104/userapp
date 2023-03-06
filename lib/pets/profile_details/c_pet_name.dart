import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/tag/tags.dart';
import '../../styles/text_styles.dart';
import 'models/m_tag.dart';

class PetNameComponent extends StatelessWidget {
  const PetNameComponent({
    super.key,
    required this.petProfileId,
    required this.setPetName,
    this.petName,
    required this.gender,
    required this.tag,
    required this.setTags,
    required this.collardimension,
  });

  //profileId of Profile for Hero Animation
  final int? petProfileId;

  //Name
  final String? petName;
  final ValueSetter<String> setPetName;

  //Gender
  final Gender gender;

  //Tags
  final List<Tag> tag;
  final ValueSetter<List<Tag>> setTags;
  final double collardimension;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Spacer(
          flex: 2,
        ),
        Hero(
          tag: 'collar$petProfileId',
          child: Tags(collardimension: collardimension, tag: tag),
        ),
        // const SizedBox(width: 32),
        const Spacer(
          flex: 3,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  petName ?? "Unamed",
                  style: petNameStyle,
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.edit,
                  size: 18,
                )
              ],
            ),
            gender != Gender.none
                ? Text(
                    getPetTitle(gender),
                    style: petGoodBadgeStyle,
                  )
                : const SizedBox(),
          ],
        ),
        const Spacer(
          flex: 16,
        ),
      ],
    );
  }
}

String getPetTitle(Gender gender) {
  switch (gender) {
    case Gender.male:
      return "Good boy";
    case Gender.female:
      return "Good girl";
    case Gender.none:
      return "";
  }
}
