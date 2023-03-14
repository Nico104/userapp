import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../pet_color/hex_color.dart';
import '../../styles/text_styles.dart';
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
  TextEditingController email = TextEditingController();

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
          SizedBox(height: 09.h),
          TextFormField(
            controller: email,
            cursorColor: Colors.black.withOpacity(0.74),
            decoration: InputDecoration(
              suffixIcon: getEmailIcon(email.text, _emailAvailable),
              // errorText: _emailErrorMsg,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.5,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 22.0, horizontal: 14.0),
              labelText: "Email",
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
            ),
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
                },
              );
            },
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
            child: GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  widget.onNext.call(email.text);
                  // signUpUser(email.text, password.text).then((successFullSignUp) {
                  //   if (successFullSignUp) {
                  //     login(email.text, password.text, true).then(
                  //       (loginSuccessfull) {
                  //         if (loginSuccessfull) {
                  //           Navigator.of(context)
                  //               .popUntil((route) => route.isFirst);
                  //           widget.reloadInitApp.call();
                  //         } else {}
                  //       },
                  //     );
                  //   }
                  // });
                }
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: HexColor("8F8FFF"),
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                    // strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: Center(
                    child: Text(
                  "Sign Up",
                  style: loginButton,
                )),
              ),
            ),
          ),
          SizedBox(height: 07.h),
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36),
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
          SizedBox(height: 03.h),
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

class SocialMediaContainer extends StatelessWidget {
  const SocialMediaContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1.5,
          color: Colors.black,
          // strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 0,
            blurRadius: 0,
            offset: Offset(3, 3),
          ),
        ],
      ),
    );
  }
}
