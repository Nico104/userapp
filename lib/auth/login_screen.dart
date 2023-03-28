import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/auth/sign_up_screen/sign_up_screen.dart';
import 'package:userapp/auth/u_auth.dart';
import 'package:userapp/pet_color/hex_color.dart';

import '../pets/profile_details/widgets/custom_textformfield.dart';
import '../styles/text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.reloadInitApp});

  final VoidCallback reloadInitApp;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController email = TextEditingController();
  // TextEditingController password = TextEditingController();

  String emailText = "";
  String passwordText = "";

  String? _emailErrorMsg;
  String? _passwordErrorMsg;

  bool _rememberMe = true;

  bool _obscurePassword = true;

  // @override
  // void dispose() {
  //   email.dispose();
  //   password.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // const Align(
          //   alignment: Alignment(0, 0.97),
          //   child: SizedBox(
          //     height: 450,
          //     child: RiveAnimation.asset(
          //       'assets/Animations/girl_and_dog.riv',
          //       fit: BoxFit.cover,
          //       alignment: Alignment(0.85, 0),
          //     ),
          //   ),
          // ),
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              height: 100.h,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 76, 28, 28),
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
                    SizedBox(height: 04.h),
                    CustomTextFormFieldActive(
                      onChanged: (value) {
                        EasyDebounce.debounce(
                          'emailLoginPage',
                          const Duration(milliseconds: 250),
                          () {
                            if (emailText != value) {
                              setState(() {
                                emailText = value;
                              });
                            }
                          },
                        );
                      },
                      errorText: _emailErrorMsg,
                      labelText: "Email",
                    ),
                    SizedBox(height: 02.h),
                    CustomTextFormFieldActive(
                      isPassword: true,
                      onChanged: (value) {
                        EasyDebounce.debounce(
                          'passwordLoginPage',
                          const Duration(milliseconds: 250),
                          () {
                            if (passwordText != value) {
                              setState(() {
                                passwordText = value;
                              });
                            }
                          },
                        );
                      },
                      errorText: _passwordErrorMsg,
                      labelText: "Password",
                    ),
                    SizedBox(height: 02.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              _rememberMe = !_rememberMe;
                            });
                          },
                          child: RememberMe(rememberMe: _rememberMe),
                        ),
                        Text("Forgot Password", style: loginForgotPassword),
                      ],
                    ),
                    SizedBox(height: 05.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 36, right: 36),
                      child: GestureDetector(
                        onTap: () {
                          login(emailText, passwordText, _rememberMe).then(
                            (value) {
                              if (value) {
                                setState(() {
                                  _emailErrorMsg = null;
                                  _passwordErrorMsg = null;
                                });
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
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
                              width: 1,
                              color: Colors.black.withOpacity(0.16),
                              // strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.16),
                                blurRadius: 6,
                                offset: const Offset(1, 3),
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
                    SizedBox(height: 05.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 36, right: 36),
                      child: Opacity(
                        opacity: 0.28,
                        child: Row(
                          children: [
                            const Expanded(
                                child:
                                    Divider(color: Colors.black, thickness: 1)),
                            SizedBox(width: 03.w),
                            Text(
                              "or continue with",
                              style: loginContinueWith,
                            ),
                            SizedBox(width: 03.w),
                            const Expanded(
                                child:
                                    Divider(color: Colors.black, thickness: 1)),
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
                    SizedBox(height: 03.h),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member? ",
                          style: loginNotAMembner,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(
                                  reloadInitApp: () => widget.reloadInitApp(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Register now",
                            style: loginSignUp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.black.withOpacity(0.16),
          // strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 6,
            offset: const Offset(1, 3),
          ),
        ],
      ),
    );
  }
}

class RememberMe extends StatelessWidget {
  const RememberMe({super.key, required this.rememberMe});

  final bool rememberMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 22,
          width: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: rememberMe ? Colors.lightBlue.shade200 : Colors.white,
            border: Border.all(
              width: 0.5,
              color: Colors.black,
              // strokeAlign: BorderSide.strokeAlignOutside,
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                spreadRadius: 0,
                blurRadius: 3,
                offset: Offset(0.5, 1.5),
              ),
            ],
          ),
          child: rememberMe
              ? const Icon(
                  Icons.check,
                  size: 20,
                  color: Colors.black,
                )
              : null,
        ),
        const SizedBox(width: 8),
        Text("Remember Me", style: loginForgotPassword),
      ],
    );
  }
}
