import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/c_pet_name.dart';
import 'package:userapp/pets/profile_details/models/m_pet_profile.dart';
import 'c_component_padding.dart';
import 'c_description.dart';
import 'c_pet_gender.dart';
import 'c_pictures.dart';
import 'c_section_title.dart';
import 'u_profile_details.dart';

class PetProfileDetailView extends StatelessWidget {
  const PetProfileDetailView({super.key});

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
      body: ListView(
        children: [
          PaddingComponent(component: PetNameComponent()),
          SectionTitle(text: "Pet Info"),
          PaddingComponent(
            component: PetPicturesComponent(
              imageHeight: 178,
              imageWidth: 178,
              imageBorderRadius: 24,
              imageSpacing: 20,
            ),
            ignoreLeftPadding: true,
          ),
          PaddingComponent(component: PetGenderComponent()),
          PaddingComponent(component: PetDescriptionComponent()),
          ElevatedButton(
              onPressed: () async {
                PetProfileDetails petProfileDetails =
                    await fetchPetProfileDetailsTest();

                print(petProfileDetails.petDescription
                    .elementAt(1)
                    .language
                    .languageLabel);
              },
              child: Text("fetch")),
          //Wait for connection to Server for important info, maybe you can reuse the Description Model
        ],
      ),
    );
  }
}
