import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/pets/tag/tags.dart';
import 'package:userapp/styles/custom_icons_icons.dart';
import '../../pet_color/pet_colors.dart';
import '../../styles/text_styles.dart';
import 'models/m_tag.dart';

class PetNameComponent extends StatefulWidget {
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
  State<PetNameComponent> createState() => _PetNameComponentState();
}

class _PetNameComponentState extends State<PetNameComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // const Spacer(
        //   flex: 2,
        // ),
        Tags(collardimension: widget.collardimension, tag: widget.tag),
        // Tags(collardimension: widget.collardimension, tag: widget.tag),
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
                  widget.petName ?? "Unamed",
                  style: petNameStyle,
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

void askForPetName(BuildContext context, ValueSetter<String> setPetName,
    String? currentPetName) async {
  await showDialog(
    context: context,
    builder: (_) => PetNameDialog(
      initialValue: currentPetName,
    ),
  ).then((value) {
    if (value != null) {
      setPetName(value);
    }
  });
}

class PetNameDialog extends StatefulWidget {
  const PetNameDialog({super.key, this.initialValue});

  final String? initialValue;

  @override
  State<PetNameDialog> createState() => _PetNameDialogState();
}

class _PetNameDialogState extends State<PetNameDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Colors.black, width: 2.5),
      ),
      elevation: 0,
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
                style: pickerDialogTitleStyle,
              ),
              const SizedBox(height: 28),
              TextFormField(
                autofocus: true,
                controller: _controller,
                cursorColor: Colors.black.withOpacity(0.74),
                decoration: InputDecoration(
                  hintText: "Enter Description",
                  fillColor: Colors.white,
                  suffixIconColor: Colors.grey,
                  suffixIcon: GestureDetector(
                    onTap: () => _controller.clear(),
                    child: const Icon(Icons.delete),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.75,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      side: const BorderSide(width: 1, color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: dataEditDialogButtonCancelStyle,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context, _controller.text),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      backgroundColor: dataEditDialogButtonSave,
                      side: const BorderSide(width: 1, color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Save ahead",
                      style: dataEditDialogButtonSaveStyle,
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
