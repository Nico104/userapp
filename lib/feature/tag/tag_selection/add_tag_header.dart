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

import '../../../general/utils_general.dart';
import '../../pets/profile_details/models/m_pet_profile.dart';
import '../../pets/profile_details/models/m_tag.dart';
import '../utils/u_tag.dart';

class AddFinmaTagHeader extends StatefulWidget {
  const AddFinmaTagHeader({
    super.key,
    required this.petProfile,
  });

  //If has profile it comes from pet optherwise it comes form settings
  final PetProfileDetails? petProfile;

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
          errorText =
              "Ups...Something appears to be wrong. MAke sure to check the Activation Code again";
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
          title: const Text('Wrong Code'),
          content: Text('No valid Finma Tag was detected. Please retry again.'),
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
          title: const Text('Success'),
          content: const Text('YOur Finma Tag was successfully added'),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  errorText: errorText,
                  textEditingController: _textEditingController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(
                      // activationCodeLength + (activationCodeLength / 4).round() - 1,
                      activationCodeLength,
                    ),
                    // CustomFourGroupedInputFormatter(),
                  ],
                  labelText: "Enter 16 Symbol Activation Code",
                  validator: (val) {
                    if (val != null) {
                      if (val.length == 16) {
                        return null;
                      }
                    }
                    return "Activation Code is 16 Symbols long. lease put ALL of them in here";
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TagScanner()),
                  ).then((value) async {
                    if (value != null) {
                      //-Idcode last symbols in link
                      String tagId = value.substring(value.length - 12);
                      Tag tag = await getTag(tagId);
                      _checkCode(tag.activationCode, true);
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    color: Colors.blue,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: const Icon(
                    CustomIcons.qr_code_9,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        _textEditingController.text.length == 16
            ? Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  "Choose an already existing Finma Tag or simply add a new one",
                  style: Theme.of(context).textTheme.labelSmall,
                  textAlign: TextAlign.center,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(32),
                child: CustomBigButton(
                  label: "Add Finma Tag",
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
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("addTagAppbarTitle".tr()),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.petProfile != null)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      "Choose an already existing Finma Tag or simply add a new one",
                      style: Theme.of(context).textTheme.labelSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () => navigateReplacePerSlide(
                        context,
                        TagSelectionPage(
                          petProfile: widget.petProfile!,
                        )),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Choose from already added Finma Tag",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Padding(
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 0.5,
                      height: 0,
                    ),
                    padding: EdgeInsets.all(32),
                  ),
                  const SizedBox(height: 28),
                ],
              )
            else
              const SizedBox.shrink(),
            //QR Code only on Mobile because of camera ofc
            if (!kIsWeb)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Scan your Finma Tag's QR-Code"),
                  const SizedBox(height: 28),
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        color: Colors.blue,
                      ),
                      padding: const EdgeInsets.all(24),
                      child: const Icon(
                        CustomIcons.qr_code_9,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  //Divider
                  Padding(
                    padding: const EdgeInsets.only(left: 36, right: 36),
                    child: Opacity(
                      opacity: 0.28,
                      child: Row(
                        children: [
                          const Expanded(child: Divider()),
                          SizedBox(width: 03.w),
                          Text(
                            "tagScanDividerLabel".tr(),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          SizedBox(width: 03.w),
                          const Expanded(child: Divider()),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                ],
              )
            else
              const SizedBox.shrink(),
            //Activation Code
            const Text("Where to find Activition code usw. here :)"),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextFormField(
                errorText: errorText,
                textEditingController: _textEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                    // activationCodeLength + (activationCodeLength / 4).round() - 1,
                    activationCodeLength,
                  ),
                  // CustomFourGroupedInputFormatter(),
                ],
                labelText: "Enter 16 Symbol Activation Code",
                validator: (val) {
                  if (val != null) {
                    if (val.length == 16) {
                      return null;
                    }
                  }
                  return "Activation Code is 16 Symbols long. lease put ALL of them in here";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: CustomBigButton(
                label: "Add Finma Tag",
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
      ),
    );
  }
}
