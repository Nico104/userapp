import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/auth/auth_widgets.dart';
import 'package:userapp/feature/pets/profile_details/u_profile_details.dart';
import 'package:userapp/feature/pets/profile_details/widgets/custom_textformfield.dart';
import 'package:userapp/feature/tag/tag_selection/scan_tag.dart';
import 'package:userapp/feature/tag/tag_selection/tag_selection_page.dart';
import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';
import 'package:userapp/general/utils_theme/custom_colors.dart';

import '../../../general/utils_general.dart';
import '../../pets/profile_details/models/m_pet_profile.dart';
import '../../pets/profile_details/models/m_tag.dart';
import '../utils/u_tag.dart';

class AddFinmaTagHeader extends StatefulWidget {
  const AddFinmaTagHeader({
    super.key,
    required this.petProfile,
    required this.subtitle,
  });

  //If has profile it comes from pet optherwise it comes form settings
  final PetProfileDetails? petProfile;
  final String subtitle;

  @override
  State<AddFinmaTagHeader> createState() => _AddFinmaTagHeaderState();
}

class _AddFinmaTagHeaderState extends State<AddFinmaTagHeader> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  int activationCodeLength = 16;

  String? errorText;

  //Check the Tags activiation code
  void _checkCode(String code, bool isScannedQr) {
    assignTagToUser(code).then(
      (tag) {
        if (widget.petProfile != null) {
          connectTagFromPetProfile(
                  widget.petProfile!.profileId, tag.collarTagId)
              .then((value) =>
                  _showSuccessDialog().then((value) => Navigator.pop(context)));
        } else {
          _showSuccessDialog().then((value) => Navigator.pop(context));
        }
      },
    ).onError((error, stackTrace) {
      if (isScannedQr) {
        _showScanErrorDialog();
      } else {
        setState(() {
          errorText = "addTag_Error".tr();
        });
      }
    });
  }

  Future<void> _showScanErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('addTag_WrongCode'.tr()),
          content: Text('addTag_WrongCodeContent'.tr()),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('addTag_Success'.tr()),
          content: Text('addTag_SuccessContent'.tr()),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok great!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            // padding: const EdgeInsets.fromLTRB(16, 32, 0, 16),
            padding: const EdgeInsets.fromLTRB(16, 32, 0, 16),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      borderRadius: 48,
                      showSuffix: false,
                      expands: true,
                      errorText: errorText,
                      textEditingController: _textEditingController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                          // activationCodeLength + (activationCodeLength / 4).round() - 1,
                          activationCodeLength,
                        ),
                        // CustomFourGroupedInputFormatter(),
                      ],
                      labelText: "addTag_ActivationCodeLabel".tr(),
                      validator: (val) {
                        if (val != null) {
                          if (val.length == 16) {
                            return null;
                          }
                        }
                        return "addTag_ActivationCodeMinLenght".tr();
                      },
                      onChanged: (p0) {
                        EasyDebounce.debounce(
                          'finmaTagActivationCode',
                          const Duration(milliseconds: 250),
                          () {
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TagScanner()),
                      ).then((value) async {
                        if (value != null) {
                          //-Idcode last symbols in link
                          String tagId = value.substring(value.length - 12);
                          Tag tag = await getTag(tagId);
                          _checkCode(tag.activationCode, true);
                        }
                      });
                    },
                    child: Material(
                      elevation: 2,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(48),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(48),
                        bottomRight: Radius.circular(0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(48),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(48),
                            bottomRight: Radius.circular(0),
                          ),
                          color: getCustomColors(context).accent,
                        ),
                        padding: const EdgeInsets.all(24),
                        child: const Icon(
                          CustomIcons.qr_code_9,
                          size: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _textEditingController.text.length != 16
              ? Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    widget.subtitle,
                    style: Theme.of(context).textTheme.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(32),
                  child: CustomBigButton(
                    label: "addTag_ButtonLabel".tr(),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          errorText = null;
                        });

                        _checkCode(_textEditingController.text, false);
                      }
                    },
                  ),
                )
        ],
      ),
    );
  }
}
// cDHKPzkaRtwxnOdE