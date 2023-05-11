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

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({
    super.key,
    required this.petProfileDetails,
    required this.scrollController,
    // required this.refresh,
  });

  final PetProfileDetails petProfileDetails;
  final ScrollController scrollController;

  // final VoidCallback refresh;

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appBarTitleProfileDetails'.tr()),
        scrolledUnderElevation: 8,
      ),
      body: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          key: const ValueKey("PetInfo"),
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 36),
            PaddingComponent(
              child: PetNameComponent(
                petProfile: widget.petProfileDetails,
                petName: widget.petProfileDetails.petName,
                setPetName: (value) {
                  setState(() {
                    widget.petProfileDetails.petName = value;
                  });
                  updatePetProfileCore(widget.petProfileDetails);
                },
                gender: widget.petProfileDetails.petGender,
                tag: widget.petProfileDetails.tag,
                setTags: (value) => setState(() {
                  widget.petProfileDetails.tag = value;
                }),
                collardimension: 120,
                // refresh: widget.refresh,
              ),
            ),
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
                  setState(() {
                    widget.petProfileDetails.petGender = value;
                  });
                  updatePetProfileCore(widget.petProfileDetails);
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
      ),
    );
  }
}
