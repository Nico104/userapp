import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:userapp/feature/pets/profile_details/c_pet_name.dart';
import 'package:userapp/feature/pets/profile_details/pages/pet_page.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

import '../tag/tag_selection/tag_selection_page.dart';
import 'profile_details/models/m_pet_profile.dart';

class NewPetProfile extends StatelessWidget {
  const NewPetProfile({
    super.key,
    required this.reloadFuture,
  });
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PetPage2(
                      petProfileDetails: petProfileDetails,
                      openTagPageOnStart: true,
                    ),
                  ),
                ).then((value) {
                  reloadFuture();
                });
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => TagSelectionPage(
                //       petProfile: petProfileDetails,
                //     ),
                //   ),
                // ).then((value) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => PetPage2(
                //         petProfileDetails: petProfileDetails,
                //       ),
                //     ),
                //   ).then((value) {
                //     reloadFuture();
                //   });
                // });
              }
            }
          });
        },
        child: Column(
          children: [
            Spacer(),
            Material(
              borderRadius: BorderRadius.circular(borderRadius),
              elevation: 8,
              child: Container(
                width: 250,
                // height: 70,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: getCustomColors(context).accent,
                ),
                alignment: Alignment.center,
                child: Text(
                  "createNewPetProfileLabel".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
