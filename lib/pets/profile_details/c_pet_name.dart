import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/tag/tags.dart';
import '../../styles/text_styles.dart';
import '../collar_test.dart';
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
  });

  //profileId of Profile for Hero Animation
  final int? petProfileId;

  //Name
  final String? petName;
  final ValueSetter<String> setPetName;

  //Gender
  final Gender? gender;

  //Tags
  final List<Tag> tag;
  final ValueSetter<List<Tag>> setTags;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Hero(
          tag: 'collar$petProfileId',
          child: Tags(collardimension: 100, tag: tag),
        ),
        const SizedBox(width: 32),
        Column(
          mainAxisSize: MainAxisSize.min,
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
            gender != null
                ? Text(
                    getPetTitle(gender!),
                    style: petGoodBadgeStyle,
                  )
                : const SizedBox(),
          ],
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
