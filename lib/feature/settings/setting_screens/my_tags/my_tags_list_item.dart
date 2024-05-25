import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/models/m_tag.dart';
import 'package:userapp/feature/tag/tag_single.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

import '../../../pets/profile_details/c_pet_name.dart';
import '../../../pets/profile_details/d_confirm_delete.dart';
import '../../../pets/profile_details/models/m_pet_profile.dart';
import '../../../pets/profile_details/pages/pet_page.dart';
import '../../../pets/profile_details/u_profile_details.dart';
import '../../../../general/utils_custom_icons/custom_icons_icons.dart';
import '../../../../general/utils_general.dart';
import '../../../../general/widgets/more_button.dart';

class MyTagListItem extends StatefulWidget {
  const MyTagListItem({
    super.key,
    required this.tag,
    this.petProfileDetails,
    required this.reloadTags,
  });

  final Tag tag;
  final PetProfileDetails? petProfileDetails;

  final VoidCallback reloadTags;

  @override
  State<MyTagListItem> createState() => _MyTagListItemState();
}

class _MyTagListItemState extends State<MyTagListItem> {
  final double _borderRadius = 16;

  Widget _getMoreButton() {
    return MoreButton(
      moreOptions: [
        widget.petProfileDetails != null
            ? ListTile(
                leading: const Icon(CustomIcons.edit),
                title: Text("myTags_OptionGoToPet".tr(
                    namedArgs: {"name": widget.petProfileDetails!.petName})),
                onTap: () {
                  Navigator.pop(context);
                  navigatePerSlide(
                    context,
                    PetPage2(petProfileDetails: widget.petProfileDetails!),
                    callback: () => widget.reloadTags(),
                  );
                },
              )
            : ListTile(
                leading: const Icon(CustomIcons.edit),
                title: Text("myTags_OptionCreatePet".tr()),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => EnterNameDialog(
                      title: "setPetNameTitle".tr(),
                      hint: "setPetNameHint".tr(),
                      confirmLabel: "setPetNameConfirmLabel".tr(),
                    ),
                  ).then((value) async {
                    if (value != null && value.isNotEmpty) {
                      PetProfileDetails newPetProfileDetails =
                          await createNewPetProfile(value);
                      await connectTagFromPetProfile(
                        newPetProfileDetails.profileId,
                        widget.tag.collarTagId,
                      );
                      newPetProfileDetails.tag.add(widget.tag);
                      if (context.mounted) {
                        navigatePerSlide(
                          context,
                          PetPage2(
                            petProfileDetails: newPetProfileDetails,
                          ),
                          callback: () => widget.reloadTags(),
                        );
                      }
                    }
                  });
                },
              ),
        ListTile(
          leading: const Icon(CustomIcons.delete),
          title: Text("myTags_OptionRemoveTag".tr()),
          onTap: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (_) => ConfirmDeleteDialog(
                label: "confirmDelete_Tag".tr(),
                remove: true,
              ),
            ).then((value) {
              if (value != null) {
                if (value == true) {
                  // deleteContact(contact).then((value) {
                  //   Navigator.pop(context);
                  // });
                }
              }
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(_borderRadius),
        child: GestureDetector(
          onLongPress: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              color: getCustomColors(context).surface,
            ),
            padding: const EdgeInsets.all(22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TagSingle(
                  collardimension: 80,
                  picturePath: widget.tag.picturePath,
                ),
                const SizedBox(width: 36),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      widget.tag.collarTagId,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.petProfileDetails != null
                          ? "myTags_InUse".tr(namedArgs: {
                              "value1": widget.petProfileDetails!.petName
                            })
                          : "myTags_NotInUse".tr(),
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const Spacer(),
                _getMoreButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
