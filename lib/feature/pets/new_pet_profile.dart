import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/c_pet_name.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';

import 'profile_details/models/m_pet_profile.dart';
import 'profile_details/models/m_tag.dart';
import 'profile_details/profile_detail_view.dart';
import '../tag/tag_selection/d_tag_selection.dart';

class NewPetProfile extends StatelessWidget {
  const NewPetProfile({
    super.key,
    required this.reloadFuture,
  });

  // final double marginhorizontal = 06.w;
  // final double borderRadius = 14;
  // final double topOffset = 28;
  // final double collardimension = 130;
  // final double collaroffset = 10;
  final VoidCallback reloadFuture;

  final double borderRadius = 50;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.3),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => EnterNameDialog(
              title: "setPetNameTitle".tr(),
              hint: "setPetNameHint".tr(),
              confirmLabel: "setPetNameConfirmLabel".tr(),
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
        child: Material(
          borderRadius: BorderRadius.circular(borderRadius),
          elevation: 8,
          child: Container(
            width: 250,
            height: 70,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF3366FF),
                  Color(0xFF00CCFF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                tileMode: TileMode.clamp,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              "createNewPetProfileLabel".tr(),
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
