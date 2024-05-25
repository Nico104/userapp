import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../general/utils_theme/custom_colors.dart';
import '../../../../pets/profile_details/widgets/custom_textformfield.dart';

class DeleteAccountTypePassword extends StatefulWidget {
  const DeleteAccountTypePassword({
    super.key,
  });

  @override
  State<DeleteAccountTypePassword> createState() =>
      _DeleteAccountTypePasswordState();
}

class _DeleteAccountTypePasswordState extends State<DeleteAccountTypePassword> {
  final double _borderRadius = 36;

  final TextEditingController _textEditingController = TextEditingController();

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
              tag: "DeleteAccountTypePassword",
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
                              "deleteAccountPasswordCheckTitle".tr(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 32),
                            Flexible(
                              child: CustomTextFormField(
                                textEditingController: _textEditingController,
                                isPassword: true,
                                maxLines: null,
                                expands: false,
                                keyboardType: TextInputType.multiline,
                                autofocus: false,
                                onChanged: (val) {},
                                showSuffix: false,
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
                                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                                  child: Text(
                                    "deleteAccountPasswordCheckButtonLabelConfirm"
                                        .tr(),
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
