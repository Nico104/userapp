import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/feature/pets/profile_details/models/m_tag.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import 'package:userapp/feature/pets/u_pets.dart';
import '../../../../general/widgets/loading_indicator.dart';
import '../../tag_single.dart';
import '../d_change_profile.dart';

class TagSelectionItemInUseByOtherPet extends StatefulWidget {
  const TagSelectionItemInUseByOtherPet({
    super.key,
    required this.tag,
    required this.reloadUserTags,
    required this.petProfile,
  });

  final Tag tag;
  final PetProfileDetails petProfile;
  final VoidCallback reloadUserTags;

  @override
  State<TagSelectionItemInUseByOtherPet> createState() =>
      _TagSelectionItemInUseByOtherPetState();
}

class _TagSelectionItemInUseByOtherPetState
    extends State<TagSelectionItemInUseByOtherPet> {
  PetProfileDetails? usingPet;

  @override
  void initState() {
    super.initState();
    loadUsingPet();
  }

  Future<void> loadUsingPet() async {
    PetProfileDetails pet = await getPet(widget.tag.petProfileId!);
    setState(() {
      usingPet = pet;
    });
  }

  Widget getSuffix() {
    if (usingPet != null) {
      return Text("tag_inUseBy".tr(namedArgs: {"name": usingPet!.petName}));
    } else {
      return const CustomLoadingIndicatior();
    }
  }

  String getUsingPetName() {
    if (usingPet != null) {
      return usingPet!.petName;
    } else {
      return "other Pet";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => TagChangeProfileAlertDialog(
            currentPetName: getUsingPetName(),
            newPetName: widget.petProfile.petName,
          ),
        ).then((value) {
          if (value != null && value is bool) {
            if (value == true) {
              connectTagFromPetProfile(
                      widget.petProfile.profileId, widget.tag.collarTagId)
                  .then((value) => widget.reloadUserTags());
            }
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: kElevationToShadow[2],
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TagSingle(
              picturePath: widget.tag.picturePath,
              collardimension: 95,
            ),
            const Spacer(),
            Text(widget.tag.collarTagId),
            const Spacer(flex: 8),
            Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                color: Colors.transparent,
              ),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Center(child: getSuffix()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
