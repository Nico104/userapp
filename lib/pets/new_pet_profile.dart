import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/pets/profile_details/c_pet_name.dart';
import 'package:userapp/pets/profile_details/u_profile_details.dart';

import 'profile_details/models/m_pet_profile.dart';
import 'profile_details/models/m_tag.dart';
import 'profile_details/profile_detail_view.dart';
import 'tag/tag_selection/d_tag_selection.dart';

class NewPetProfile extends StatelessWidget {
  NewPetProfile({
    super.key,
    required this.reloadFuture,
  });

  final double marginhorizontal = 06.w;
  final double borderRadius = 14;
  final double topOffset = 28;
  final double collardimension = 130;
  final double collaroffset = 10;
  final VoidCallback reloadFuture;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => const EnterNameDialog(
            label: "Pet Name",
            confirmLabel: "Create",
          ),
        ).then((value) async {
          if (value != null && value.isNotEmpty) {
            PetProfileDetails petProfileDetails =
                await createNewPetProfile(value);
            if (context.mounted) {
              print("yo");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PetProfileDetailView(
                    petProfileDetails: petProfileDetails,
                    // reloadFuture: reloadFuture,
                    // getProfileDetails: () {
                    //   return petProfileDetails;
                    // },
                  ),
                ),
              ).then((value) {
                reloadFuture();
              });
            }
          }
        });
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: topOffset,
          left: marginhorizontal,
          right: marginhorizontal,
          bottom: collardimension / 4 + collaroffset,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: kElevationToShadow[4],
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            width: 3,
            color: Colors.black,
            // strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.add),
              Text("Create New Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
