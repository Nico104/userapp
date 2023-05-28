import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../c_component_padding.dart';
import '../c_description.dart';
import '../c_important_information.dart';
import '../c_one_line_simple_input.dart';
import '../c_pet_gender.dart';
import '../c_pet_name.dart';
import '../models/m_pet_profile.dart';
import '../u_profile_details.dart';

class ProfileInfoTab extends StatefulWidget {
  const ProfileInfoTab({
    super.key,
    required this.petProfileDetails,
    required this.setGender,
  });

  final PetProfileDetails petProfileDetails;
  final void Function(Gender) setGender;

  @override
  State<ProfileInfoTab> createState() => _ProfileInfoTabState();
}

class _ProfileInfoTabState extends State<ProfileInfoTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        key: const ValueKey("PetInfo"),
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 36),
          PaddingComponent(
            child: OnelineSimpleInput(
              flex: 7,
              value: widget.petProfileDetails.petChipId ?? "",
              emptyValuePlaceholder: "977200000000000",
              title: "profileDetailsComponentTitleChipNumber".tr(),
              saveValue: (val) async {
                widget.petProfileDetails.petChipId = val;
                updatePetProfileCore(widget.petProfileDetails);
              },
            ),
          ),
          PaddingComponent(
            child: PetGenderComponent(
              gender: widget.petProfileDetails.petGender,
              setGender: (value) {
                widget.setGender(value);
              },
            ),
          ),
          PaddingComponent(
            child: PetImportantInformationComponent(
              petProfileId: widget.petProfileDetails.profileId,
              //Pass by reference
              importantInformation:
                  widget.petProfileDetails.petImportantInformation,
            ),
          ),
          PaddingComponent(
            child: PetDescriptionComponent(
              petProfileId: widget.petProfileDetails.profileId,
              //Pass by reference
              descriptions: widget.petProfileDetails.petDescription,
            ),
          ),
        ],
      ),
    );
  }
}
