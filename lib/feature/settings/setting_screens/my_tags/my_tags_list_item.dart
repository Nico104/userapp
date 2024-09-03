import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/models/m_tag.dart';
import 'package:userapp/feature/tag/tag_selection/tag_selection_items/tag_selection_item.dart';
import 'package:userapp/feature/tag/tag_single.dart';
import 'package:userapp/feature/tag/utils/u_tag.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';
import 'package:userapp/general/widgets/custom_nico_modal.dart';

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

  // Widget _getMoreButton() {
  //   return MoreButton(
  //     moreOptions: [
  //       widget.petProfileDetails != null
  //           ? ListTile(
  //               leading: const Icon(CustomIcons.edit),
  //               title: Text("myTags_OptionGoToPet".tr(
  //                   namedArgs: {'Karamba': widget.petProfileDetails!.petName})),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 navigatePerSlide(
  //                   context,
  //                   PetPage2(petProfileDetails: widget.petProfileDetails!),
  //                   callback: () => widget.reloadTags(),
  //                 );
  //               },
  //             )
  //           : ListTile(
  //               leading: const Icon(CustomIcons.edit),
  //               title: Text("myTags_OptionCreatePet".tr()),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 showDialog(
  //                   context: context,
  //                   builder: (_) => EnterNameDialog(
  //                     title: "setPetNameTitle".tr(),
  //                     hint: "setPetNameHint".tr(),
  //                     confirmLabel: "setPetNameConfirmLabel".tr(),
  //                   ),
  //                 ).then((value) async {
  //                   if (value != null && value.isNotEmpty) {
  //                     PetProfileDetails newPetProfileDetails =
  //                         await createNewPetProfile(value);
  //                     await connectTagFromPetProfile(
  //                       newPetProfileDetails.profileId,
  //                       widget.tag.collarTagId,
  //                     );
  //                     newPetProfileDetails.tag.add(widget.tag);
  //                     if (context.mounted) {
  //                       navigatePerSlide(
  //                         context,
  //                         PetPage2(
  //                           petProfileDetails: newPetProfileDetails,
  //                         ),
  //                         callback: () => widget.reloadTags(),
  //                       );
  //                     }
  //                   }
  //                 });
  //               },
  //             ),
  //       ListTile(
  //         leading: const Icon(CustomIcons.delete),
  //         title: Text("myTags_OptionRemoveTag".tr()),
  //         onTap: () {
  //           Navigator.pop(context);
  //           showDialog(
  //             context: context,
  //             builder: (_) => ConfirmDeleteDialog(
  //               label: "confirmDelete_Tag".tr(),
  //               remove: true,
  //             ),
  //           ).then((value) {
  //             if (value != null) {
  //               if (value == true) {
  //                 // deleteContact(contact).then((value) {
  //                 //   Navigator.pop(context);
  //                 // });
  //                 disconnectTagFromUser(widget.tag.collarTagId).then((value) {
  //                   // Navigator.pop(context);
  //                   widget.reloadTags();
  //                 });
  //               }
  //             }
  //           });
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget _getMoreOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.petProfileDetails != null
            ? ListTile(
                leading: const Icon(CustomIcons.edit),
                title: Text("myTags_OptionGoToPet".tr(
                    namedArgs: {'Karamba': widget.petProfileDetails!.petName})),
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
                  disconnectTagFromUser(widget.tag.collarTagId).then((value) {
                    // Navigator.pop(context);
                    widget.reloadTags();
                  });
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
    return GestureDetector(
      onTap: () {
        showCustomNicoModalBottomSheet(
          context: context,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: _getMoreOptions(),
          ),
        );
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
              boxShadow: kElevationToShadow[0],
              border: Border.all(color: Colors.black38, width: 1),
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
                    Text(
                      widget.petProfileDetails != null
                          ? "myTags_InUse".tr(namedArgs: {
                              'Karamba': widget.petProfileDetails!.petName
                            })
                          : "myTags_NotInUse".tr(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, right: 2),
                  child: Opacity(
                    opacity: 0.9,
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
        // child: Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     TagSingle(
        //       collardimension: 80,
        //       picturePath: widget.tag.model.picturePath,
        //     ),
        //     const SizedBox(width: 36),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.max,
        //       children: [
        //         Text(
        //           widget.tag.model.tagModel_Label,
        //           style: Theme.of(context).textTheme.titleMedium,
        //         ),
        //         const SizedBox(height: 8),
        //         Text(
        //           widget.petProfileDetails != null
        //               ? "myTags_InUse".tr(namedArgs: {
        //                   'Karamba': widget.petProfileDetails!.petName
        //                 })
        //               : "myTags_NotInUse".tr(),
        //           style: Theme.of(context).textTheme.labelMedium,
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ],
        //     ),
        //     // const Spacer(),
        //     // _getMoreButton(),
        //   ],
        // ),
      ),
    );
  }
}
