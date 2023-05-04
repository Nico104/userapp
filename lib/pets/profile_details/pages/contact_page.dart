import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../c_component_padding.dart';
import '../c_one_line_simple_input.dart';
import '../c_phone_number.dart';
import '../c_social_media.dart';
import '../models/m_pet_profile.dart';
import '../u_profile_details.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({
    super.key,
    required this.petProfileDetails,
    required this.scrollController,
  });

  final PetProfileDetails petProfileDetails;
  final ScrollController scrollController;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
          key: const ValueKey("Contact"),
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 36),
            PaddingComponent(
              child: OnelineSimpleInput(
                flex: 6,
                value: widget.petProfileDetails.petOwnerName ?? "",
                emptyValuePlaceholder: "Schlongus Longus",
                title: "profileDetailsComponentTitleOwnersName".tr(),
                saveValue: (val) async {
                  widget.petProfileDetails.petOwnerName = val;
                  print(widget.petProfileDetails.petOwnerName);
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            PaddingComponent(
              child: OnelineSimpleInput(
                flex: 8,
                value: widget.petProfileDetails.petOwnerLivingPlace ?? "",
                emptyValuePlaceholder: "Mainstreet 20A, Vienna, Austria",
                title: "profileDetailsComponentTitleHomeAddress".tr(),
                saveValue: (val) async {
                  widget.petProfileDetails.petOwnerLivingPlace = val;
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            PaddingComponent(
              child: PetPhoneNumbersComponent(
                phoneNumbers: widget.petProfileDetails.petOwnerTelephoneNumbers,
                petProfileId: widget.petProfileDetails.profileId,
              ),
            ),
            PaddingComponent(
              child: SocialMediaComponent(
                title: "profileDetailsComponentTitleSocialMedia".tr(),
                facebook: widget.petProfileDetails.petOwnerFacebook ?? "",
                saveFacebook: (val) async {
                  print(widget.petProfileDetails.petOwnerFacebook);
                  widget.petProfileDetails.petOwnerFacebook = val;
                  print(widget.petProfileDetails.petOwnerFacebook);
                  updatePetProfileCore(widget.petProfileDetails);
                },
                instagram: widget.petProfileDetails.petOwnerInstagram ?? "",
                saveInstagram: (val) async {
                  widget.petProfileDetails.petOwnerInstagram = val;
                  updatePetProfileCore(widget.petProfileDetails);
                },
              ),
            ),
            const SizedBox(
              height: 120,
            )
          ],
        ),
      ),
    );
  }
}
