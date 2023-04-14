import 'package:flutter/material.dart';
import 'package:userapp/pets/profile_details/u_profile_details.dart';

import '../../../theme/custom_colors.dart';
import '../models/m_pet_profile.dart';
import 'save_button_dialog.dart';

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
      heroTag: null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      backgroundColor: getCustomColors(context).accent,
      tooltip: "Click to save changes",
      onPressed: () async {
        showDialog(
          context: context,
          builder: (_) => SaveButtonDialog(),
          barrierDismissible: false,
          barrierColor: Theme.of(context).primaryColor.withOpacity(0.35),
        );
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
