import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../pets/profile_details/widgets/custom_textformfield.dart';

import '../auth_widgets.dart';

class SignUpPasswordPage extends StatefulWidget {
  const SignUpPasswordPage({
    super.key,
    required this.onNext,
  });

  final Function(String) onNext;

  @override
  State<SignUpPasswordPage> createState() => _SignUpPasswordPageState();
}

class _SignUpPasswordPageState extends State<SignUpPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String password = "";
  String passwordRepeat = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "settingsAccountInformationPassword".tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 02.h),
          Text(
            "passwordPageSubtitle".tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 05.h),
          const Spacer(),
          CustomTextFormField(
            isPassword: true,
            onChanged: (value) {
              EasyDebounce.debounce(
                'emailAvailable',
                const Duration(milliseconds: 250),
                () {
                  if (password != value) {
                    setState(() {
                      password = value;
                    });
                  }
                },
              );
            },
            labelText: "passwordPagePasswordLabel".tr(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "textInputErrorEmpty".tr();
              } else if (value.length < 8) {
                return 'passwordPageErrorMinLenght'.tr();
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 02.h),
          CustomTextFormField(
            isPassword: true,
            onChanged: (value) {
              EasyDebounce.debounce(
                'emailAvailable',
                const Duration(milliseconds: 250),
                () {
                  if (passwordRepeat != value) {
                    setState(() {
                      passwordRepeat = value;
                    });
                  }
                },
              );
            },
            labelText: "passwordPageRepeatPasswordLabel".tr(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "textInputErrorEmpty".tr();
              } else if (value != password) {
                return 'passwordPageErrorNotEqual'.tr();
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 05.h),
          CustomBigButton(
            label: "passwordPageButtonLabel".tr(),
            onTap: () {
              if (_formKey.currentState!.validate()) {
                widget.onNext.call(password);
              }
            },
          ),
          const Spacer(flex: 9),
        ],
      ),
    );
  }
}
