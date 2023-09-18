import 'dart:ui';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
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
import '../contact_page/contact_page.dart';

class LostBox extends StatelessWidget {
  const LostBox({
    super.key,
    required this.petProfile,
    required this.goToContacts,
  });

  final PetProfileDetails petProfile;
  final double _borderRadius = 36;
  final VoidCallback goToContacts;

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
                borderRadius: BorderRadius.circular(_borderRadius),
                elevation: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    // color: Colors.blue,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 80.w,
                        minWidth: 40.w,
                        maxHeight: 80.h,
                        minHeight: 30.h,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mark Tabo as lost",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 32),
                            Text(
                              "Add Information for People to see first",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(height: 16),
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
                            const SizedBox(height: 32),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.labelMedium,
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          'While Tabo is lost his contact information will be set visible, manage contact visibility in '),
                                  TextSpan(
                                    text: 'Contacts',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pop(context);
                                        goToContacts();
                                      },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            Center(
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(36),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(36),
                                    color: getCustomColors(context).accent,
                                  ),
                                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                                  child: Text(
                                    "Mark as lost",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
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
