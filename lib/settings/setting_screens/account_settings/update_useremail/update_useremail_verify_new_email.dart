import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:userapp/auth/sign_up_screen/email_page.dart';

import '../../../../auth/u_auth.dart';
import '../../../../pets/profile_details/widgets/custom_textformfield.dart';
import '../../../../theme/custom_colors.dart';
import '../../../../theme/custom_text_styles.dart';

class UpdateUseremailVerifyNewEmail extends StatefulWidget {
  const UpdateUseremailVerifyNewEmail({super.key, required this.nextStep});

  final Function(String) nextStep;

  @override
  State<UpdateUseremailVerifyNewEmail> createState() =>
      _UpdateUseremailVerifyNewEmailState();
}

class _UpdateUseremailVerifyNewEmailState
    extends State<UpdateUseremailVerifyNewEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _emailAvailable = false;
  String _emailText = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text("Verify new Email"),
          const SizedBox(height: 24),
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
                  if (_emailText != value) {
                    setState(() {
                      _emailText = value;
                    });
                  }
                },
              );
            },
            labelText: "New Email",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'I cannot be empty mate';
              } else {
                if (validEmail(value)) {
                  if (_emailAvailable) {
                    return null;
                  } else {
                    return 'Email already taken';
                  }
                } else {
                  return 'I somehow am not a valid email mate';
                }
              }
            },
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                sendVerificationEmail(_emailText);
                widget.nextStep(_emailText);
              }
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
              backgroundColor: getCustomColors(context).accent,
              side: BorderSide(
                width: 0.5,
                color:
                    getCustomColors(context).lightBorder ?? Colors.transparent,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Verify Email",
              style: getCustomTextStyles(context).dataEditDialogButtonSaveStyle,
            ),
          ),
        ],
      ),
    );
  }
}
