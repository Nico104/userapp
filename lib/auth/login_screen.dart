import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/auth/u_auth.dart';
import 'package:userapp/pet_color/hex_color.dart';

import '../styles/text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.reloadInitApp});

  final VoidCallback reloadInitApp;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String? _emailErrorMsg;
  String? _passwordErrorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FFFF8F"),
      body: Stack(
        children: [
          const Align(
            alignment: Alignment(0, 0.97),
            child: SizedBox(
              height: 450,
              child: RiveAnimation.asset(
                'assets/Animations/girl_and_dog.riv',
                fit: BoxFit.cover,
                alignment: Alignment(0.85, 0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 42, 28, 28),
            child: Column(
              children: [
                Text(
                  "Tail-waggingly happy\nto see you!",
                  textAlign: TextAlign.center,
                  style: loginTitle1,
                ),
                SizedBox(height: 02.h),
                Text(
                  "It's time to log in and get\nthis paw-ty started.",
                  textAlign: TextAlign.center,
                  style: loginTitle2,
                ),
                SizedBox(height: 09.h),
                TextFormField(
                  controller: email,
                  cursorColor: Colors.black.withOpacity(0.74),
                  decoration: InputDecoration(
                    errorText: _emailErrorMsg,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 22.0, horizontal: 14.0),
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
                  onTap: () {
                    setState(() {
                      _emailErrorMsg = null;
                    });
                  },
                ),
                SizedBox(height: 02.h),
                TextFormField(
                  controller: password,
                  cursorColor: Colors.black.withOpacity(0.74),
                  decoration: InputDecoration(
                    errorText: _passwordErrorMsg,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 22.0, horizontal: 14.0),
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
                  onTap: () {
                    setState(() {
                      _passwordErrorMsg = null;
                    });
                  },
                ),
                SizedBox(height: 02.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forgot Password", style: loginForgotPassword),
                  ],
                ),
                SizedBox(height: 05.h),
                Padding(
                  padding: const EdgeInsets.only(left: 36, right: 36),
                  child: GestureDetector(
                    onTap: () {
                      login(email.text, password.text).then(
                        (value) {
                          if (value) {
                            setState(() {
                              _emailErrorMsg = null;
                              _passwordErrorMsg = null;
                            });
                            widget.reloadInitApp.call();
                          } else {
                            print("wrong credentials");
                            setState(() {
                              _emailErrorMsg = "This doesnt seem right";
                              _passwordErrorMsg =
                                  "Are you sure? Cause I am not";
                            });
                          }
                        },
                      );
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
                        "Sign In",
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
                SizedBox(height: 03.h),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member? ",
                      style: loginNotAMembner,
                    ),
                    Text(
                      "Register now",
                      style: loginSignUp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
