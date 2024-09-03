import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/feature/pets/profile_details/models/m_tag.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import 'package:userapp/feature/pets/u_pets.dart';
import 'package:userapp/feature/tag/tag_selection/tag_selection_items/tag_selection_item.dart';
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
      return Text("tag_inUseBy".tr(namedArgs: {'Karamba': usingPet!.petName}));
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
    return FutureBuilder<PetProfileDetails>(
      future: getPet(widget.tag.petProfileId!),
      builder:
          (BuildContext context, AsyncSnapshot<PetProfileDetails> snapshot) {
        if (snapshot.hasData) {
          String petName = snapshot.data!.petName;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => TagChangeProfileAlertDialog(
                  currentPetName: petName,
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
            child: Transform.scale(
              scale: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    // color: HexColor("F8C8DC").withOpacity(0.35),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Row(
                    children: [
                      // const Spacer(
                      //   flex: 1,
                      // ),
                      const SizedBox(height: 32),

                      // const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.tag.model.tagModel_Label,
                            // "Tailfur 1 - Heart",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            children: [
                              Text(
                                "In Use. Active for ",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                petName,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, right: 2),
                        child: Opacity(
                          opacity: 0.7,
                          child: TagImage(
                            picturePath: widget.tag.model.picturePath,
                          ),
                          // child: Image.network(
                          //   s3BaseUrl + widget.tag.picturePath,
                          //   width: 100,
                          //   height: 100,
                          //   fit: BoxFit.contain,
                          //   color: Colors.black,
                          // ),
                        ),
                      ),

                      // const SizedBox(height: 16),
                      // const Spacer(
                      //   flex: 5,
                      // ),
                      // getSelectionIcon(widget.tagSelection),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // return Text(
          //   "In Use. Active for ...",
          //   style: Theme.of(context).textTheme.labelSmall,
          // );
          return const SizedBox.shrink();
        } else {
          return const CustomLoadingIndicatior();
        }
      },
    );
  }
}
