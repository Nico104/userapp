import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/c_pet_name.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import '../../pet_color/pet_colors.dart';
import '../../pet_color/u_pet_colors.dart';
import '../../styles/text_styles.dart';
import 'c_chip_number.dart';
import 'c_component_padding.dart';
import 'c_description.dart';
import 'c_pet_gender.dart';
import 'c_pictures.dart';
import 'c_section_title.dart';
import 'u_profile_details.dart';

class PetProfileDetailView extends StatefulWidget {
  const PetProfileDetailView({super.key, required this.petProfileDetails});

  final PetProfileDetails petProfileDetails;

  @override
  State<PetProfileDetailView> createState() => _PetProfileDetailViewState();
}

class _PetProfileDetailViewState extends State<PetProfileDetailView> {
  late PetProfileDetails _petProfileDetails;

  @override
  void initState() {
    super.initState();
    _petProfileDetails = widget.petProfileDetails.clone();

    // if (_petProfileDetails.petName == null) {
    //   WidgetsBinding.instance
    //       .addPostFrameCallback((_) => askForPetName(context));
    // }
  }

  void askForPetName(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (_) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(36.0)),
        child: SizedBox(
          width: 60.w,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Please enter your Pets Name"),
                const SizedBox(height: 28),
                TextFormField(
                  controller: controller,
                ),
                const SizedBox(height: 28),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context, controller.text),
                  child: const Text("Done!"),
                )
              ],
            ),
          ),
        ),
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          _petProfileDetails.petName = value;
        });
      }
    });
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
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(
      //     Icons.save,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {
      //     handlePetProfileDetailsSave(
      //         _petProfileDetails, widget.petProfileDetails);
      //   },
      // ),
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: _petProfileDetails.petGender != Gender.none
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(-1, -1),
                  end: const Alignment(1, 1),
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
              component: PetGenderComponent(
                gender: _petProfileDetails.petGender,
                setGender: (value) => setState(() {
                  _petProfileDetails.petGender = value;
                }),
              ),
            ),
            PaddingComponent(
              component: PetDescriptionComponent(
                //Pass by reference
                descriptions: _petProfileDetails.petDescription,
              ),
            ),
            PaddingComponent(
              component: PetChipNumber(
                chipNr: "5423523",
                setchipNr: (value) {},
              ),
            ),
            PaddingComponent(
              component: PetChipNumber(
                chipNr: "xx",
                setchipNr: (value) {},
              ),
            ),
            PaddingComponent(
              component: PetChipNumber(
                chipNr: "xx",
                setchipNr: (value) {},
              ),
            ),
            PaddingComponent(
              component: PetChipNumber(
                chipNr: "xx",
                setchipNr: (value) {},
              ),
            ),
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
