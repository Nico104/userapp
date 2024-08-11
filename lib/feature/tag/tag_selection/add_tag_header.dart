import 'package:flutter/material.dart';
import 'package:userapp/general/utils_general.dart';

import '../../../../../../general/utils_theme/custom_colors.dart';
import '../../pets/profile_details/models/m_pet_profile.dart';
import 'add_tag_page.dart';

class AddNewTagHeader extends StatelessWidget {
  const AddNewTagHeader({
    super.key,
    this.petProfile,
    required this.label,
    required this.reloadTags,
  });

  final PetProfileDetails? petProfile;
  final String label;
  final VoidCallback reloadTags;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.fromLTRB(16, 32, 0, 16),
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Text(
                // "In order to have a Finma Tag assigned to your Account you have to add it first",
                label,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () {
                // addNewContact();
                navigatePerSlide(
                  context,
                  AddTagPage(
                    petProfile: petProfile,
                  ),
                  callback: () => reloadTags(),
                );
              },
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      // color: Theme.of(context).primaryColor,
                      color: getCustomColors(context).surface,
                      border: Border.all(
                        width: 0.5,
                        color: getCustomColors(context).hardBorder ??
                            Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
