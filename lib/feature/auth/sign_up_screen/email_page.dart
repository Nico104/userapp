import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../pets/profile_details/widgets/custom_textformfield.dart';

import '../auth_widgets.dart';
import '../u_auth.dart';

class SignUpEmailPage extends StatefulWidget {
  const SignUpEmailPage({
    super.key,
    // required this.reloadInitApp,
    required this.onNext,
  });

  // final VoidCallback reloadInitApp;
  final Function(String) onNext;

  @override
  State<SignUpEmailPage> createState() => _SignUpEmailPageState();
}

class _SignUpEmailPageState extends State<SignUpEmailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _emailAvailable = false;
  // bool _emailAvailable = true;
  // TextEditingController email = TextEditingController();

  String emailText = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "emailPageTitle".tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 02.h),
          Text(
            "emailPageSubTitle".tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 05.h),
          CustomTextFormField(
            onChanged: (value) {
              EasyDebounce.debounce(
                'emailAvailable',
                const Duration(milliseconds: 250),
                () async {
                  bool available = await isUseremailAvailable(value);
                  if (available) {
                    setState(() {
                      _emailAvailable = true;
                    });
                  } else {
                    setState(() {
                      _emailAvailable = false;
                    });
                  }
                  if (emailText != value) {
                    setState(() {
                      emailText = value;
                    });
                  }
                },
              );
            },
            labelText: "emialPageInputLabel".tr(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "textInputErrorEmpty".tr();
              } else {
                if (validEmail(value)) {
                  if (_emailAvailable) {
                    return null;
                  } else {
                    return 'emailPageEmailTaken'.tr();
                  }
                } else {
                  return 'emailPageEmailInvalid'.tr();
                }
              }
            },
          ),
          SizedBox(height: 05.h),
          CustomBigButton(
            label: "emailPageContinueLabel".tr(),
            onTap: () {
              if (_formKey.currentState!.validate()) {
                widget.onNext.call(emailText);
              }
            },
          ),
          SizedBox(height: 05.h),
          const ContinueWithSocialMedia(),
        ],
      ),
    );
  }
}

Widget? getEmailIcon(String emailtext, bool isAvailable) {
  if (emailtext.isNotEmpty && validEmail(emailtext)) {
    if (isAvailable) {
      return const Icon(Icons.check);
    } else {
      return const Icon(Icons.cancel);
    }
  } else {
    return null;
  }
}

bool validEmail(String email) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}
