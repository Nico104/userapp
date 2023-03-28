import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../pet_color/hex_color.dart';
import '../../pets/profile_details/widgets/custom_textformfield.dart';
import '../../styles/text_styles.dart';
import '../auth_widgets.dart';
import '../login_screen.dart';
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
  // TextEditingController email = TextEditingController();

  String emailText = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Tail-waggingly happy\nto see you!",
            textAlign: TextAlign.center,
            style: loginTitle1,
          ),
          SizedBox(height: 02.h),
          Text(
            "It's time to sign up and get\nthis paw-ty started.",
            textAlign: TextAlign.center,
            style: loginTitle2,
          ),
          SizedBox(height: 05.h),
          CustomTextFormFieldActive(
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
            labelText: "Email",
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
          SizedBox(height: 05.h),
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36),
            child: CustomBigButton(
              label: "Continue",
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  widget.onNext.call(emailText);
                }
              },
            ),
          ),
          SizedBox(height: 05.h),
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36),
            child: Opacity(
              opacity: 0.28,
              child: Row(
                children: [
                  const Expanded(
                      child: Divider(color: Colors.black, thickness: 1)),
                  SizedBox(width: 03.w),
                  Text(
                    "or continue with",
                    style: loginContinueWith,
                  ),
                  SizedBox(width: 03.w),
                  const Expanded(
                      child: Divider(color: Colors.black, thickness: 1)),
                ],
              ),
            ),
          ),
          SizedBox(height: 02.h),
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SocialMediaContainer(),
                SocialMediaContainer(),
                SocialMediaContainer(),
              ],
            ),
          ),
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
