import 'dart:ui';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/feature/pets/profile_details/models/medical/m_health_issue.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';
import 'package:userapp/general/utils_general.dart';

import '../../../../../../../general/network_globals.dart';
import '../../../../../../general/utils_theme/custom_colors.dart';
import '../../../../../../general/utils_theme/custom_text_styles.dart';
import '../../../widgets/custom_textformfield.dart';

class LostBox extends StatelessWidget {
  const LostBox({
    super.key,
    required this.petProfile,
  });

  final PetProfileDetails petProfile;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.06),
          child: Center(
            child: Hero(
              tag: "lost${petProfile.profileId}",
              child: Material(
                borderRadius: BorderRadius.circular(16),
                elevation: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    // color: Colors.blue,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 80.w,
                        minWidth: 40.w,
                        maxHeight: 50.h,
                        minHeight: 20.h,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mark Tabo as lost",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Flexible(
                              child: CustomTextFormField(
                                // focusNode: focusNode,
                                initialValue: petProfile.petIsLostText,
                                // textEditingController: _textEditingController,
                                hintText: "Important Information",
                                maxLines: null,
                                expands: false,
                                keyboardType: TextInputType.multiline,
                                autofocus: false,
                                onChanged: (val) {
                                  petProfile.petIsLostText = val;
                                },
                                showSuffix: false,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Todo remove Outlined Button and stay with Containers to keep it the same everywhere - Extract Cancel Widget and Save Widget
                                OutlinedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(
                                        24, 12, 24, 12),
                                    side: BorderSide(
                                      width: 0.5,
                                      color: getCustomColors(context)
                                              .lightBorder ??
                                          Colors.transparent,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    "Cancel",
                                    style: getCustomTextStyles(context)
                                        .dataEditDialogButtonCancelStyle,
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    petProfile.petIsLost = true;
                                    updatePetProfileCore(petProfile)
                                        .then((value) {
                                      Navigator.pop(context);
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(
                                        24, 12, 24, 12),
                                    backgroundColor:
                                        getCustomColors(context).accent,
                                    side: BorderSide(
                                      width: 0.5,
                                      color: getCustomColors(context)
                                              .lightBorder ??
                                          Colors.transparent,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    "Mark as Lost",
                                    style: getCustomTextStyles(context)
                                        .dataEditDialogButtonSaveStyle,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
