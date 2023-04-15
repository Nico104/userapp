import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/c_pet_name.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import '../../pet_color/u_pet_colors.dart';
import '../../styles/text_styles.dart';
import '../../theme/custom_colors.dart';
import 'c_component_padding.dart';
import 'c_description.dart';
import 'c_edit_pages.dart';
import 'c_important_information.dart';
import 'c_one_line_simple_input.dart';
import 'c_pet_gender.dart';
import 'c_phone_number.dart';
import 'pictures/c_pictures.dart';
import 'c_section_title.dart';
import 'c_social_media.dart';
import 'save_button/save_floating_action_button.dart';
import 'u_profile_details.dart';

class PetProfileDetailView extends StatefulWidget {
  const PetProfileDetailView({
    super.key,
    required this.petProfileDetails,
    required this.reloadFuture,
  });

  final PetProfileDetails petProfileDetails;

  final VoidCallback reloadFuture;

  @override
  State<PetProfileDetailView> createState() => _PetProfileDetailViewState();
}

class _PetProfileDetailViewState extends State<PetProfileDetailView> {
  late PetProfileDetails _petProfileDetails;

  bool isScrollTop = true;
  final _scrollSontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    _petProfileDetails = widget.petProfileDetails.clone();
    if (widget.petProfileDetails.petName == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => askForPetName(
          context,
          (value) => setState(() {
                _petProfileDetails.petName = value;
              }),
          null));
    }

    // Setup Scroll Listener dfor AppBarDivider
    _scrollSontroller.addListener(() {
      bool isTop = _scrollSontroller.position.pixels == 0;
      if (isTop) {
        if (!isScrollTop) {
          setState(() {
            isScrollTop = true;
          });
        }
      } else {
        if (isScrollTop) {
          setState(() {
            isScrollTop = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appBarTitleProfileDetails'.tr()),
        flexibleSpace: !isScrollTop
            ? ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    color: Colors.transparent,
                    height: double.infinity,
                  ),
                ),
              )
            : null,
      ),
      floatingActionButton: SaveFloatingActionButton(
        petProfileDetails: _petProfileDetails,
        oldPetProfileDetails: widget.petProfileDetails,
        reloadFuture: () => widget.reloadFuture.call(),
      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: ListView(
        shrinkWrap: true,
        controller: _scrollSontroller,
        children: [
          const SizedBox(height: 28),
          PaddingComponent(
            ignoreLeftPadding: true,
            child: Center(
              child: Container(
                width: 90.w,
                height: 90.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: kElevationToShadow[4],
                  image: const DecorationImage(
                    image: NetworkImage("https://picsum.photos/512"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          //Name and Tag
          PaddingComponent(
            child: PetNameComponent(
              petProfileId: _petProfileDetails.profileId,
              petName: _petProfileDetails.petName,
              setPetName: (value) => setState(() {
                _petProfileDetails.petName = value;
              }),
              gender: _petProfileDetails.petGender,
              tag: _petProfileDetails.tag,
              setTags: (value) => setState(() {
                _petProfileDetails.tag = value;
              }),
              collardimension: 120,
            ),
          ),
          EditPagesTabComponent(
            petInfo: Column(
              key: const ValueKey("PetInfo"),
              mainAxisSize: MainAxisSize.min,
              children: [
                PaddingComponent(
                  ignoreLeftPadding: true,
                  child: PetPicturesComponent(
                    imageHeight: 178,
                    imageWidth: 178,
                    imageBorderRadius: 14,
                    imageSpacing: 20,
                    petPictures: _petProfileDetails.petPictures,
                    setPetPictures: (value) => _petProfileDetails.petPictures,
                  ),
                ),
                PaddingComponent(
                  child: OnelineSimpleInput(
                    flex: 7,
                    value: _petProfileDetails.petChipId ?? "",
                    emptyValuePlaceholder: "977200000000000",
                    title: "profileDetailsComponentTitleChipNumber".tr(),
                    saveValue: (val) async {
                      _petProfileDetails.petChipId = val;
                    },
                  ),
                ),
                PaddingComponent(
                  child: PetGenderComponent(
                    gender: _petProfileDetails.petGender,
                    setGender: (value) => setState(() {
                      _petProfileDetails.petGender = value;
                    }),
                  ),
                ),
                PaddingComponent(
                  child: PetImportantInformation(
                    //Pass by reference
                    imortantInformations:
                        _petProfileDetails.petImportantInformation,
                  ),
                ),
                PaddingComponent(
                  child: PetDescriptionComponent(
                    //Pass by reference
                    descriptions: _petProfileDetails.petDescription,
                  ),
                ),
              ],
            ),
            contact: Column(
              key: const ValueKey("Contact"),
              mainAxisSize: MainAxisSize.min,
              children: [
                PaddingComponent(
                  child: OnelineSimpleInput(
                    flex: 6,
                    value: "",
                    emptyValuePlaceholder: "Schlongus Longus",
                    title: "profileDetailsComponentTitleOwnersName".tr(),
                    saveValue: (_) async {},
                  ),
                ),
                PaddingComponent(
                  child: OnelineSimpleInput(
                    flex: 8,
                    value: "Mainstreet 20A, Vienna, Austria",
                    emptyValuePlaceholder: "Mainstreet 20A, Vienna, Austria",
                    title: "profileDetailsComponentTitleHomeAddress".tr(),
                    saveValue: (_) async {},
                  ),
                ),
                PaddingComponent(
                  child: PetPhoneNumbersComponent(
                    phoneNumbers: _petProfileDetails.petOwnerTelephoneNumbers,
                    petProfileId: _petProfileDetails.profileId,
                  ),
                ),
                PaddingComponent(
                  child: SocialMediaComponent(
                    title: "profileDetailsComponentTitleSocialMedia".tr(),
                    facebook: _petProfileDetails.petOwnerFacebook ?? "",
                    saveFacebook: (value) {},
                    instagram: _petProfileDetails.petOwnerInstagram ?? "",
                    saveInstagram: (value) {},
                  ),
                ),
              ],
            ),
            document: Column(
              key: const ValueKey("Documents"),
              mainAxisSize: MainAxisSize.min,
              children: [],
            ),
          ),
          const SizedBox(
            height: 16,
          )
          //Wait for connection to Server for important info, maybe you can reuse the Description Model
        ],
      ),
    );
  }
}