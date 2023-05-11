import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/profile_details/u_profile_details.dart';
import 'package:userapp/pets/profile_details/widgets/custom_textformfield.dart';
import 'package:userapp/pets/tag/tags.dart';
import 'package:userapp/styles/custom_icons_icons.dart';
import 'package:userapp/utils/util_methods.dart';

import '../../theme/custom_colors.dart';
import '../../theme/custom_text_styles.dart';
import '../tag/tag_selection/tag_selection_page.dart';
import '../u_pets.dart';
import 'models/m_tag.dart';

class PetNameComponent extends StatefulWidget {
  const PetNameComponent({
    super.key,
    required this.setPetName,
    required this.petName,
    required this.gender,
    required this.tag,
    required this.setTags,
    required this.collardimension,
    required this.petProfile,
    // required this.refresh,
  });

  final PetProfileDetails petProfile;

  //Name
  final String petName;
  final ValueSetter<String> setPetName;

  //Gender
  final Gender gender;

  //Tags
  final List<Tag> tag;
  final ValueSetter<List<Tag>> setTags;
  final double collardimension;

  // final VoidCallback refresh;

  @override
  State<PetNameComponent> createState() => _PetNameComponentState();
}

class _PetNameComponentState extends State<PetNameComponent> {
  late List<Tag> userProfileTags;

  @override
  void initState() {
    super.initState();
    userProfileTags = widget.tag;
  }

  Future<void> reloadTags() async {
    List<Tag> newTags = await getUserProfileTags(widget.petProfile.profileId);
    setState(() {
      userProfileTags = newTags;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            navigatePerSlide(
              context,
              TagSelectionPage(
                petProfile: widget.petProfile,
              ),
              callback: () => reloadTags(),
            );
          },
          child: Tags(
              collardimension: widget.collardimension, tag: userProfileTags),
        ),
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
                  widget.petName,
                  style: getCustomTextStyles(context).profileDetailsPetName,
                ),
                GestureDetector(
                  onTap: () =>
                      askForPetName(context, widget.setPetName, widget.petName),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 14, bottom: 14, right: 14),
                    child: Icon(
                      CustomIcons.edit_square,
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
            widget.gender != Gender.none
                ? Text(
                    getPetTitle(widget.gender),
                    style: Theme.of(context).textTheme.labelSmall,
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

class PetNameDialog extends StatefulWidget {
  const PetNameDialog({super.key, this.initialValue});

  final String? initialValue;

  @override
  State<PetNameDialog> createState() => _PetNameDialogState();
}

class _PetNameDialogState extends State<PetNameDialog> {
  String text = "";

  @override
  void initState() {
    super.initState();
    text = widget.initialValue ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: const Alignment(0, 0.85),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        // side: const BorderSide(color: Colors.black, width: 2.5),
      ),
      elevation: 16,
      child: SizedBox(
        width: 80.w,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Pet Name",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 28),
              CustomTextFormField(
                autofocus: true,
                initialValue: text,
                hintText: "Enter Pet Name",
                onChanged: (val) {
                  EasyDebounce.debounce(
                    'petName',
                    const Duration(milliseconds: 50),
                    () {
                      setState(() {
                        text = val;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Todo remove Outlined Button and stay with Containers to keep it the same everywhere - Extract Cancel Widget and Save Widget
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      side: BorderSide(
                        width: 0.5,
                        color: getCustomColors(context).lightBorder ??
                            Colors.transparent,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: getCustomTextStyles(context)
                          .dataEditDialogButtonCancelStyle,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context, text),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      backgroundColor: getCustomColors(context).accent,
                      side: BorderSide(
                        width: 0.5,
                        color: getCustomColors(context).lightBorder ??
                            Colors.transparent,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Save ahead",
                      style: getCustomTextStyles(context)
                          .dataEditDialogButtonSaveStyle,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
