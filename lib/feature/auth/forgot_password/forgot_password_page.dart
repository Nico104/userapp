import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../pets/profile_details/widgets/custom_textformfield.dart';
import '../../../general/utils_theme/custom_colors.dart';
import '../../../general/utils_theme/custom_text_styles.dart';
import '../auth_widgets.dart';
import 'forgot_password_status.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    super.key,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  int _statusCode = 0;

  void _updateEmail() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return ForgotPasswordStatus(
            email: _email.text,
            onUnexcpectedError: () {
              _statusCode = 1;
            },
            onSuccess: () {
              _statusCode = 0;
            },
            onInvalidEmail: () {
              _statusCode = 2;
            },
            onNoUserFound: () {
              _statusCode = 3;
            },
          );
        }).then((value) {
      if (_statusCode != 0) {
        setState(() {
          _email.text = '';
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
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "forgotPassword".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 02.h),
              Text(
                "forgotPasswordText1".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 05.h),
              CustomTextFormField(
                textEditingController: _email,
                labelText: "loginPageEmailInputLabel".tr(),
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
                label: "forgotPasswordButtonLabel1".tr(),
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
