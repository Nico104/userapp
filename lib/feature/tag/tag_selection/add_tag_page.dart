import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/auth/auth_widgets.dart';
import 'package:userapp/feature/pets/profile_details/widgets/custom_textformfield.dart';
import 'package:userapp/feature/tag/tag_selection/scan_tag.dart';
import 'package:userapp/general/utils_custom_icons/custom_icons_icons.dart';
import 'package:userapp/general/utils_general.dart';
import '../../pets/profile_details/u_profile_details.dart';
import '../../pets/u_pets.dart';

class AddFinmaTagPage extends StatefulWidget {
  const AddFinmaTagPage({
    super.key,
    required this.petProfileId,
  });

  final int petProfileId;

  @override
  State<AddFinmaTagPage> createState() => _AddFinmaTagPageState();
}

class _AddFinmaTagPageState extends State<AddFinmaTagPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  int activationCodeLength = 16;

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("addTagAppbarTitle".tr()),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 28),
            //QR Code only on Mobile because of camera ofc
            if (!kIsWeb)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Scan your Finma Tag's QR-Code"),
                  const SizedBox(height: 28),
                  InkWell(
                    onTap: () {
                      navigatePerSlide(context, const TagScanner());
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

                    assignTagToUser(_textEditingController.text).then(
                      (tag) {
                        connectTagFromPetProfile(
                                widget.petProfileId, tag.collarTagId)
                            .then((value) => Navigator.pop(context));
                      },
                    ).onError((error, stackTrace) {
                      setState(() {
                        errorText =
                            "Ups...Something appears to be wrong. MAke sure to check the Activation Code again";
                      });
                    });
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
