import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/c_pet_name.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import '../../language/m_language.dart';
import '../../pet_color/u_pet_colors.dart';
import '../../styles/text_styles.dart';
import 'c_component_padding.dart';
import 'c_description.dart';
import 'c_important_information.dart';
import 'c_one_line_simple_input.dart';
import 'c_pet_gender.dart';
import 'c_phone_number.dart';
import 'c_pictures.dart';
import 'c_section_title.dart';
import 'c_social_media.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Details",
          style: profileDetailsTitle,
        ),
        backgroundColor: widget
            .petProfileDetails.tag.first.collarTagPersonalisation.primaryColor,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        onPressed: () {
          handlePetProfileDetailsSave(
                  _petProfileDetails, widget.petProfileDetails)
              .then(
            (value) {
              Navigator.pop(context);
              widget.reloadFuture();
            },
          );
        },
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: _petProfileDetails.petGender != Gender.none
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(0, -0.85),
                  end: Alignment.bottomRight,
                  colors: [
                    widget.petProfileDetails.tag.first.collarTagPersonalisation
                        .primaryColor,
                    getGenderBackgroundColor(_petProfileDetails.petGender),
                  ],
                ),
              )
            : BoxDecoration(
                color: widget.petProfileDetails.tag.first
                    .collarTagPersonalisation.primaryColor,
              ),
        child: ListView(
          children: [
            const SizedBox(height: 28),
            //Name and Tag
            PaddingComponent(
              component: PetNameComponent(
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
            const SectionTitle(text: "Pet Info"),
            //TODO
            PaddingComponent(
              component: PetPicturesComponent(
                imageHeight: 178,
                imageWidth: 178,
                imageBorderRadius: 14,
                imageSpacing: 20,
                petPictures: _petProfileDetails.petPictures,
                setPetPictures: (value) => _petProfileDetails.petPictures,
              ),
              ignoreLeftPadding: true,
            ),
            PaddingComponent(
              component: OnelineSimpleInput(
                flex: 7,
                value: _petProfileDetails.petChipId ?? "",
                emptyValuePlaceholder: "Enter Chip Nr.",
                title: "Chip Number",
                saveValue: (val) async {
                  _petProfileDetails.petChipId = val;
                },
              ),
            ),
            PaddingComponent(
              component: PetGenderComponent(
                gender: _petProfileDetails.petGender,
                setGender: (value) => setState(() {
                  _petProfileDetails.petGender = value;
                }),
              ),
            ),
            PaddingComponent(
              component: PetImportantInformation(
                //Pass by reference
                imortantInformations:
                    _petProfileDetails.petImportantInformation,
              ),
            ),
            PaddingComponent(
              component: PetDescriptionComponent(
                //Pass by reference
                descriptions: _petProfileDetails.petDescription,
              ),
            ),

            const SectionTitle(text: "Contact"),
            PaddingComponent(
              component: OnelineSimpleInput(
                flex: 6,
                value: "",
                emptyValuePlaceholder: "Enter Owners Name",
                title: "Owners Name",
                saveValue: (_) async {},
              ),
            ),
            PaddingComponent(
              component: OnelineSimpleInput(
                flex: 8,
                value: "Mainstreet 20A, Vienna, Austria",
                emptyValuePlaceholder: "Enter Living Address",
                title: "Home Address",
                saveValue: (_) async {},
              ),
            ),

            PaddingComponent(
              component: PetPhoneNumbersComponent(
                phoneNumbers: _petProfileDetails.petOwnerTelephoneNumbers,
                petProfileId: _petProfileDetails.profileId,
              ),
            ),
            PaddingComponent(
                component: SocialMediaComponent(
              title: "Social Media",
              facebook: _petProfileDetails.petOwnerFacebook ?? "",
              saveFacebook: (value) {},
              instagram: _petProfileDetails.petOwnerInstagram ?? "",
              saveInstagram: (value) {},
            )),
            SizedBox(
              height: 16,
            )
            //Wait for connection to Server for important info, maybe you can reuse the Description Model
          ],
        ),
      ),
    );
  }
}
