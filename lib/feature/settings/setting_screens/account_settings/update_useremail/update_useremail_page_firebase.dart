import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/feature/auth/auth_widgets.dart';
import 'package:userapp/feature/settings/setting_screens/account_settings/update_useremail/update_useremail_status.dart';

import '../../../../auth/u_auth.dart';
import '../../../../pets/profile_details/widgets/custom_textformfield.dart';
import '../../../../../general/utils_theme/custom_colors.dart';
import '../../../../../general/utils_theme/custom_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';

class UpdateUseremailFirebasePage extends StatefulWidget {
  const UpdateUseremailFirebasePage({
    super.key,
    // required this.nextStep,
    // required this.newEmail,
  });

  // final VoidCallback nextStep;
  // final String newEmail;

  @override
  State<UpdateUseremailFirebasePage> createState() =>
      _UpdateUseremailFirebasePageState();
}

class _UpdateUseremailFirebasePageState
    extends State<UpdateUseremailFirebasePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _currentPassword = TextEditingController();
  // String? errorText;

  int _statusCode = 0;

  void _updateEmail() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return UpdateEmailStatus(
            currentPassword: _currentPassword.text,
            newEmail: _email.text,
            onUnexcpectedError: () {
              _statusCode = 1;
            },
            onWrongPassword: () {
              _statusCode = 2;
            },
            onSuccess: () {
              _statusCode = 0;
            },
          );
        }).then((value) {
      if (_statusCode == 1) {
        setState(() {
          _currentPassword.text = '';
          _email.text = '';
        });
      } else if (_statusCode == 2) {
        setState(() {
          _currentPassword.text = '';
        });
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "updateEmailTitle".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 02.h),
              Text(
                "updateEmailDescription".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 05.h),
              CustomTextFormField(
                isPassword: true,
                textEditingController: _currentPassword,
                labelText: "updateEmailCurrentPasswordLabel".tr(),
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
              SizedBox(height: 04.h),
              CustomTextFormField(
                textEditingController: _email,
                labelText: "updateEmailNewEmailLabel".tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "textInputErrorEmpty".tr();
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 24),
              CustomBigButton(
                label: "updateEmailChangeEmailLabel".tr(),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _updateEmail();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
