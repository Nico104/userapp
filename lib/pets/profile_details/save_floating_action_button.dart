import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/u_profile_details.dart';

import '../../theme/custom_colors.dart';
import 'models/m_pet_profile.dart';

class SaveFloatingActionButton extends StatelessWidget {
  const SaveFloatingActionButton({
    super.key,
    required PetProfileDetails petProfileDetails,
    required this.oldPetProfileDetails,
    required this.reloadFuture,
  }) : _petProfileDetails = petProfileDetails;

  final PetProfileDetails oldPetProfileDetails;
  final PetProfileDetails _petProfileDetails;
  final VoidCallback reloadFuture;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: getCustomColors(context).accentLight,
      tooltip: "Click to save changes",
      onPressed: () async {
        if (_petProfileDetails.tag.isNotEmpty) {
          await handlePetProfileDetailsSave(
                  _petProfileDetails, oldPetProfileDetails)
              .then(
            (value) {
              // Navigator.pop(context);
              reloadFuture.call();
            },
          );
        }
      },
      child: Icon(
        Icons.save,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
