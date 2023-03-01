import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/c_pet_name.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
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

    if (_petProfileDetails.petName == null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => askForPetName(context));
    }
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
                  child: Text("Done!"),
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
        title: const Text("Profile Details"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [Icon(Icons.scanner)],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          handlePetProfileDetailsSave(
              _petProfileDetails, widget.petProfileDetails);
        },
      ),
      body: ListView(
        children: [
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
            ),
          ),
          const SectionTitle(text: "Pet Info"),
          //TODO
          PaddingComponent(
            component: PetPicturesComponent(
              imageHeight: 178,
              imageWidth: 178,
              imageBorderRadius: 24,
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
          ElevatedButton(
            onPressed: () async {
              // PetProfileDetails petProfileDetails =
              //     await fetchPetProfileDetailsTest();

              print(_petProfileDetails.petDescription
                  .elementAt(0)
                  .language
                  .languageLabel);
            },
            child: Text("fetch"),
          ),
          //Wait for connection to Server for important info, maybe you can reuse the Description Model
        ],
      ),
    );
  }
}
