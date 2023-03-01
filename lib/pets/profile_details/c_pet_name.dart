import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
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
          child: CollarTest(collardimension: 100),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(petName ?? "Unamed"),
            gender != null ? Text(getPetTitle(gender!)) : const SizedBox(),
          ],
        ),
        Spacer(),
        Icon(Icons.edit),
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
  }
}
