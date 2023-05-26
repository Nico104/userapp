import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../pets/profile_details/widgets/custom_textformfield.dart';
import '../../../../theme/custom_colors.dart';
import '../../../../theme/custom_text_styles.dart';
import 'forgot_password_status.dart';

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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              "Forgot Password",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 02.h),
            Text(
              "Please enter the email connected to your account",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 05.h),
            CustomTextFormField(
              textEditingController: _email,
              labelText: "Email",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'I cannot be empty mate';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _updateEmail();
                }
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                backgroundColor: getCustomColors(context).accent,
                side: BorderSide(
                  width: 0.5,
                  color: getCustomColors(context).lightBorder ??
                      Colors.transparent,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Change Email",
                style:
                    getCustomTextStyles(context).dataEditDialogButtonSaveStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
