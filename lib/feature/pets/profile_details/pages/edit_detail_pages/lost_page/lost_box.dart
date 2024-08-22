import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/pets/profile_details/models/m_pet_profile.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';

import '../../../../../../general/utils_theme/custom_colors.dart';
import '../../../widgets/custom_textformfield.dart';

class LostBox extends StatefulWidget {
  const LostBox({
    super.key,
    required this.petProfile,
    required this.goToVisibilityMenu,
  });

  final PetProfileDetails petProfile;
  final VoidCallback goToVisibilityMenu;

  @override
  State<LostBox> createState() => _LostBoxState();
}

class _LostBoxState extends State<LostBox> {
  final double _borderRadius = 36;

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
              tag: "lost${widget.petProfile.profileId}",
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
                              "lostBox_Title".tr(namedArgs: {
                                'Karamba': widget.petProfile.petName
                              }),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 32),
                            Text(
                              "lostBox_ImportantInfoLabel".tr(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(height: 16),
                            Flexible(
                              child: CustomTextFormField(
                                // focusNode: focusNode,
                                initialValue: widget.petProfile.petIsLostText,
                                // textEditingController: _textEditingController,
                                hintText: "lostBox_ImportantInfoHint".tr(),
                                maxLines: null,
                                expands: false,
                                keyboardType: TextInputType.multiline,
                                autofocus: false,
                                onChanged: (val) {
                                  widget.petProfile.petIsLostText = val;
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
                                      text: 'lostBox_contactsVisibility'.tr()),
                                  const TextSpan(text: ' '),
                                  TextSpan(
                                    text: 'lostBox_Visibility_menu'.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                            color: getCustomColors(context)
                                                .secondaryAccent),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pop(context);
                                        widget.goToVisibilityMenu();
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
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.petProfile.petIsLost =
                                          !widget.petProfile.petIsLost;
                                    });
                                    updatePetProfileCore(widget.petProfile);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(36),
                                      color: widget.petProfile.petIsLost
                                          ? Colors.green.shade300
                                          : getCustomColors(context).accent,
                                    ),
                                    padding: const EdgeInsets.fromLTRB(
                                        32, 16, 32, 16),
                                    child: AutoSizeText(
                                      widget.petProfile.petIsLost
                                          ? "lostBox_confirmFoundLabel".tr()
                                          : "lostBox_confirmLabel".tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(color: Colors.white),
                                      maxLines: 1,
                                    ),
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
