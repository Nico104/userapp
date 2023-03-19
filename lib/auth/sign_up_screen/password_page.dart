import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../pet_color/hex_color.dart';
import '../../styles/text_styles.dart';

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
  TextEditingController password = TextEditingController();
  TextEditingController passwordRepeat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Password",
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
          const Spacer(),
          TextFormField(
            controller: password,
            cursorColor: Colors.black.withOpacity(0.74),
            decoration: InputDecoration(
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
              labelText: "Password",
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'I cannot be empty mate';
              } else if (value.length < 8) {
                return 'I must be at least 8 characters mate';
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 02.h),
          TextFormField(
            controller: passwordRepeat,
            cursorColor: Colors.black.withOpacity(0.74),
            decoration: InputDecoration(
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
              labelText: "Repeat Password",
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'I cannot be empty mate';
              } else if (value != password.text) {
                return 'I must be the equal to the other password mate';
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 05.h),
          Padding(
            padding: const EdgeInsets.only(left: 36, right: 36),
            child: GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  widget.onNext.call(password.text);
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
                  "Continue",
                  style: loginButton,
                )),
              ),
            ),
          ),
          const Spacer(flex: 9),
        ],
      ),
    );
  }
}
