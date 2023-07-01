import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:userapp/auth/sign_up_screen/sign_up_screen.dart';
import 'package:userapp/auth/u_auth.dart';
import 'package:userapp/pet_color/hex_color.dart';
import 'package:userapp/theme/custom_text_styles.dart';
import 'package:userapp/utils/util_methods.dart';

import '../init_app.dart';
import '../pets/profile_details/widgets/custom_textformfield.dart';
import '../styles/text_styles.dart';
import '../theme/custom_colors.dart';
import 'auth_widgets.dart';
import 'forgot_password/forgot_password_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // final VoidCallback reloadInitApp;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String emailText = "";
  String passwordText = "";

  String? _emailErrorMsg;
  String? _passwordErrorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height: 02.h),
                    Text(
                      "It's time to log in and get\nthis paw-ty started.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 04.h),
                    CustomTextFormField(
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
                    CustomTextFormField(
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
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            navigatePerSlide(
                              context,
                              const ForgotPasswordPage(),
                            );
                          },
                          child: Text(
                            "Forgot Password",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 05.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 36, right: 36),
                      child: CustomBigButton(
                        label: "Sign In",
                        onTap: () {
                          //Loading Dialog Thingy
                          BuildContext? dialogContext;
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isDismissible: false,
                            builder: (buildContext) {
                              dialogContext = buildContext;
                              return Container(
                                margin:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 32),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: const SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          );

                          signInWithEmailPassword(
                                  email: emailText, password: passwordText)
                              .then(
                            (user) {
                              Navigator.pop(dialogContext!);
                              if (user != null) {
                                setState(() {
                                  _emailErrorMsg = null;
                                  _passwordErrorMsg = null;
                                });
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                navigateReplacePerSlide(
                                    context, const InitApp());
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
                      ),
                    ),
                    SizedBox(height: 05.h),
                    const ContinueWithSocialMedia(
                        // reloadInitApp: widget.reloadInitApp,
                        ),
                    const Spacer(),
                    FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (BuildContext context,
                          AsyncSnapshot<PackageInfo> snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Version: ${snapshot.data!.version}",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            "error loading version",
                            style: Theme.of(context).textTheme.labelSmall,
                          );
                        } else {
                          //Loading
                          return Text(
                            "Loading Version",
                            style: Theme.of(context).textTheme.labelSmall,
                          );
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member? ",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => SignUpScreen(
                            //       reloadInitApp: () => widget.reloadInitApp(),
                            //     ),
                            //   ),
                            // );
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            navigateReplacePerSlide(
                              context,
                              const SignUpScreen(
                                  // reloadInitApp: () => widget.reloadInitApp(),
                                  ),
                            );
                          },
                          child: Text(
                            "Register now",
                            style: getCustomTextStyles(context)
                                .authRegisterNowAction,
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
            color: rememberMe
                ? getCustomColors(context).accentLight
                : Colors.white,
            border: Border.all(
              width: 0.5,
              color: getCustomColors(context).hardBorder ?? Colors.transparent,
              // strokeAlign: BorderSide.strokeAlignOutside,
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: kElevationToShadow[2],
          ),
          child: rememberMe
              ? const Icon(
                  Icons.check,
                  size: 20,
                )
              : null,
        ),
        const SizedBox(width: 8),
        Text("Remember Me", style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
